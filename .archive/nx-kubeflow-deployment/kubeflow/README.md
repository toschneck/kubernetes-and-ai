## Kubeflow on NKE

### Prerequisites

* Kubernetes cluster created using [Nutanix Kubernetes Engine](https://portal.nutanix.com/page/documents/details?targetId=Nutanix-Kubernetes-Engine-v2_8:top-deploy-kubernetes-cluster-t.html).

* [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

* [kustomize version 5.0.3](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv5.0.3)

* Setup [Nutanix Object Store](https://portal.nutanix.com/page/documents/details?targetId=Objects-v4_2:top-intro-c.html) which will be used by kubeflow pipelines (This is not required for vanilla kubeflow)

* Connect to k8s cluster by downloading [kubeconfig](https://portal.nutanix.com/page/documents/details?targetId=Nutanix-Kubernetes-Engine-v2_8:top-download-kubeconfig-t.html)

### Installation

#### Kubeflow on NKE

* Configure the object store by replacing the following variables:
    * put object store `accesskey` and `secretkey` in `overlays/pipeline/ntnx/object-store-secrets.env`
    * put `objStoreHost` in `overlays/pipeline/ntnx/pipeline-install-config.env`

* Run the following make command from the root of the github repo

```
make install-nke-kubeflow
```

#### Vanilla Kubeflow
* Run the following make command from the root of the github repo

```
make install-vanilla-kubeflow
```