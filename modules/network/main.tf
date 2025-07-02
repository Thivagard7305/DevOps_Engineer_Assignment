resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "public" {
  name                 = var.public_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "private" {
  name                 = var.private_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  default_outbound_access_enabled = false # To block internet access to private subnet
}

# NSG for Public Subnet
resource "azurerm_network_security_group" "nsg_public" {
  name                = var.public_network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# NSG for Private Subnet - Only allows from public subnet
resource "azurerm_network_security_group" "nsg_private" {
  name                = var.private_network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH-From-Public"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = azurerm_subnet.public.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.private.address_prefixes[0]
  }

  security_rule {
    name                       = "Allow-HTTP-From-Public"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = azurerm_subnet.public.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.private.address_prefixes[0]
  }

  security_rule {
    name                       = "Allow-HTTPS-From-Public"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = azurerm_subnet.public.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.private.address_prefixes[0]
  }
}

# Associate NSGs to Subnets
resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.nsg_public.id
}

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.nsg_private.id
}

# Route tables
resource "azurerm_route_table" "rt_public" {
  name                = var.public_route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_route_table" "rt_private" {
  name                = var.private_route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Route table associations
resource "azurerm_subnet_route_table_association" "assoc_public" {
  subnet_id      = azurerm_subnet.public.id
  route_table_id = azurerm_route_table.rt_public.id
}

resource "azurerm_subnet_route_table_association" "assoc_private" {
  subnet_id      = azurerm_subnet.private.id
  route_table_id = azurerm_route_table.rt_private.id
}

# NAT public Ip
resource "azurerm_public_ip" "nat_ip" {
  name                = var.nat_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#NAT Gateway
resource "azurerm_nat_gateway" "nat_gw" {
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

#NAT & Ip Association
resource "azurerm_nat_gateway_public_ip_association" "nat_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_ip.id
}

#NAT Subnet association
resource "azurerm_subnet_nat_gateway_association" "nat_sn_assoc" {
  subnet_id      = azurerm_subnet.private.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}