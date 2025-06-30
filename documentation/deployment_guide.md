# Deployment Guide

This guide walks you through deploying the full stack for the Django sample application on AWS, including the EKS cluster, managed PostgreSQL database via Terraform, and Helm-based application deployment.

---

## Prerequisites

- **AWS Account** with sufficient IAM permissions to create: EKS clusters, IAM roles/policies, VPC/subnets, RDS instances, Security Groups, S3 bucket for Terraform state.
- **AWS CLI** configured (`aws configure`) for your target account/region.
- **eksctl** installed (v0.210.0 or later).
- **Terraform** installed (v1.2.0 or later).
- **Helm** installed (v3.18.0 or later).
- **Helmfile** installed.
- **kubectl** installed and configured.
- **SOPS** (if you plan to encrypt Helm secrets).
- **Git** to clone this repo.

---

## 1. Deploy the EKS Cluster

1. **Review** `eks-cluster.yaml` in the repo root. It defines:
   - Cluster name, region, Kubernetes version.
   - Two availability zones (AZs) for HA.
   - One managed NodeGroup (`spot-small`) using spot instances.
2. **Create** the cluster:
   ```bash
   eksctl create cluster -f eks-cluster.yaml
   ```
3. **Verify** cluster and nodes:
    ```bash
    aws eks update-kubeconfig --name demo-django --region us-east-1
    kubectl get nodes
   ```
4. **Associate** the IAM OIDC provider for IAM Roles for Service Accounts (IRSA):
    ```bash
   eksctl utils associate-iam-oidc-provider --cluster demo-django --approve
   ```

## 2. Provision PostgreSQL via Terraform
1. Initialize and apply:
    ```bash
    cd infra-db
    terraform init
    terraform apply
    ```
## 3. Install Cert-Manager
1. Apply Cert-Manager CRDs and controller:
    ```bash
    kubectl apply --validate=false -f https://github.com/cert-manager/cert-manager/releases/download/v1.20.0/cert-manager.yaml
    ```
2. Apply 
    ```bash
   kubectl apply -f cluster-issuer.yaml
   ```
## 4. Prepare Helm Chart

1. Encrypt your secrets file:
    ```bash
    sops -e -i helm_chart/values-secret.sops.yaml
    ```

2. Synchronize:
    ```bash
    helmfile sync
    ```

## 5. Validate Deployment
1. Check services and pods:
    ```bash
    kubectl -n demo get svc,deploy,hpa,ingress
    ```
2. Test application connectivity (from within cluster)
## 6. Cleanup
1. To tear down the cluster and nodegroups:
    ```bash
    eksctl delete cluster --name demo-django
    ```
2. To destroy Terraform-managed RDS:
    ```bash
    cd infra-db
    terraform destroy
    ```
3. Remove local namespaces or Helm releases if needed.
