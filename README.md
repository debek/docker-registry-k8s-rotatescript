## Syntax:

Everywhere I added numbers in files and directories name because will be easier to read for someone who will check this code.

The code is tested and works.

## How it works:

I used terraform for EKS Deployment. Terraform makes also persistent EBS volume, ingress-nginx and cert-manager from the helm.

After all yaml apply we have connection in that way: DOMIAN -> LB -> INGRESS (SSL cert-manager) -> Service -> Pods

Garbage-collector starting his job at night.

## Deployment proces:

Deployment can be more automated but TF was not a task for this project :) I started this job later than at once so I don't have time to improve that for now.

`cd 1-terraform`

`terraform init`

`terraform apply`

`cd 2-kubernetes-deployment`

`Change 2-deployment-docker-registry.yaml, VolumeID: in PersistentVolume`

`Change 4-ingress-with-tls.yaml, Domain name`

`kubectl apply -f .`

## My thoughts:

I am really happy because of this task. Before I never prepared private docker-registry and I learned how it works under the hood.

Of course, I meet a few issues during my job like finding correct env variables, API syntax, login authentication, and so on. The funny issue which I had was that when I had one pod then image upload worked but with two pods I had an issue :) I didn't have a secret variable.

To this project we can add also pre-commit, CI/CD file, BETTER AUTOMATION, .gitignore, tf backend in s3 and a nice picture of infra. Of course, time is needed :)

## Retention registry (Optional Task):

3-retention-registry directory has its own README file
