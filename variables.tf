variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "francecentral"
}

variable "resource_group_name_prefix" {
  description = "Prefix of the resource group name"
  type        = string
  default     = "ECF-rg"
}

variable "node_count" {
  description = "The initial quantity of nodes for the node pool"
  type        = number
  default     = 2
}

variable "username" {
  description = "The admin username for the new cluster"
  type        = string
  default     = "azureadmin"
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
  type        = string
  default     = "Standard_B2s"
}