# Kubeflow Deployment on KKP


* Tested with the envrionment
  * KKP `v2.24.8`
  * Kubernetes Version `v1.26.13`, Cilium with iptables
  * GPU Machines [machine-deployment.gpu.export.yaml](../demo-app/kkp-2024-05/usercluster-machindeployment-ref/machine-deployment.gpu.export.yaml) 
* Adjusted Config
  * Use KKP Minio (check gitsubmodule)
  * Deploy Applications
    * [nvidia GPU Operator Application](https://github.com/kubermatic/kubermatic/blob/release/v2.25/pkg/ee/default-application-catalog/applicationdefinitions/nvidia-gpu-operator-app.yaml)
      * modified for KKP 2.24 [nvidia-gpu-operator-app.yaml](../demo-app/kkp-2024-05/application-catalog/nvidia-gpu-operator-app.yaml)
    * external-dns for DNS management [demo-app/kkp/application-catalog](../demo-app/kkp-2024-05/application-catalog)
  * Node Selector / Taint for Job
    * Label: `type: gpu`
    * Taint: `workload:gpu`

### Login

#### KubeFlow
* via https://kubeflow-XXX.demo.kubermatic.io (incognito window maybe needed due to certs)
* or via http://localhost:8080:
  ```
  kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
  ```
* Configured Dex user [`dex.config.yaml`](./kubeflow/auth/dex.config.yaml)
  * user `user@example.com`
  * password `admin`

#### LocalAI
via http://localhost:18080:
```
kubectl port-forward -n localai svc/localai-local-ai 18080:80
```

## Notes

Get Node Overview GPU
```
kubectl get node --label-columns type,nvidia.com/gpu.product
```
----
## Based on https://github.com/nutanix/kubeflow-manifests

## Overview

The official documentation is available [here](https://nutanix.github.io/kubeflow-manifests/docs).

This repository contains kubeflow manifests for Nutanix Kubernetes Engine(NKE).

Follow the steps provided [here](https://nutanix.github.io/kubeflow-manifests/docs/install-kubeflow/) to install kubeflow on Nutanix Kubernetes cluster.