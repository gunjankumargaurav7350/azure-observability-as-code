resource "azurerm_monitor_activity_log_alert" "alerts" {
  for_each = var.activity_alerts

  name                = each.key
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = each.value.description

  criteria {
    category       = each.value.category
    operation_name = lookup(each.value, "operation_name", null)
    level          = lookup(each.value, "level", "Informational")
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}
