resource "azurerm_network_ddos_protection_plan" "main" {
  name = var.main_vnet_ddos_pp

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}

resource "azurerm_virtual_network" "main" {
  name = var.main_vnet_name

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  address_space = [var.main_vnet_address_space]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.main.id
    enable = var.ddos_pp_enabled
  }
}

resource "azurerm_subnet" "main" {
  name = var.main_subnet_name

  resource_group_name = var.resource_group_name
  
  address_prefixes    = [var.main_subnet_address_space]
  delegation {
    name = var.main_subnet_delegation_name
    service_delegation {
      name = 
    } 
  }
}