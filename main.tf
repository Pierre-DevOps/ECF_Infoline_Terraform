# Groupe de ressources avec un nom fixe
resource "azurerm_resource_group" "rg" {
  location = var.emplacement_groupe_ressources
  name     = "RG-ECF-Infoline"
  
  tags = {
    Environment = "ECF"
    Project     = "Infoline"
    ManagedBy   = "Terraform"
  }
}

# Cluster Kubernetes (AKS)
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = "infoline-aks-${azurerm_resource_group.rg.name}"
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "infoline-k8s"
  
  identity {
    type = "SystemAssigned"
  }
  
  default_node_pool {
    name       = "agentpool"
    vm_size    = var.taille_vm
    node_count = var.nombre_noeuds
  }
  
  linux_profile {
    admin_username = var.nom_utilisateur
    ssh_key {
      key_data = azapi_resource_action.generation_cle_ssh_publique.output.publicKey
    }
  }
  
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  
  tags = {
    Environment = "ECF"
    Project     = "Infoline"
    ManagedBy   = "Terraform"
  }
}

# Compte de stockage pour Azure Functions
resource "azurerm_storage_account" "stockage_function" {
  name                     = "infolineecf"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  tags = {
    Environment = "ECF"
    Project     = "Infoline"
    ManagedBy   = "Terraform"
  }
}

# Plan App Service pour Azure Functions
resource "azurerm_service_plan" "plan_function" {
  name                = "infoline-plan-${azurerm_resource_group.rg.name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "Y1"
  
  tags = {
    Environment = "ECF"
    Project     = "Infoline"
    ManagedBy   = "Terraform"
  }
}

# Azure Function App
resource "azurerm_linux_function_app" "application_function" {
  name                       = "infoline-auth-${azurerm_resource_group.rg.name}"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  storage_account_name       = azurerm_storage_account.stockage_function.name
  storage_account_access_key = azurerm_storage_account.stockage_function.primary_access_key
  service_plan_id            = azurerm_service_plan.plan_function.id
  
  site_config {
    application_stack {
      node_version = "20"
    }
  }
  
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "node"
  }
  
  tags = {
    Environment = "ECF"
    Project     = "Infoline"
    ManagedBy   = "Terraform"
  }
}

