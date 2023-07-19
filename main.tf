resource "azurerm_resource_group" "main" {
  name     = "main-${var.environment}-rg"
  location = "West Europe"
}

module "main_vnet" {
  source = "./vnet"

  resource_group_name     = azurerm_resource_group.main.name
  resource_group_location = azurerm_resource_group.main.location
  hub_vnet_address_space  = "10.0.0.0/16"
  main_vnet_address_space = "10.1.0.0/16"
  ddos_pp_enabled         = true
}