resource "azurerm_monitor_metric_alert" "alerts" {
  for_each = var.metric_alerts

  name                = each.key
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = each.value.description
  severity            = each.value.severity
  frequency           = each.value.frequency
  window_size         = each.value.window_size

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  action {
    action_group_id = var.action_group_id
  }

  tags = var.tags
}
