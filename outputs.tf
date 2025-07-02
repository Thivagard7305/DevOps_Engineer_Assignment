# Outputs for the root module

# Output the name and ID of the created resource group
output "resource_group_name" {
  description = "The name of the Azure Resource Group."
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "The ID of the Azure Resource Group."
  value       = module.resource_group.resource_group_id
}

# Outputs from the network module
output "virtual_network_name" {
  description = "The name of the virtual network."
  value       = module.network.virtual_network_name
}

output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = module.network.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet."
  value       = module.network.private_subnet_id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = module.network.nat_gateway_id
}

output "nat_gateway_ip_address" {
  description = "The public IP address associated with the NAT Gateway."
  value       = module.network.nat_gateway_ip
}

output "nat_ip_id" {
  description = "The ID of the public IP address associated with the NAT Gateway."
  value       = module.network.nat_ip_id
}

# Outputs from the compute module
output "public_virtual_machine_id" {
  description = "The ID of the public virtual machine."
  value       = module.compute.public_virtual_machine_id
}

output "private_virtual_machine_id" {
  description = "The ID of the private virtual machine."
  value       = module.compute.private_virtual_machine_id
}

output "public_vm_public_ip_address" {
  description = "The public IP address of the public virtual machine."
  value       = module.compute.public_vm_public_ip_address
}

output "public_network_interface_id" {
  description = "The ID of the public network interface."
  value       = module.compute.public_network_interface_id
}

output "private_network_interface_id" {
  description = "The ID of the private network interface."
  value       = module.compute.private_network_interface_id
}
