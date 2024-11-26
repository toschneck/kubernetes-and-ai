
KUBECONFIG ?= demo-app/.env/kubeconfig-ai-lab-cluster
export KUBECONFIG

############ KKP / K8s #################
kkp-md-apply:
	kubectl apply -f demo-app/kkp-usercluster-machindeployment-ref

kkp-applications-deploy:
	kubectl apply -f demo-app/kkp-applications
	kubectl apply -f demo-app/kkp-applications/.env

k8s-get-gpu-node:
	kubectl get node --label-columns type,nvidia.com/gpu.product,k8c.io/aws-spot


############ DEPLOYKF #################
helm-repo:
	helm repo add "argo" https://argoproj.github.io/argo-helm
	helm repo update

argocd-deploy:
	helm upgrade argocd argo/argo-cd \
	  --install \
	  --create-namespace -n argocd \
	  --version "6.7.18" \
	  --values deployKF/argocd.values.yaml

deployKF-deploy: kkp-applications-deploy
	kubectl apply -f deployKF/app-of-apps.yaml
	./deployKF/sync_argocd_apps.sh

############ KUBEFLOW ###########
kubeflow-example-deploy:
	kubectl apply -f demo-app/kubeflow-example-app
	make kubeflow-watch-team-demo

kubeflow-watch-team-demo:
	watch kubectl get experiment,trial,pod -o wide -n team-demo
	watch kubectl get all -n team-demo -o wide


############ LOCALAI #################
local-ai-deploy:
	helm upgrade --install --create-namespace -n localai localai \
		git-submodules/localai-helm/charts/local-ai \
		-f localai/values.yaml
	kubectl label namespace localai istio-injection=disabled
	kubectl label namespace nginx istio-injection=disabled #TODO check
	#kubectl apply -f issuer.yaml
	echo ... && sleep 5
	kubectl get pods,certificate,ing -o wide -n localai

local-ai-logs:
	kubectl logs -n localai deployment/localai-local-ai -f

