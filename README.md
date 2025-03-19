<<<<<<< HEAD
# multi-cluster-federation-management
This project demonstrates the management of workloads across multiple Kubernetes clusters using Kubernetes Federation v2. It provides a framework for deploying and managing applications across multiple regions using AWS EKS clusters.
=======
# Multi-Cluster Federation Management

This project demonstrates the management of workloads across multiple Kubernetes clusters using Kubernetes Federation v2. It provides a framework for deploying and managing applications across multiple regions using AWS EKS clusters.

## Features

- Multi-cluster workload deployment using Kubernetes Federation v2
- Automated policy management across clusters
- Monitoring and visualization of inter-cluster traffic
- Integration with AWS EKS
- Prometheus and Grafana for metrics collection and visualization

## Prerequisites

- AWS CLI configured with appropriate credentials
- kubectl installed
- kubefedctl installed
- Helm installed
- Access to multiple AWS EKS clusters

## Project Structure

```
.
├── README.md
├── terraform/           # Infrastructure as Code for AWS EKS clusters
├── kubernetes/         # Kubernetes manifests
│   ├── federation/     # Federation-specific configurations
│   ├── monitoring/     # Prometheus and Grafana configurations
│   └── workloads/      # Sample workload deployments
└── scripts/           # Utility scripts for cluster management
```

## Getting Started

1. Deploy the infrastructure using Terraform:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

2. Configure cluster federation:
   ```bash
   ./scripts/setup-federation.sh
   ```

3. Deploy monitoring stack:
   ```bash
   kubectl apply -f kubernetes/monitoring/
   ```

4. Deploy sample workloads:
   ```bash
   kubectl apply -f kubernetes/workloads/
   ```

## Monitoring

Access the Grafana dashboard to view inter-cluster metrics:
```bash
kubectl port-forward svc/grafana 3000:3000 -n monitoring
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 
>>>>>>> a2c3987 (Initial commit)
