#!/bin/bash
# Run as elevated user

apt-get install -y python3.11-venv
curl https://raw.githubusercontent.com/GoogleCloudPlatform/compute-gpu-installation/main/linux/install_gpu_driver.py --output install_gpu_driver.py
python3 -m venv ~/local
python3 install_gpu_driver.py
source ~/local/bin/activate
apt-get install -y python3-pip python3-opencv
pip3 install torch torchvision torchaudio
pip3 install fastapi uvicorn marker-pdf

# Now it's possible to run the application:
# uvicorn app.main:app --host 0.0.0.0 --port 80
