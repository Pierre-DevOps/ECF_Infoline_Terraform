# Configuration Terraform et providers nécessaires
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    # Provider officiel Azure pour gérer les ressources
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    # Provider Azure avancé pour la génération des clés SSH
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.5"
    }
  }
}

# Configuration du provider Azure
provider "azurerm" {
  features {}
  subscription_id = var.id_abonnement
}

