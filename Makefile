SHELL := /bin/bash
REV_FILE=.make-rev-check

set-rev:
	git rev-parse --short HEAD > $(REV_FILE)

image: set-rev
	./deploy/images/make-image.sh deploy/images/Dockerfile "wrike-updater:$$(cat $(REV_FILE))"

tag-image: set-rev
	docker tag "wrike-updater:$$(cat $(REV_FILE))" "registry.ng.bluemix.net/eggshell/wrike-updater:latest"

upload-image: set-rev
	docker push "registry.ng.bluemix.net/eggshell/wrike-updater:latest"

.PHONY: deploy
deploy: set-rev
	IMAGE_TAG=$$(cat $(REV_FILE)) envsubst < deploy/wrike-updater.yaml | kubectl apply -f -

delete-deployments:
	kubectl delete deployment wrike-updater

redeploy: delete-deployments deploy

roll: set-rev image tag-image upload-image deploy
