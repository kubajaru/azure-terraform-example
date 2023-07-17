output "main_virtual_network_id" {
  description = "ID of main virtual network"
  value       = azurerm_virtual_network.main.id
}

output "hub_virtual_network_id" {
  description = "ID of hub virtual network"
  value       = azurerm_virtual_network.hub.id
}

output "ddos_protection_plan_id" {
  description = "ID of DDOS protection plan"
  value       = azurerm_network_ddos_protection_plan.main.id
}
