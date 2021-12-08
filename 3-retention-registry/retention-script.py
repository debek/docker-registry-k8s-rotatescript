import argparse
import requests

parser = argparse.ArgumentParser(description='Script for rotate images in docker private registry.')
parser.add_argument("--image", help="Name of image.", default="alpine")
parser.add_argument("--count", help="Amount of a newest tags to keep.", default="10")
parser.add_argument("--hostname", help="Docker registry hostname.", default="testdd.ml")
parser.add_argument("--user", help="Add htaccess username.", default="test")
parser.add_argument("--password", help="Add htaccess password.", default="test")
args = parser.parse_args()

image = args.image
image_count = int(args.count)
hostname = args.hostname
user = args.user
password = args.password

# List all tags for specific image
get_images_list = requests.get(f"https://{hostname}/v2/{image}/tags/list", auth=(f"{user}", f"{password}"))
images_list = get_images_list.json()["tags"]

# Logic of script
tags_count = len(images_list)
tags_needed_amount = tags_count - image_count
for index, tag in enumerate(images_list):
    if (index + 1 <= tags_needed_amount):
        # Get docker etag
        get_header_with_etag = requests.get(f"https://{hostname}/v2/{image}/manifests/{tag}", auth=(f"{user}", f"{password}"), headers={"Accept":"application/vnd.docker.distribution.manifest.v2+json"})
        try:
            etag_sha = get_header_with_etag.headers["Docker-Content-Digest"]
            # Delete image with tag
            delete_request = requests.delete(f"https://{hostname}/v2/{image}/manifests/{etag_sha}", auth=(f"{user}", f"{password}"))
            print(f"tag: {tag}, delete status: {delete_request}")
        except:
            print("Not found docker etag")
            pass
    else:
        print("Nothing to do...")
        break

