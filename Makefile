deploy:
	./deploy.sh

forward:
	kubectl port-forward -n envoy-gateway-system svc/$$(kubectl get svc -n envoy-gateway-system -o name | grep envoy | head -1 | cut -d/ -f2) 8080:80

prom:
	kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090

grafana:
	kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80

logs:
	kubectl logs -l app=nginx-app --tail=20
