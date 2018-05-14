# wrike-updater

wrike-updater is a tool which runs on kubernetes and allows for updating
tickets in [Wrike](https://wrike.com). My implementation simply allows for
updating a single ticket with information from Google Analytics, but the
infrastructure is there for other uses and/or further abstraction.

## Requirements

* [A wrike token](https://developers.wrike.com/documentation/oauth2).
* A google analytics account and its two accompanying pieces of information
  specific to your account, the view id and your client secrets. I followed
  this [guide](https://developers.google.com/analytics/devguides/reporting/core/v4/quickstart/service-py)
  to make this repo.
* Access to some sort of kubernetes PaaS, such as Google Cloud Engine.

## Installation and Configuration

* Clone this repo:

```
git@github.com:eggshell/wrike-updater.git
```

* Download your `client_secrets.json` from Google and place it in `deploy/secrets`.

* Get your Google view ID and Wrike token, encode them in base64 and place them
  in `deploy/secrets/example-view-id.yaml` and `deploy/secrets/example-wrike-token.yaml`
  respectively:

```
echo -n YOUR_WRIKE_TOKEN | base64
echo -n YOUR_VIEW_ID | base64
echo -n YOUR_TASK_ID | base64
mv example-wrike-token.yaml wrike-token.yaml
mv example-view-id.yaml view-id.yaml
mv example-task-id.yaml task-id.yaml
```

* Create Kubernetes secrets for your wrike token and view-id:

```
kubectl create -f deploy/secrets/wrike-token.yaml
kubectl create -f deploy/secrets/view-id.yaml
kubectl create -f deploy/secrets/task-id.yaml
```

* Create a configmap for your `client_secrets.json`:

```
kubectl create configmap ga-secrets-configmap --from-file=deploy/secrets/client_secrets.json
```

## Deployment

* Change the image name in `deploy/wrike-updater.yaml` to point to your images
  if you don't want to use mine.

* Use the makefile to deploy to your hosted kubernetes cluster:

```
make roll
```
