#!/bin/bash

# Set the base path to the manifests directory
BASE_PATH="/home/ubuntu/kubernetes"

# Delete Frontend related manifests first
echo "Deleting Frontend manifests..."
kubectl delete -f "$BASE_PATH/frontend/karsajobs-ui-service.yml"
kubectl delete -f "$BASE_PATH/frontend/karsajobs-ui-deployment.yml"
echo "Frontend manifests deleted successfully."

# Delete Backend related manifests
echo "Deleting Backend manifests..."
kubectl delete -f "$BASE_PATH/backend/karsajobs-service.yml"
kubectl delete -f "$BASE_PATH/backend/karsajobs-deployment.yml"
echo "Backend manifests deleted successfully."

# Delete MongoDB related manifests
echo "Deleting MongoDB manifests..."
kubectl delete -f "$BASE_PATH/mongodb/mongo-service.yml"
kubectl delete -f "$BASE_PATH/mongodb/mongo-statefulset.yml"
kubectl delete -f "$BASE_PATH/mongodb/mongo-pv-pvc.yml"
kubectl delete -f "$BASE_PATH/mongodb/mongo-configmap.yml"
kubectl delete -f "$BASE_PATH/mongodb/mongo-secret.yml"
echo "MongoDB manifests deleted successfully."

echo "All manifests have been deleted."
