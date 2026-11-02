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
  subscription_id = "4357d322-f809-4095-ab52-cf255e9d4013"
  client_id       = "59c80110-4d9e-4e6f-9fb8-2d0df9a235e8"
  client_secret   = "IlV8Q~lY7Sfk6X2OOhujEvtga17TGsTa5B8SqdhT"
  tenant_id       = "f7f8f35a-0112-400d-b13a-0d808e2c4310"
}