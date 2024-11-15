
helm-repo:
	helm repo add "argo" https://argoproj.github.io/argo-helm
	helm repo update


kkp-applications-deploy:
	kubectl apply -f kkp-applications
	kubectl apply -f kkp-applications/.env

argocd-deploy:
	helm upgrade argocd argo/argo-cd \
	  --install \
	  --create-namespace -n argocd \
	  --version "6.7.18" \
	  --values argocd.values.yaml

deployKF-deploy: kkp-applications-deploy
	kubectl apply -f app-of-apps.yaml
	./sync_argocd_apps.sh