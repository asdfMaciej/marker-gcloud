#!/bin/bash
# TODO: adjust service account, project

gcloud compute instances create marker-ocr-api \
    --project=halogen-basis-426411-d5 \
    --zone=europe-central2-c \
    --machine-type=n1-standard-2 \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --maintenance-policy=TERMINATE \
    --provisioning-model=STANDARD \
    --service-account=882891252370-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --accelerator=count=1,type=nvidia-tesla-t4 \
    --tags=http-server,https-server \
    --create-disk=auto-delete=yes,boot=yes,device-name=marker-ocr-api,image=projects/debian-cloud/global/images/debian-12-bookworm-v20240515,mode=rw,size=50,type=projects/halogen-basis-426411-d5/zones/europe-central2-c/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any

sleep 10

# The install_gpu_driver.py does not run apt-get upgrade in an non-interactive manner, which leads to crashes
# https://superuser.com/questions/1638779/automatic-yess-to-linux-update-upgrade
gcloud compute ssh \
    --zone "europe-central2-c" "marker-ocr-api" \
    --project "halogen-basis-426411-d5" \
    --command 'sudo bash -c "apt-get update && DEBIAN_FRONTEND=noninteractive UCF_FORCE_CONFFOLD=1  apt-get upgrade -y -o Dpkg::Options::=--force-confold --allow-downgrades --allow-remove-essential --allow-change-held-packages"'

# Download repository and prepare setup.sh
gcloud compute ssh \
    --zone "europe-central2-c" "marker-ocr-api" \
    --project "halogen-basis-426411-d5" \
    --command "sudo bash -c 'apt install -y git && git clone https://github.com/asdfMaciej/marker-gcloud.git && mv marker-gcloud/* ./ && chmod +x setup.sh'"
