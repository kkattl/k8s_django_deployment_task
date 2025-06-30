#!/usr/bin/env bash
set -euo pipefail

CLUSTER=demo-django
REGION=us-east-1

echo "OIDC provider"
eksctl utils associate-iam-oidc-provider \
  --cluster "$CLUSTER" --region "$REGION" --approve

echo "AWS Load Balancer Controller"
eksctl create iamserviceaccount \
  --cluster "$CLUSTER" --region "$REGION" \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess \
  --approve

helm repo add eks https://aws.github.io/eks-charts
helm upgrade -i aws-lbc eks/aws-load-balancer-controller \
  --namespace kube-system \
  --set clusterName="$CLUSTER" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

echo "cert-manager"
helm repo add jetstack https://charts.jetstack.io
helm upgrade -i cert-manager jetstack/cert-manager \
  --namespace cert-manager --create-namespace \
  --set installCRDs=true
