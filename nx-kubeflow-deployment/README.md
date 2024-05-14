# Kubeflow Deployment on KKP


* Tested with the envrionment
  * KKP `v2.24.8`
  * Kubernetes Version `v1.26.13`, Cilium with iptables
  * GPU Machines [machine-deployment.gpu.export.yaml] 
* Adjusted Config
  * Use KKP Minio (check gitsubmodule)
  * Deploy [nvidia GPU Operator Application](https://github.com/kubermatic/kubermatic/blob/release/v2.25/pkg/ee/default-application-catalog/applicationdefinitions/nvidia-gpu-operator-app.yaml)
    * modified for KKP 2.24 [demo-app/kkp/nvidia-gpu-operator-app.yaml](../demo-app/kkp/nvidia-gpu-operator-app.yaml)
  * Node Selector / Taint for Job
    * Label: `type: gpu`
    * Taint: `workload:gpu`

Get Node Overview GPU
----
## Based on https://github.com/nutanix/kubeflow-manifests

## Overview

The official documentation is available [here](https://nutanix.github.io/kubeflow-manifests/docs).

This repository contains kubeflow manifests for Nutanix Kubernetes Engine(NKE).

Follow the steps provided [here](https://nutanix.github.io/kubeflow-manifests/docs/install-kubeflow/) to install kubeflow on Nutanix Kubernetes cluster.