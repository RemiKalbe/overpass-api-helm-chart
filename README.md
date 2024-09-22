> [!WARNING]
> This project is in very early stages of development and is not production-ready. Use at your own risk and expect frequent changes.

# 🌍 Overpass API Helm Chart 

[![License](https://img.shields.io/github/license/remikalbe/overpass-api-helm-chart?style=for-the-badge)](LICENSE)
[![Image build](https://img.shields.io/github/actions/workflow/status/remikalbe/overpass-api-helm-chart/.github%2Fworkflows%2Fpublish-image.yaml?style=for-the-badge&label=image%20build
)](https://github.com/RemiKalbe/overpass-api-helm-chart/actions/workflows/publish-image.yaml)
[![Sync with upstream](https://img.shields.io/github/actions/workflow/status/remikalbe/overpass-api-helm-chart/.github%2Fworkflows%2Fsync.yaml?style=for-the-badge&label=sync%20with%20upstream
)](https://github.com/RemiKalbe/overpass-api-helm-chart/actions/workflows/sync.yaml)
[![Publish chart](https://img.shields.io/github/actions/workflow/status/remikalbe/overpass-api-helm-chart/.github%2Fworkflows%2Fpublish-chart.yaml?style=for-the-badge&label=publish%20chart
)](https://github.com/RemiKalbe/overpass-api-helm-chart/actions/workflows/publish-chart.yaml)


This repository contains a Helm chart for deploying Overpass API on Kubernetes. Overpass API is a powerful tool for querying OpenStreetMap data.

## ⚡ Quick Start

1. Add the Helm repository:
   ```console
   helm repo add overpass-api https://remikalbe.github.io/overpass-api-helm-chart
   ```

2. Update your local Helm chart repository cache:
   ```console
   helm repo update
   ```

3. Install the chart:
   ```console
   helm install my-overpass-api overpass-api/overpass-api
   ```

## ⚙️ Configuration

The configuration options for the Overpass API Helm chart are listed in the [values.yaml](charts/overpass-api-chart/values.yaml) file, along with detailed explanations of each option.

---

For more information on Overpass API, visit the [OpenStreetMap Wiki](https://wiki.openstreetmap.org/wiki/Overpass_API).