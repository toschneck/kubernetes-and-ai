
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

apply-auth:
	kubectl apply -f kubeflow/auth
	kubectl -n auth rollout restart deployment dex

install-minio:
	helm upgrade --install --create-namespace -n minio minio ../git-submodules/kubermatic/charts/minio/ -f minio/values.yaml

apply-kubeflow-example:
	kubectl apply -f ../demo-app/kubeflow-example-app/