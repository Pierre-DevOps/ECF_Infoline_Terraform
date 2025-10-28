# Génération automatique de la paire de clés SSH
resource "azapi_resource_action" "generation_cle_ssh_publique" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.cle_ssh_publique.id
  action      = "generateKeyPair"
  method      = "POST"
  
  response_export_values = ["publicKey", "privateKey"]
}

# Ressource Azure pour stocker la clé publique
resource "azapi_resource" "cle_ssh_publique" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = "ssh-ecf-infoline"
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_resource_group.rg.id
}

# Output pour exposer la clé publique (sensible)
output "donnees_cle" {
  value     = azapi_resource_action.generation_cle_ssh_publique.output.publicKey
  sensitive = true
}

