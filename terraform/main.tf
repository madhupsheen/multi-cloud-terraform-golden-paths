provider "azurerm" {
  features {}
}

# Resource Group for Hub
resource "azurerm_resource_group" "hub" {
  name     = var.hub_rg_name
  location = var.location
}

# Hub Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
}

# Example subnet
resource "azurerm_subnet" "hub_subnet" {
  name                 = "hub-subnet-01"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}