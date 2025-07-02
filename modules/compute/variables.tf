# variables.tf for the compute module

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet to associate with the public NIC."
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet to associate with the private NIC."
  type        = string
}

variable "public_vm_ip_name" {
  description = "Name for the public IP address of the public VM."
  type        = string
}

variable "public_network_interface_name" {
  description = "Name for the public network interface."
  type        = string
}

variable "private_network_interface_name" {
  description = "Name for the private network interface."
  type        = string
}

variable "public_virtual_machine_name" {
  description = "Name for the public virtual machine."
  type        = string
}

variable "private_virtual_machine_name" {
  description = "Name for the private virtual machine."
  type        = string
}

variable "public_os_disk_name" {
  description = "Name for the OS disk of the public VM."
  type        = string
}

variable "private_os_disk_name" {
  description = "Name for the OS disk of the private VM."
  type        = string
}

variable "public_ip_address_allocation_name" {
  description = "Allocation method for the public IP address"
  type        = string
}

variable "private_ip_address_allocation_name" {
  description = "Allocation method for the private IP address"
  type        = string
}
