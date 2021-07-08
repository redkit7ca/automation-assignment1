resource "azurerm_log_analytics_workspace" "log-ana-work" {
  name                = "log-ana-work"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = "vault"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  soft_delete_enabled = true
}

resource "azurerm_storage_account" "storage_acc" {
    name = "storageacc"
    resource_group_name = var.rg_name
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "stor_blob" {
  name                   = "stor_blob"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
#   source                 = "some-local-file.zip"
}

