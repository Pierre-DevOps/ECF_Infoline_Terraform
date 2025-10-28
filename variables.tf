# ID de l'abonnement Azure (obligatoire)
variable "id_abonnement" {
  description = "ID de l'abonnement Azure"
  type        = string
}

# Région de déploiement des ressources
variable "emplacement_groupe_ressources" {
  description = "Emplacement du groupe de ressources"
  type        = string
  default     = "switzerlandnorth"
}

# Nombre de nœuds dans le cluster Kubernetes
variable "nombre_noeuds" {
  description = "Quantité initiale de nœuds pour le pool de nœuds"
  type        = number
  default     = 2
}

# Nom d'utilisateur administrateur
variable "nom_utilisateur" {
  description = "Nom d'utilisateur administrateur pour le nouveau cluster"
  type        = string
  default     = "azureadmin"
}

# Taille des machines virtuelles
variable "taille_vm" {
  description = "Taille de la machine virtuelle"
  type        = string
  default     = "Standard_B2s"
}
