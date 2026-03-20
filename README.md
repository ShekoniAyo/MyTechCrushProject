# ☁️ Cloud-Automated Storage & Management System

A secure, automated data engineering workflow built with **Azure Blob Storage**, **Bash scripting**, and **GitHub Actions CI/CD**.

---

## 📝 Executive Summary

This project demonstrates a deployment pipeline that interacts with Microsoft Azure Blob Storage via a custom command-line interface (CLI). The entire infrastructure is managed through Infrastructure as Code (IaC) principles and deployed automatically on every push, requiring no manual intervention required.

---

## 🏗️ Architecture Overview

The system is organized into three layers:

| Layer | Components |
|---|---|
| **Cloud** | Azure Resource Groups, Storage Accounts, Containers |
| **Logic** | `deploy.sh` and `manage_storage.sh` for resource creation and file operations |
| **Automation** | GitHub Actions workflow for continuous deployment |

---

## 🛠️ Implementation

### Phase 1 — Infrastructure Scripting (`deploy.sh`)

Automates the creation of the entire storage environment:

- **Resource Group:** Provisioned `TechCrush` in the `eastus` region as a logical container
- **Storage Account:** Created a globally unique account with `Standard_LRS` redundancy
- **Security:** Enabled public blob access to allow controlled file retrieval

---

### Phase 2 — Management Tooling (`manage_storage.sh`)

A dynamic script that uses positional arguments (`$1`, `$2`) to wrap complex Azure CLI commands into simple, human-readable actions:

| Command | Description |
|---|---|
| `upload` | Moves local files to Azure Blob Storage |
| `download` | Retrieves files from the cloud to the local machine |
| `list` | Displays a table view of all stored objects |

> **Audit Logging:** Every action appends a timestamped entry to `storage_activity.log` for a full history of interactions.

---

### Phase 3 — GitHub Actions CI/CD (`.github/workflows/main_deploy.yml`)

Fully automated pipeline that handles the deployment lifecycle:

1. **Authentication** — Logs into Azure via a Service Principal using an encrypted GitHub Secret (`AZURE_CREDENTIALS`)
2. **Environment Setup** — Automatically sets execution permissions (`chmod +x`) on all scripts
3. **Deployment** — Runs the infrastructure script to ensure storage is always ready
4. **Verification** — Executes a test upload and captures `activity_log.txt` as a build artifact for proof of work

---

## ✨ Key Features

| Feature | Implementation | Benefit |
|---|---|---|
| **Automation** | GitHub Actions | Zero manual intervention required for deployment |
| **Error Handling** | `set -e` & wildcard cases | Prevents script continuation on command failure |
| **Audit Trail** | `$(date)` appended to log | Full history of all data interactions |
| **Security** | RBAC & GitHub Secrets | Azure credentials never exposed in code |

---

## 🏁 Conclusion

By combining Bash scripting with Azure and GitHub Actions, this project delivers a predictable, repeatable, and easily maintainable data infrastructure — ready for use by any data engineer.

---

## 📁 Repository Structure

```
.
├── deploy.sh                        # Infrastructure provisioning script
├── manage_storage.sh                # CLI tool for blob management
├── activity_log.txt             # Auto-generated audit log
└── .github/
    └── workflows/
        └── main_deploy.yml          # CI/CD pipeline definition
```
