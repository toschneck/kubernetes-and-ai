#!/bin/bash

KF_VERSION=v1.8.0

helpFunction()
{
    echo ""
    echo "Usage: install.sh [OPTIONAL -v] [OPTIONAL -d]"
    echo "-v    vanilla kubeflow"
    echo "-d    use docker credentials"
    exit 1 # Exit script after printing help
}

while getopts "vd" option; do
    case $option in
        v ) vanilla_kubeflow="vanilla_kubeflow" ;;
        d ) use_docker_creds="use_docker_creds" ;;
        ? ) helpFunction ;;
    esac
done

# Download kubeflow manifests
wget https://github.com/kubeflow/manifests/archive/refs/tags/"$KF_VERSION".tar.gz
mkdir manifests
tar -xvf "$KF_VERSION".tar.gz -C manifests --strip-components=1

# Remove downloaded tar file
rm "$KF_VERSION".tar.gz

if [ -z "$vanilla_kubeflow"  ]
then
    echo "Using nutanix object store"
    # Patch kubeflow pipelines
    cp overlays/pipeline/pipeline-kustomization.yaml manifests/apps/pipeline/upstream/env/cert-manager/platform-agnostic-multi-user/kustomization.yaml
    mkdir -p manifests/apps/pipeline/upstream/env/ntnx
    cp -r overlays/pipeline/ntnx manifests/apps/pipeline/upstream/env
fi

if [ -n "$use_docker_creds"  ]
then
    echo "Using docker imagePullSecrets"
    source overlays/docker/docker-credentials.env
    kubectl create namespace kubeflow
    kubectl create namespace istio-system
    kubectl create secret docker-registry kf-docker-cred --docker-server=$DOCKER_SERVER --docker-username=$DOCKER_USERNAME --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_EMAIL -n kubeflow
    kubectl create secret docker-registry kf-docker-cred --docker-server=$DOCKER_SERVER --docker-username=$DOCKER_USERNAME --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_EMAIL -n istio-system
    kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "kf-docker-cred"}]}' -n kubeflow

    cp overlays/docker/service-account-patch.yaml manifests/example/service-account-patch.yaml

    cat << EOF >> manifests/example/kustomization.yaml

patchesStrategicMerge:
- service-account-patch.yaml
EOF

fi

# Install kubeflow
while ! kustomize build manifests/example  | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 60; done

# Remove kubeflow manifests
rm -rf manifests

if [ -n "$use_docker_creds"  ]
then
    kubectl create secret docker-registry kf-docker-cred --docker-server=$DOCKER_SERVER --docker-username=$DOCKER_USERNAME --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_EMAIL -n kubeflow-user-example-com
    kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "kf-docker-cred"}]}' -n kubeflow-user-example-com
    kubectl patch serviceaccount default-editor -p '{"imagePullSecrets": [{"name": "kf-docker-cred"}]}' -n kubeflow-user-example-com
fi