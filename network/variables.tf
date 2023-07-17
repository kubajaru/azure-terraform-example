#-------------RESOURCE GROUP ------------#
variable "resource_group_name" {
  type        = string
  description = "Name of resource group for network module"
  default     = null
}

variable "resource_group_location" {
  type        = string
  description = "Location of resource group for network module"
  default     = null
}

#---------------------------------------#

#------------ VIRTUAL NETWORK ----------#

variable "main_vnet_address_space" {
  type        = string
  description = "Address space of main virtual network"
  default     = null
}

variable "hub_vnet_address_space" {
  type        = string
  description = "Address space of hub virtual network"
  default     = null
}

#---------------------------------------#

#--------- DDOS PROTECTION PLAN --------#

variable "ddos_pp_enabled" {
  type        = bool
  description = "Is DDOS Protection Plan enabled"
  default     = false
}

#---------------------------------------#