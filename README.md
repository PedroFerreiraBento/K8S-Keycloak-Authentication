# Keycloak Deployment with Kubernetes and SSL using Minikube

This document outlines the steps to set up Keycloak on Kubernetes with SSL support using Minikube.

## Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [OpenSSL](https://www.openssl.org/)

## Steps

### 1. Create a folder to store certificates and keys
```sh
mkdir ./certs
```

### 2. Create a CA key and certificate
```sh
openssl req -x509 \
            -sha256 -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=127.0.0.1.nip.io/C=BR/L=Sao Paulo" \
            -keyout ./certs/rootCA.key -out ./certs/rootCA.crt 
```

### 3. Generate a private key and CSR (Certificate Signing Request)
```sh
openssl req -new -nodes -newkey rsa:2048 -keyout ./certs/tls.key -out ./certs/tls.csr -config ./certs/csr.conf
```

### 4. Generate the self-signed certificate
```sh
openssl x509 -req \
    -in ./certs/tls.csr \
    -CA ./certs/rootCA.crt -CAkey ./certs/rootCA.key \
    -CAcreateserial -out ./certs/tls.crt \
    -days 365 \
    -sha256 -extfile ./certs/cert.conf
```

### 5. Create a Kubernetes secret for the certificates
```sh
kubectl create secret tls keycloak-tls --key="./certs/tls.key" --cert="./certs/tls.crt" -n keycloak-ns
```

## Local Development
### 1. Set a local DNS entry
Add the following line to your `C:\Windows\System32\drivers\etc\hosts`(DNS Local) file:
```sh
127.0.0.1 127.0.0.1.nip.io
```

### 2. Start a Minikube tunnel
```sh
minikube tunnel
```

## Production Development
Change the host, ports and certs as your need

## Start
Execute the shell `./start.sh` to start the services and pods.