#!/usr/bin/env bash

helm repo add klt https://charts.lifecycle.keptn.sh
helm repo add jetstack https://charts.jetstack.io
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.2/cert-manager.crds.yaml
helm install cert-manager --namespace cert-manager --version v1.12.2 jetstack/cert-manager --create-namespace
kubectl create ns monitoring
kubectl apply -f https://raw.githubusercontent.com/keptn/lifecycle-toolkit/klt-v0.8.2/examples/support/observability/config/prometheus/grafana-config.yaml
kubectl apply -f https://raw.githubusercontent.com/keptn/lifecycle-toolkit/klt-v0.8.2/examples/support/observability/config/prometheus/grafana-dashboard-keptn-applications.yaml
kubectl apply -f https://raw.githubusercontent.com/keptn/lifecycle-toolkit/klt-v0.8.2/examples/support/observability/config/prometheus/grafana-dashboard-keptn-overview.yaml
kubectl apply -f https://raw.githubusercontent.com/keptn/lifecycle-toolkit/klt-v0.8.2/examples/support/observability/config/prometheus/grafana-dashboard-keptn-workloads.yaml
kubectl apply -f datasources.yaml
helm upgrade --install observability-stack prometheus-community/kube-prometheus-stack --version 48.1.1 --namespace monitoring --values=values.yaml
