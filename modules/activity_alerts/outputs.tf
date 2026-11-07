output "activity_alert_ids" {
  value = { for k, v in azurerm_monitor_activity_log_alert.alerts : k => v.id }
}
