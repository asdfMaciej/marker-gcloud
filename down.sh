#!/bin/bash
set -o allexport
source .env
set +o allexport

gcloud compute instances delete $INSTANCE \
    --zone=$ZONE \
    --project=$PROJECT
