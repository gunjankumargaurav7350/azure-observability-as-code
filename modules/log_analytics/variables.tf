variable "workspace_name" { type = string }
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "sku" {
  type    = string
  default = "PerGB2018"
}
variable "retention_in_days" {
  type    = number
  default = 90
}
variable "solutions" {
  type = map(object({
    publisher = string
    product   = string
  }))
  default = {
    "SecurityInsights" = {
      publisher = "Microsoft"
      product   = "OMSGallery/SecurityInsights"
    },
    "ContainerInsights" = {
      publisher = "Microsoft"
      product   = "OMSGallery/ContainerInsights"
    }
  }
  description = "Log Analytics solutions enabled via for_each"
}
variable "tags" {
  type    = map(string)
  default = {}
}
