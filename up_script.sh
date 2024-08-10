#!/bin/bash

# Set the base path to the manifests directory
BASE_PATH="/home/ubuntu/kubernetes"

# Apply MongoDB related manifests first
echo "Applying MongoDB manifests..."
kubectl apply -f "$BASE_PATH/mongodb/mongo-secret.yml"
kubectl apply -f "$BASE_PATH/mongodb/mongo-configmap.yml"
kubectl apply -f "$BASE_PATH/mongodb/mongo-pv-pvc.yml"
kubectl apply -f "$BASE_PATH/mongodb/mongo-statefulset.yml"
kubectl apply -f "$BASE_PATH/mongodb/mongo-service.yml"
echo "MongoDB manifests applied successfully."

# Apply Backend related manifests
echo "Applying Backend manifests..."
kubectl apply -f "$BASE_PATH/backend/karsajobs-service.yml"
kubectl apply -f "$BASE_PATH/backend/karsajobs-deployment.yml"
echo "Backend manifests applied successfully."

# Apply Frontend related manifests
echo "Applying Frontend manifests..."
kubectl apply -f "$BASE_PATH/frontend/karsajobs-ui-service.yml"
kubectl apply -f "$BASE_PATH/frontend/karsajobs-ui-deployment.yml"
echo "Frontend manifests applied successfully."

echo "All manifests have been applied."
