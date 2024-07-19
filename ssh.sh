#!/bin/bash
# TODO: adjust service account, project


gcloud compute ssh \
    --zone "europe-central2-c" "marker-ocr-api" \
    --project "halogen-basis-426411-d5"