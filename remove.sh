kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
kubectl delete -f postgres.yaml
kubectl delete -f keycloak-ingress.yaml
kubectl delete -f keycloak.yaml