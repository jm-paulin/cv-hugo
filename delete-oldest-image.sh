#! /usr/bin/env bash

IMAGES_PATH=europe-west1-docker.pkg.dev/jm-paulin/cloud-run-source-deploy/cv-hugo/jm-paulin-cv-hugo
IMAGES_JSON=`gcloud container images list-tags ${IMAGES_PATH} --format json`

IMAGES_COUNT=`echo $IMAGES_JSON | jq length`
echo "There are $IMAGES_COUNT images left"
if [ $IMAGES_COUNT -gt 1 ]; then 
    LAST_IMAGE_TAG=`echo ${IMAGES_JSON} | jq -r '.[-1] | .digest'`
    gcloud container images delete "$IMAGES_PATH@$LAST_IMAGE_TAG" --force-delete-tags
fi


