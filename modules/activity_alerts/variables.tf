variable "resource_group_name" { type = string }
variable "scopes" { type = list(string) }
variable "action_group_id" { type = string }
variable "activity_alerts" {
  type = map(object({
    description    = string
    category       = string
    operation_name = optional(string)
    level          = optional(string, "Informational")
  }))
  description = "Security & administrative activity log alerts mapped via for_each"
}
variable "tags" {
  type    = map(string)
  default = {}
}
