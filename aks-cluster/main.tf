resource "azurerm_user_assigned_identity" "main_aks" {
  name = "main-aks-identity"

  resource_group_name = var.resource_group_name
  tags = {
    "provisioner" = "Terraform"
    "environment" = var.environment
  }
}

resource "azurerm_role_assignment" "subnet_contributor" {
  name                                   = "subnet-network-contributor-role"
  role_definition_name                   = "Network Contributor"
  delegated_managed_identity_resource_id = azurerm_user_assigned_identity.main_aks.id
}

resource "azurerm_role_assignment" "dns_contributor" {
  name                                   = "subnet-network-contributor-role"
  role_definition_name                   = "DNS Zone Contributor"
  delegated_managed_identity_resource_id = azurerm_user_assigned_identity.main_aks.id
}

resource "azurerm_role_assignment" "pdns_contributor" {
  name                                   = "subnet-network-contributor-role"
  role_definition_name                   = "Private DNS Zone Contributor"
  delegated_managed_identity_resource_id = azurerm_user_assigned_identity.main_aks.id
}

resource "azurerm_key_vault" "aks_secrets_provider" {
  name = "main_aks_secrets_provider"

  resource_group_name             = var.resource_group_name
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  purge_protection_enabled        = true
  soft_delete_retention_days      = var.kv_retention_days
  sku_name                        = var.kv_sku_name
  public_network_access_enabled   = false

  tags = {
    "provisioner" = "Terraform"
    "environment" = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "main" {
  name = "main-${var.environment}-aks-cluster"

  # Resource group
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  # General
  kubernetes_version         = var.aks_k8s_version
  node_resource_group        = "main-${var.environment}-aks-cluster-node"
  oidc_issuer_enabled        = true
  sku_tier                   = var.aks_sku_tier
  workload_identity_enabled  = true
  dns_prefix_private_cluster = "main-${var.environment}-aks-cluster"

  # Node pool

  # RBAC

  # Networking
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  http_application_routing_enabled    = false

  # Secrets


  tags = {
    "provisioner" = "Terraform"
    "environment" = var.environment
  }
}