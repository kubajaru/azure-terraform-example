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

variable "environment" {
  type        = string
  description = "General variable controlling diferent settings besed on environment"
  default     = null
}

#---------------------------------------#
