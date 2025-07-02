# outputs.tf for the network module

output "virtual_network_name" {
  description = "The name of the created virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = azurerm_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet."
  value       = azurerm_subnet.private.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = azurerm_nat_gateway.nat_gw.id
}

output "nat_gateway_ip" {
  description = "The public IP address associated with the NAT Gateway."
  value       = azurerm_public_ip.nat_ip.ip_address
}

output "nat_ip_id" {
  description = "The ID of the public IP resource associated with the NAT Gateway."
  value       = azurerm_public_ip.nat_ip.id
}
