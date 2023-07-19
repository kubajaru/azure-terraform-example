resource "azurerm_network_ddos_protection_plan" "main" {
  name = "main-ddos-protection-plan"

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}

resource "azurerm_virtual_network" "main" {
  name = "main-vnet"

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  address_space = [var.main_vnet_address_space]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.main.id
    enable = var.ddos_pp_enabled
  }

  tags = {
    "provisioner" = "Terraform"
    "environment" = var.environment
  }
}

resource "azurerm_virtual_network" "hub" {
  name = "hub-vnet"

  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  address_space = [var.hub_vnet_address_space]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.main.id
    enable = var.ddos_pp_enabled
  }

  tags = {
    "provisioner" = "Terraform"
    "environment" = var.environment
  }
}

resource "azurerm_virtual_network_peering" "main_to_hub" {
  name = "main-to-hub-peering"

  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.main.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
}

resource "azurerm_virtual_network_peering" "hub_to_main" {
  name = "hub-to-main-peering"

  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.main.id
}