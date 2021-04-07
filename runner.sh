#!/usr/bin/env bash

set -ueE
set -o pipefail

SUPPORTED_STAGES=(dev prod)

STAGE="${STAGE:-false}"

[[ ! "${SUPPORTED_STAGES[*]}" =~ "${STAGE}" ]] && {
    echo "STAGE env parameter is required: ${SUPPORTED_STAGES[*]}"
    exit 1
}

eval $(minikube -p minikube docker-env)

echo "Build app image"
docker build app/ -t hello-world-from-db

echo "Create app k8s namespace (if required)"
kubectl create namespace "hello-world-from-db-${STAGE}" --dry-run=client -o yaml | kubectl apply -f -

echo "Rollout version for ${STAGE}"

HELM_CHART_PATH=deployment/hello-world-from-db

helm upgrade --install \
    "hello-world-from-db-${STAGE}" \
    ${HELM_CHART_PATH} \
    --namespace "hello-world-from-db-${STAGE}" \
    -f "${HELM_CHART_PATH}/values-${STAGE}.yaml"
