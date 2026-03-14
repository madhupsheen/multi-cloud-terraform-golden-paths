output "hub_vnet_id" {
  value = azurerm_virtual_network.hub_vnet.id
}

output "dev_spoke_vnet_id" {
  value = azurerm_virtual_network.dev_spoke.id
}

output "prod_spoke_vnet_id" {
  value = azurerm_virtual_network.prod_spoke.id
}