output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Nom du Resource Group"
}

output "kubernetes_cluster_name" {
  value       = azurerm_kubernetes_cluster.k8s.name
  description = "Nom du cluster AKS"
}

output "function_app_name" {
  value       = azurerm_linux_function_app.application_function.name
  description = "Nom de l'Azure Function App"
}

output "function_app_url" {
  value       = azurerm_linux_function_app.application_function.default_hostname
  description = "URL de l'Azure Function App"
}

output "storage_account_name" {
  value       = azurerm_storage_account.stockage_function.name
  description = "Nom du Storage Account"
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.k8s.kube_config_raw
  description = "Configuration kubectl pour se connecter au cluster"
  sensitive   = true
}
