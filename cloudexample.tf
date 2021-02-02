provider "azurerm" {
    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    skip_provider_registration = true
    
    features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}



resource "azurerm_resource_group" "example" {
  name     = "adi-eus-devops-poc-rg"
  location = "westus"
}
resource "azurerm_key_vault" "example" {
  name                        = "keyvault000110"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 7
  tenant_id                   = var.tenant_id
  purge_protection_enabled    = false

  sku_name = "standard"
    
}

resource "azurerm_storage_account" "examplee" {
  name                     = "storage01testing01"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}



