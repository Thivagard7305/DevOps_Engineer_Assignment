# main.tf for the compute module

# Public IP for the Public VM
resource "azurerm_public_ip" "public_vm_ip" {
  name                = var.public_vm_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_address_allocation_name
  sku                 = "Standard"
}

# Public Network Interface for Public VM
resource "azurerm_network_interface" "nic_public" {
  name                = var.public_network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.public_subnet_id # Use the input variable
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_vm_ip.id
  }
}

# Private Network Interface for Private VM
resource "azurerm_network_interface" "nic_private" {
  name                = var.private_network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.private_subnet_id # Use the input variable
    private_ip_address_allocation = "Dynamic"
  }
}

# Public Virtual Machine
resource "azurerm_virtual_machine" "public_vm" {
  name                  = var.public_virtual_machine_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic_public.id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = var.public_os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Adminuser"
    admin_username = "azureuser"
    admin_password = "Password1234!"
    custom_data = base64encode(<<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Hello from Public VM Nginx on Azure!</h1>" | sudo tee /var/www/html/index.nginx-debian.html
EOF
    )
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Private Virtual Machine
resource "azurerm_virtual_machine" "private_vm" {
  name                  = var.private_virtual_machine_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic_private.id]
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = var.private_os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Adminuser"
    admin_username = "azureuser"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}