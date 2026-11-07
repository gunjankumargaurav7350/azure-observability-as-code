variable "resource_group_name" { type = string }
variable "action_groups" {
  type = map(object({
    short_name = string
    email_receivers = optional(list(object({
      name          = string
      email_address = string
    })), [])
    webhook_receivers = optional(list(object({
      name        = string
      service_uri = string
    })), [])
  }))
  description = "Action groups configured via for_each"
}
variable "tags" {
  type    = map(string)
  default = {}
}
