resource "azurerm_dashboard_grafana" "this" {
  name                              = var.grafana_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = false
  public_network_access_enabled     = true
  sku                               = "Standard"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
