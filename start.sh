kubectl create ns keycloak-ns
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
kubectl rollout status deployment/ingress-nginx-controller -n ingress-nginx
kubectl apply -f postgres.yaml
kubectl apply -f keycloak-ingress.yaml
kubectl apply -f keycloak.yaml