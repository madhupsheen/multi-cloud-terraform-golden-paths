variable "location" {
  description = "Azure location for resources"
  default     = "Australia East"
}

variable "hub_rg_name" {
  description = "Resource Group name for the hub"
  default     = "rg-hub"
}

variable "hub_vnet_name" {
  description = "Hub Virtual Network name"
  default     = "vnet-hub"
}