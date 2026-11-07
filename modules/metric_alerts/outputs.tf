output "alert_ids" {
  description = "IDs of metric alerts provisioned via for_each"
  value       = { for k, v in azurerm_monitor_metric_alert.alerts : k => v.id }
}
