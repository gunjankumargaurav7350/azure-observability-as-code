output "action_group_ids" {
  description = "Map of action group names to their resource IDs"
  value       = { for k, v in azurerm_monitor_action_group.groups : k => v.id }
}
