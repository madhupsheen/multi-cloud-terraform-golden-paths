resource "azurerm_resource_group" "network" {
  name     = var.resource_group_name
  location = var.location
}

# ---------------------
# HUB VNET
# ---------------------

resource "azurerm_virtual_network" "hub_vnet" {

  name                = "vnet-hub"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.0.0.0/16"]

}

# Hub Subnets

resource "azurerm_subnet" "firewall_subnet" {

  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.0.0/24"]

}

resource "azurerm_subnet" "management_subnet" {

  name                 = "ManagementSubnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "shared_services_subnet" {

  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.2.0/24"]

}

# ---------------------
# DEV SPOKE
# ---------------------

resource "azurerm_virtual_network" "dev_spoke" {

  name                = "vnet-dev-spoke"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.1.0.0/16"]

}

resource "azurerm_subnet" "dev_app_subnet" {

  name                 = "AppSubnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.dev_spoke.name
  address_prefixes     = ["10.1.1.0/24"]

}

# ---------------------
# PROD SPOKE
# ---------------------

resource "azurerm_virtual_network" "prod_spoke" {

  name                = "vnet-prod-spoke"
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = ["10.2.0.0/16"]

}

resource "azurerm_subnet" "prod_app_subnet" {

  name                 = "AppSubnet"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.prod_spoke.name
  address_prefixes     = ["10.2.1.0/24"]

}

# ---------------------
# VNET PEERING
# ---------------------

resource "azurerm_virtual_network_peering" "hub_to_dev" {

  name                      = "hub-to-dev"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.dev_spoke.id

}

resource "azurerm_virtual_network_peering" "dev_to_hub" {

  name                      = "dev-to-hub"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.dev_spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id

}

resource "azurerm_virtual_network_peering" "hub_to_prod" {

  name                      = "hub-to-prod"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.prod_spoke.id

}

resource "azurerm_virtual_network_peering" "prod_to_hub" {

  name                      = "prod-to-hub"
  resource_group_name       = azurerm_resource_group.network.name
  virtual_network_name      = azurerm_virtual_network.prod_spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id

}