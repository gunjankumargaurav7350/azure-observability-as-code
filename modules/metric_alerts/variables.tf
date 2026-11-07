variable "resource_group_name" { type = string }
variable "action_group_id" { type = string }
variable "metric_alerts" {
  type = map(object({
    scopes           = list(string)
    description      = string
    severity         = number
    frequency        = string
    window_size      = string
    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number
  }))
  description = "Metric alerts configuration mapped via for_each"
}
variable "tags" {
  type    = map(string)
  default = {}
}
