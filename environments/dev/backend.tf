terraform {
  backend "azurerm" {
    resource_group_name  = "backendrak-rg"
    storage_account_name = "rakeshtfstg"
    container_name       = "tfstatefile"
    key                  = "devgha.terraform.tfstate"

  }
}