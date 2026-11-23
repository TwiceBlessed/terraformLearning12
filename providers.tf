terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "4357d322-f809-4095-ab52-cf224e2d1213"
  client_id       = "59c80110-4d9e-4e6f-9fb8-2d0df9a235e8"
  client_secret   = "qj_laina"
  tenant_id       = "f7f8f35a-0112-400d-b13a-0d808e2c4310"
}
