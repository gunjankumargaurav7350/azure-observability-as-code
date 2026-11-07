output "log_analytics_id" {
  description = "Log Analytics Workspace Resource ID"
  value       = module.log_analytics.workspace_id
}

output "action_group_ids" {
  description = "Provisioned Action Group IDs"
  value       = module.action_groups.action_group_ids
}

output "grafana_endpoint" {
  description = "Azure Managed Grafana Dashboard URL"
  value       = module.grafana.grafana_endpoint
}
