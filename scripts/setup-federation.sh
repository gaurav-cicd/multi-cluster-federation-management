#!/bin/bash

# Exit on error
set -e

# Check if kubefedctl is installed
if ! command -v kubefedctl &> /dev/null; then
    echo "kubefedctl is not installed. Please install it first."
    exit 1
fi

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo "helm is not installed. Please install it first."
    exit 1
fi

# Create namespace for federation
kubectl apply -f kubernetes/federation/00-namespace.yaml

# Install Federation v2
helm repo add kubefed-charts https://raw.githubusercontent.com/kubernetes-sigs/kubefed/master/charts
helm repo update

helm install kubefed kubefed-charts/kubefed \
    --namespace kube-federation-system \
    --create-namespace \
    --version v0.9.0

# Wait for federation control plane to be ready
echo "Waiting for federation control plane to be ready..."
kubectl wait --for=condition=ready pod -l app=kubefed -n kube-federation-system --timeout=300s

# Add clusters to federation
# Replace these with your actual cluster contexts
CLUSTER_CONTEXTS=("cluster1" "cluster2")

for context in "${CLUSTER_CONTEXTS[@]}"; do
    echo "Adding cluster $context to federation..."
    kubefedctl join $context \
        --cluster-context $context \
        --host-cluster-context $context \
        --v=2
done

# Deploy monitoring stack
echo "Deploying monitoring stack..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install monitoring prometheus-community/kube-prometheus-stack \
    --namespace monitoring \
    --create-namespace \
    --values kubernetes/monitoring/values.yaml

# Deploy sample workload
echo "Deploying sample workload..."
kubectl apply -f kubernetes/workloads/sample-app.yaml

echo "Setup completed successfully!"
echo "To access Grafana dashboard, run: kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring" 