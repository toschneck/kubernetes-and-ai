
.PHONY: install-nx-kubeflow
install-nx-kubeflow:
	$(info Installing kubeflow on NKE...)
	cd kubeflow; ./install.sh

#.PHONY: install-vanilla-kubeflow
#install-vanilla-kubeflow:
#	$(info Installing vanilla kubeflow...)
#	cd kubeflow; ./install.sh -v
apply-nx-kubeflow-ingress-patch:
	kubectl apply -f kubeflow/ingress

install-minio:
	helm upgrade --install --create-namespace -n minio minio ../git-submodules/kubermatic/charts/minio/ -f minio/values.yaml

deploy-kubeflow-example:
	kubectl apply -f ../demo-app/kubeflow-example-app