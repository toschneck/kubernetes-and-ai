
deploy-local-ai:
	helm upgrade --install --create-namespace -n localai localai ../git-submodules/localai-helm/charts/local-ai -f values.yaml
	kubectl label namespace localai istio-injection=disabled
	kubectl label namespace nginx istio-injection=disabled
	kubectl apply -f issuer.yaml
	echo ... && sleep 5
	kubectl get pods,certificate,ing -o wide -n localai

#download-helm-chart:
#	helm pull --untar -d ./charts metallb/metallb
