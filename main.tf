terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.35.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "36e7faf6-f964-4e35-be75-485c95f44648"
}

module "resource_group" {
  source              = "./modules/resourcegroup"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source = "./modules/network"
  resource_group_name = var.resource_group_name
  location = var.location

  virtual_network_name                = var.virtual_network_name
  public_subnet_name                  = var.public_subnet_name
  private_subnet_name                 = var.private_subnet_name
  public_network_security_group_name  = var.public_network_security_group_name
  private_network_security_group_name = var.private_network_security_group_name
  public_route_table_name             = var.public_route_table_name
  private_route_table_name            = var.private_route_table_name

  nat_gateway_name                    = var.nat_gateway_name
  nat_ip_name                         = var.nat_ip_name
}

module "compute" {
  source = "./modules/compute"
  resource_group_name = var.resource_group_name
  location = var.location

  # Pass subnet IDs from the network module to the compute module
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id

  public_vm_ip_name              = var.public_vm_ip_name
  public_network_interface_name  = var.public_network_interface_name
  private_network_interface_name = var.private_network_interface_name

  public_virtual_machine_name  = var.public_virtual_machine_name
  private_virtual_machine_name = var.private_virtual_machine_name
  public_os_disk_name          = var.public_os_disk_name
  private_os_disk_name         = var.private_os_disk_name

  public_ip_address_allocation_name  = var.public_ip_address_allocation_name
  private_ip_address_allocation_name = var.private_ip_address_allocation_name
}
