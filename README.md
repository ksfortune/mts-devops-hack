# MTC ENGINEER HACK

## Стек
- Kubernetes v1.31 (kubeadm)
- Ubuntu 24.04
- Envoy Gateway v1.2.0 (Gateway API)
- Prometheus (kube-prometheus-stack)
- Fluent Bit → Loki
- StorageClass local-path

## Развёртывание

git clone <URL>
cd mts-devops-hack
make deploy

## Проверка приложения

make forward
curl http://localhost:8080

## Проверка мониторинга

make prom
# http://localhost:9090 → Status → Targets

## Проверка логирования

make grafana
# http://localhost:3000 → Explore → Loki → {app="nginx-app"}
