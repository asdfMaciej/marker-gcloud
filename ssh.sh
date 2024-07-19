#!/bin/bash
set -o allexport
source .env
set +o allexport

gcloud compute ssh \
    --zone $ZONE $INSTANCE \
    --project $PROJECT