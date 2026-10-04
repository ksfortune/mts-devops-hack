#!/bin/bash

# Останавливаем старые port-forward, если есть
pkill -f "kubectl port-forward" 2>/dev/null
sleep 1

echo "Запускаю port-forward..."

# Envoy Gateway -> 8080
kubectl port-forward -n envoy-gateway-system \
  svc/$(kubectl get svc -n envoy-gateway-system -o name | grep envoy | head -1 | cut -d/ -f2) \
  8080:80 > /tmp/pf-app.log 2>&1 &
echo $! > /tmp/pf-app.pid
echo "  ✓ Приложение  http://localhost:8080"

# Prometheus -> 9090
kubectl port-forward -n monitoring \
  svc/prometheus-kube-prometheus-prometheus 9090:9090 > /tmp/pf-prom.log 2>&1 &
echo $! > /tmp/pf-prom.pid
echo "  ✓ Prometheus  http://localhost:9090"

# Grafana -> 3000
kubectl port-forward -n monitoring \
  svc/prometheus-grafana 3000:80 > /tmp/pf-grafana.log 2>&1 &
echo $! > /tmp/pf-grafana.pid
echo "  ✓ Grafana     http://localhost:3000"

sleep 2
echo ""
echo "Все туннели подняты."
echo "Остановить: ./stop.sh"
