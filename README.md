## This is my recruitment repo 2021yr.

### What I did?:

Everything is made from scratch.

Terraform setting up env for EKS K8s in AWS and then we are deploying the application for the internal docker registry. Then I made a python script for image rotation.

## Syntax:

Everywhere I added numbers in files and directories' names because will be easier to read for someone who will check this code.

The code is tested and works.

## How it works:

I used terraform for EKS Deployment. Terraform makes also persistent EBS volume and ingress-Nginx, cert-manager, metrics for hpa from the helm.

After all YAML apply we have a connection in that way: DOMAIN -> LB -> INGRESS (SSL cert-manager) -> Service -> Pods

Garbage collector starting his job at night.

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
