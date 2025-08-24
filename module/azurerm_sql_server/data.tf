data "azurerm_key_vault_secret" "db_username" {
  name         = "dbusername"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "db_password" {
  name         = "dbpassword"
  key_vault_id = data.azurerm_key_vault.kv.id
}


data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}