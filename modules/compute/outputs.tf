# outputs.tf for the compute module

output "public_virtual_machine_id" {
  description = "The ID of the public virtual machine."
  value       = azurerm_virtual_machine.public_vm.id
}

output "public_virtual_machine_name" {
  description = "The name of the public virtual machine."
  value       = azurerm_virtual_machine.public_vm.name
}

output "private_virtual_machine_id" {
  description = "The ID of the private virtual machine."
  value       = azurerm_virtual_machine.private_vm.id
}

output "private_virtual_machine_name" {
  description = "The name of the private virtual machine."
  value       = azurerm_virtual_machine.private_vm.name
}

output "public_vm_public_ip_address" {
  description = "The public IP address of the public virtual machine."
  value       = azurerm_public_ip.public_vm_ip.ip_address
}

output "public_network_interface_id" {
  description = "The ID of the public network interface."
  value       = azurerm_network_interface.nic_public.id
}

output "private_network_interface_id" {
  description = "The ID of the private network interface."
  value       = azurerm_network_interface.nic_private.id
}
