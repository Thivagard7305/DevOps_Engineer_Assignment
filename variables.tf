variable "resource_group_name" {
  description = "The name of the Azure Resource Group."
  type        = string
  default     = "my_assessment_rg"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}

variable "virtual_network_name" {
  description = "The name of the Virtual Network."
  type        = string
  default     = "my_assessment_vnet"
}

variable "public_subnet_name" {
  description = "The name of the public subnet within the VNet."
  type        = string
  default     = "public_subnet"
}

variable "private_subnet_name" {
  description = "The name of the private subnet within the VNet."
  type        = string
  default     = "private_subnet"
}

variable "public_network_security_group_name" {
  description = "The name of the Network Security Group for the public subnet."
  type        = string
  default     = "public_nsg"
}

variable "private_network_security_group_name" {
  description = "The name of the Network Security Group for the private subnet."
  type        = string
  default     = "private_nsg"
}

variable "public_route_table_name" {
  description = "The name of the Route Table for the public subnet."
  type        = string
  default     = "public_rt"
}

variable "private_route_table_name" {
  description = "The name of the Route Table for the private subnet."
  type        = string
  default     = "private_rt"
}

variable "public_vm_ip_name" {
  description = "The name for the public IP address of the public VM."
  type        = string
  default     = "pub_vm_ip"
}

variable "public_network_interface_name" {
  description = "The name for the public network interface."
  type        = string
  default     = "pub_nic"
}

variable "public_ip_address_allocation_name" {
  description = "The allocation method for the public IP address (must be 'Static' for Standard SKU)."
  type        = string
  default     = "Static"
}

variable "private_network_interface_name" {
  description = "The name for the private network interface."
  type        = string
  default     = "pvt_nic"
}

variable "private_ip_address_allocation_name" {
  description = "The allocation method for the private IP address."
  type        = string
  default     = "Dynamic"
}

variable "public_virtual_machine_name" {
  description = "The name for the public virtual machine."
  type        = string
  default     = "pub-vm"
}

variable "public_os_disk_name" {
  description = "The name for the OS disk of the public VM."
  type        = string
  default     = "pub_vm_disk"
}

variable "private_virtual_machine_name" {
  description = "The name for the private virtual machine."
  type        = string
  default     = "pvt-vm"
}

variable "private_os_disk_name" {
  description = "The name for the OS disk of the private VM."
  type        = string
  default     = "pvt_vm_disk"
}

variable "nat_ip_name" {
  description = "The name for the public IP address associated with the NAT Gateway."
  type        = string
  default     = "NAT-Ip"
}

variable "nat_gateway_name" {
  description = "The name for the NAT Gateway."
  type        = string
  default     = "VNet-NAT"
}