output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Nom du Resource Group"
}

output "kubernetes_cluster_name" {
  value       = azurerm_kubernetes_cluster.k8s.name
  description = "Nom du cluster AKS"
}

output "function_app_name" {
  value       = azurerm_linux_function_app.function_app.name
  description = "Nom de l'Azure Function App"
}

output "function_app_url" {
  value       = azurerm_linux_function_app.function_app.default_hostname
  description = "URL de l'Azure Function App"
}

output "storage_account_name" {
  value       = azurerm_storage_account.function_storage.name
  description = "Nom du Storage Account"
}