variable "resource_group_name" {
  default = "my_assessment_rg"
}
variable "location" {
  default = "East US"
}
variable "virtual_network_name" {
  default = "my_assessment_vnet"
}
variable "public_subnet_name" {
  default = "public_subnet"
}
variable "private_subnet_name" {
  default = "private_subnet"
}
variable "public_network_security_group_name" {
  default = "public_nsg"
}
variable "private_network_security_group_name" {
  default = "private_nsg"
}
variable "public_route_table_name" {
  default = "public_rt"
}
variable "private_route_table_name" {
  default = "private_rt"
}
variable "nat_ip_name" {
  default = "NAT-Ip"
}
variable "nat_gateway_name" {
  default = "VNet-NAT"
}