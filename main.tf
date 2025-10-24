# Resource Group avec nom aléatoire
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
  
  tags = {
    Environment = "ECF"
    Project     = "Infoline"
    ManagedBy   = "Terraform"
  }
}

# Cluster AKS
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = "infoline-aks-${random_pet.rg_name.id}"
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "infoline-k8s"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = var.vm_size
    node_count = var.node_count
  }
  
  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
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

# Storage Account pour Azure Functions
resource "random_string" "storage_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "function_storage" {
  name                     = "infolinestore${random_string.storage_suffix.result}"
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

# App Service Plan pour Azure Functions
resource "azurerm_service_plan" "function_plan" {
  name                = "infoline-function-plan-${random_pet.rg_name.id}"
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
resource "azurerm_linux_function_app" "function_app" {
  name                = "infoline-auth-func-${random_pet.rg_name.id}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.function_plan.id

  site_config {
    application_stack {
      node_version = "18"
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