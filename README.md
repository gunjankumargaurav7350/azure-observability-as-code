# 📊 Enterprise Azure Observability as Code

[![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5.0-623CE4?style=for-the-badge&logo=terraform)](https://terraform.io)
[![Azure Monitor](https://img.shields.io/badge/Azure%20Monitor-Log%20Analytics%20%7C%20Alerts-0089D6?style=for-the-badge&logo=microsoftazure)](https://azure.microsoft.com)
[![Grafana](https://img.shields.io/badge/Grafana-Managed%20Dashboards%20as%20Code-F46800?style=for-the-badge&logo=grafana)](https://grafana.com)
[![Architecture Pattern](https://img.shields.io/badge/Pattern-for__each%20Declarative-success?style=for-the-badge)](https://developer.hashicorp.com)

Production-grade **Observability as Code** on **Microsoft Azure** architected by **Gunjan Kumar Gaurav** (Senior Cloud & DevSecOps Consultant). Automates the entire telemetry lifecycle: Log Analytics, multi-tier Action Groups, Metric Alerts, Activity Log Security Audits, and Azure Managed Grafana Dashboards as Code.

---

## 🏛️ Observability Architecture

```mermaid
flowchart TD
    subgraph Workloads ["Azure Landing Zone Infrastructure"]
        VNet["Hub & Spoke VNets"]
        VMs["Virtual Machines / AKS"]
        KV["Azure Key Vault"]
        WAF["Application Gateway"]
    end

    subgraph Ingestion ["Diagnostic Settings & Log Streams"]
        LAW["Centralized Log Analytics Workspace<br/>(90-Day Retention, Sentinel & Container Solutions)"]
    end

    subgraph Alerting ["Automated Alerts & Incident Routing"]
        MA["Metric Alerts (for_each)<br/>CPU > 80%, Memory, WAF 5xx"]
        ALA["Activity Log Alerts (for_each)<br/>NSG Deletions, RBAC Elevate"]
        AG["Action Groups (for_each)<br/>PagerDuty, Email, Runbooks"]
    end

    subgraph Visualization ["Unified SRE Single-Pane-of-Glass"]
        AMG["Azure Managed Grafana<br/>(Infrastructure, Network & Security Dashboards)"]
    end

    Workloads --> Ingestion
    Ingestion --> Alerting
    Alerting --> AG
    Ingestion --> AMG
```

---

## ⚡ Observability Capabilities Configured

| Component | Module | Implementation Details | Pattern |
|---|---|---|---|
| **Log Workspace** | [`modules/log_analytics`](./modules/log_analytics) | Centralized storage, retention, `SecurityInsights` + `ContainerInsights` | `for_each = var.solutions` |
| **Notification Groups** | [`modules/action_groups`](./modules/action_groups) | PagerDuty, DevOps on-call SMS, incident webhooks | `for_each = var.action_groups` |
| **Metric Telemetry** | [`modules/metric_alerts`](./modules/metric_alerts) | High CPU, memory saturation, Gateway 5xx, Key Vault latency | `for_each = var.metric_alerts` |
| **Security Auditing** | [`modules/activity_alerts`](./modules/activity_alerts) | NSG rule drops, administrative role assignments, unauthorized edits | `for_each = var.activity_alerts` |
| **Dashboards as Code** | [`modules/grafana`](./modules/grafana) | Azure Managed Grafana with committed JSON dashboards | Declarative JSON provisioning |

---

## 📂 Repository Layout

```text
├── versions.tf                        # Provider pins (AzureRM >= 3.116)
├── main.tf                            # Root orchestration calling all observability modules
├── outputs.tf                         # Log analytics & Grafana endpoints
├── modules/
│   ├── log_analytics/                 # Centralized workspace & OMS solutions
│   ├── action_groups/                 # Incident notification channels
│   ├── metric_alerts/                 # Performance degradation monitors
│   ├── activity_alerts/               # Security & administrative change monitors
│   └── grafana/                       # Azure Managed Grafana & JSON dashboards
│       └── dashboards/
│           └── azure-landing-zone-overview.json
└── README.md
```

---

## 🚀 Deployment Instructions

```bash
# 1. Initialize Terraform
terraform init

# 2. Plan execution
terraform plan -out=tfplan

# 3. Apply changes to Azure
terraform apply tfplan
```

---

## 👤 Author
**Gunjan Kumar Gaurav**  
*Senior Cloud & DevSecOps Consultant*  
[LinkedIn Profile](https://linkedin.com/in/gunjan-gaurav) • [GitHub](https://github.com/gunjankumargaurav7350)
