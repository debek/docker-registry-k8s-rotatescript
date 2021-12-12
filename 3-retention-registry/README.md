### How prepare environment:

`pip install virtualenv`

`python3 -m venv env`

`source env/bin/activate`

`pip install -r requirements.txt`

### Usage:

Script which I wrote is generic and can work with any image name and with every number of tags to keep. Below is info on how to use it.

```
usage: retention-script.py [-h] [--image IMAGE] [--count COUNT] [--hostname HOSTNAME] [--user USER] [--password PASSWORD]

Script for rotate images in docker private registry.

optional arguments:
  -h, --help           show this help message and exit
  --image IMAGE        Name of image.
  --count COUNT        Amount of a newest tags to keep.
  --hostname HOSTNAME  Docker registry hostname.
  --user USER          Add htaccess username.
  --password PASSWORD  Add htaccess password.
```

### My thoughts on that task:

I learned how to use REST API requests for docker-registry and I tested them before I stareted write this code. The issue which I had in Deployment.yaml is missing below variable: :)

curl example:
```
curl -X GET -u test:test -k https://testdd.ml/v2/_catalog
curl -X GET -u test:test -k https://testdd.ml/v2/cos/tags/list
curl -s -X DELETE -u test:test  -k https://testdd.ml/v2/cos/manifests/sha256:7b1a6ab2e44dbac178598dabe7cff59bd67233dba0b27e4fbd1f9d4b3c877a54
```

variable allowing delete in k8s deployment:
```
- name: REGISTRY_STORAGE_DELETE_ENABLED
  value: "true"
```

I am considering that for CI/CD process or crone maybe we should create a different pod with this variable because on production exposed pod deleting images in that way can be dangerous.
