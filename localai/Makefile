
deploy-local-ai:
	helm upgrade --install --create-namespace -n localai localai ../git-submodules/localai-helm/charts/local-ai -f values.yaml
	sleep 5 & echo ...
	kubectl get pods -o wide -n localai