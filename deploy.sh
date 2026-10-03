#!/bin/bash

kubectl apply -f k8s/app/nginx.yaml
kubectl apply -f k8s/gateway/gateway.yaml

helm install eg oci://docker.io/envoyproxy/gateway-helm --version v1.2.0 -n envoy-gateway-system --create-namespace

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.30/deploy/local-path-storage.yaml
kubectl patch storageclass local-path -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
kubectl create namespace logging
helm install loki grafana/loki -n logging -f loki-values.yaml
