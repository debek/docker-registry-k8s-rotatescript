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

I learned how to use curl requests for changes and test them before. The issue which I had in Deployment.yaml is missing below variable: :)

```
- name: REGISTRY_STORAGE_DELETE_ENABLED
  value: "true"
```

I am considering that for CI/CD or crone maybe we should create a different pod with this variable because on production exposed pod deleting images in that way can be dangerous.
