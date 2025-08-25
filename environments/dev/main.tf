
locals {
  common_tags = {
    Environment = "dev"
    Owner       = "TodoAppTeam"
    ManagedBy   = "Terraform"
  }
}
module "resource_group" {
  source   = "../../module/azurerm_resource_group"
  for_each = var.resource_groups
  rg_name  = "todoinfra-rg"
  location = "centralindia"
  tags = local.common_tags
}

module "storage_account" {
  depends_on               = [module.resource_group]
  source                   = "../../module/azurerm_storage_account"
  storage_account_name     = "rakb35todoinfrastg"
  location                 = module.resource_group.rg_location
  rg_name                  = module.resource_group.rg_name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = local.common_tags

}

module "container_registry" {
  depends_on = [ module.resource_group ]
  source = "../../module/azurerm_container_registry"

  acr_name = "todorakacr"
  rg_name = module.resource_group.rg_name
  location = module.resource_group.rg_location
  tags = local.common_tags

}

module "aks" {
  source = "../../module/azurerm_kuberentes_services"
  depends_on = [ module.resource_group ]
  aks_name = "todorakaks"
  location = module.resource_group.rg_location
  rg_name = module.resource_group.rg_name
  dns_prefix = "todorakaksdns"
  aks_node_count = 1
  vm_size = "Standard_B2ms"
  tags = local.common_tags

}

module "key_vault" {
  source = "../../module/azurerm_key_vault"
  depends_on = [ module.resource_group ]
  kv_name = "rakeshtodokv"
  location = module.resource_group.rg_location
  rg_name = module.resource_group.rg_name
  tags = local.common_tags
  
}

module "azurerm_key_vault_secret" {
  source = "../../module/azurerm_key_vault_secret"
  depends_on = [ module.key_vault ]
  for_each = var.kv_secrets
  secret_name = each.value.secret_name
  secret_value = each.value.secret_value
  kv_name = module.key_vault.kv_name
  rg_name = module.resource_group.rg_name
   
}

module "sql_server" {
source = "../../module/azurerm_sql_server"
depends_on = [ module.azurerm_key_vault_secret ]
sql_server_name = "rakb35todosqlserver"
rg_name = module.resource_group.rg_name
location = module.resource_group.rg_location
tags = local.common_tags
kv_name = module.key_vault.kv_name

}