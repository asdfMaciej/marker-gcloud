#!/bin/bash
# TODO: adjust service account, project

gcloud compute instances delete marker-ocr-api \
    --zone=europe-central2-c \
    --project=halogen-basis-426411-d5
