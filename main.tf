# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0" # Optional but recommended in production
    }
  }
  backend "azurerm" {
    resource_group_name  = "azdevstorage"
    storage_account_name = "azdevstorageman"
    container_name       = "devtfbe"
    key                  = "dev.terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "webapp-pmp" {
  name     = "${var.prefix}-rg-web4"
  location = var.location
}

resource "azurerm_service_plan" "webapp-pmp" {
  name                = "${var.prefix}-sp4"
  location            = azurerm_resource_group.webapp-pmp.location
  resource_group_name = azurerm_resource_group.webapp-pmp.name
  os_type             = "Windows"
  sku_name            = "F1"
}

resource "azurerm_windows_web_app" "webapp-pmp" {
  name                = "${var.prefix}-web4-f1"
  location            = azurerm_resource_group.webapp-pmp.location
  resource_group_name = azurerm_resource_group.webapp-pmp.name
  service_plan_id     = azurerm_service_plan.webapp-pmp.id

  site_config {
    always_on                               = false
  }
}