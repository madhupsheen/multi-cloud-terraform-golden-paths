output "hub_resource_group_name" {
  description = "Name of the hub resource group"
  value       = azurerm_resource_group.hub.name
}

output "hub_vnet_id" {
  description = "ID of the hub virtual network"
  value       = azurerm_virtual_network.hub_vnet.id
}

output "hub_subnet_id" {
  description = "ID of the first hub subnet"
  value       = azurerm_subnet.hub_subnet.id
}