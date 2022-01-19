## Syntax:

Everywhere I added numbers in files and directories name because will be easier to read for someone who will check this code.

The code is tested and works.

## How it works:

I used terraform for EKS Deployment. Terraform makes also persistent EBS volume and ingress-nginx, cert-manager, metrics for hpa from the helm.

After all yaml apply we have connection in that way: DOMIAN -> LB -> INGRESS (SSL cert-manager) -> Service -> Pods

Garbage-collector starting his job at night.

## Deployment process:

Deployment can be more automated but TF was not a task for this project :) I started this job later than at once so I don't have time to improve that for now.

`cd 1-terraform`

`terraform init`

`terraform apply`

`cd 2-kubernetes-deployment`

`Change 2-deployment-docker-registry.yaml, VolumeID: in PersistentVolume`

`Change 4-ingress-with-tls.yaml, Domain name`

`kubectl apply -f .`

## Retention registry (Optional Task):

3-retention-registry directory has its own README file
