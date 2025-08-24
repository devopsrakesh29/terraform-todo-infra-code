resource "azurerm_storage_account" "azurerm_storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier # e.g., "Standard"
  account_replication_type = var.account_replication_type #  GRS
  tags                     = var.tags

 
  
}


