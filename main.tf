locals {
  environment = "prod"
  location    = "eastus"
  common_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Architect   = "Gunjan Kumar Gaurav"
    Tier        = "Observability-Mesh"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.environment}-observability"
  location = local.location
  tags     = local.common_tags
}

# 1. Log Analytics Workspace
module "log_analytics" {
  source              = "./modules/log_analytics"
  workspace_name      = "log-${local.environment}-central01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  retention_in_days   = 90
  tags                = local.common_tags
}

# 2. Action Groups (Notification channels with for_each)
module "action_groups" {
  source              = "./modules/action_groups"
  resource_group_name = azurerm_resource_group.rg.name

  action_groups = {
    "ag-devsecops-critical" = {
      short_name = "DevSecCrit"
      email_receivers = [
        {
          name          = "Lead-DevOps-Engineer"
          email_address = "gunjankumargaurav7@gmail.com"
        }
      ]
      webhook_receivers = [
        {
          name        = "PagerDuty-Integration"
          service_uri = "https://events.pagerduty.com/v2/enqueue"
        }
      ]
    },
    "ag-security-team" = {
      short_name = "SecTeam"
      email_receivers = [
        {
          name          = "SecOps-Center"
          email_address = "gunjankumargaurav7@gmail.com"
        }
      ]
    }
  }

  tags = local.common_tags
}

# 3. Security Activity Log Alerts
module "activity_alerts" {
  source              = "./modules/activity_alerts"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_resource_group.rg.id]
  action_group_id     = module.action_groups.action_group_ids["ag-devsecops-critical"]

  activity_alerts = {
    "alert-nsg-rule-deleted" = {
      description    = "Detects deletion of any network security group rule in the landing zone"
      category       = "Administrative"
      operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/delete"
      level          = "Warning"
    },
    "alert-rbac-role-assigned" = {
      description    = "Detects elevated privilege role assignments"
      category       = "Administrative"
      operation_name = "Microsoft.Authorization/roleAssignments/write"
      level          = "Informational"
    }
  }

  tags = local.common_tags
}

# 4. Azure Managed Grafana
module "grafana" {
  source              = "./modules/grafana"
  grafana_name        = "amg-${local.environment}-sre01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  tags                = local.common_tags
}
