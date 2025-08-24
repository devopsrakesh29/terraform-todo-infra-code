
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count # 1
    vm_size    =  var.vm_size #"Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

