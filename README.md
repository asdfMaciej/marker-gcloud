# Marker deployment for GCloud

Provides a basic API for .pdf > .md OCR.

## Caveats 

Use at your own risk :)

- insecure - anyone with a link can access your API;
- can crash on PDFs with lots of pages;
- not guaranteed to be fully stable;

## Prerequirements

1. Create a GCloud project with access to Compute Engine machines with GPUs.

You will have to explicitely request GPU access for your first usage on Google Cloud.

2. Locally setup the `gcloud` command (auth, billing, etc.). 

In general, if you can start a Compute Engine machine via CLI and connect to it via SSH, your setup is enough.

## Setup and usage

1. Run `up.sh` to start the machine and run basic configuration.  **Note: you will be prompted twice for your SSH passphrase!** The SSH connection might fail if you wait too long before providing your password.

2. Connect to your machine via `ssh.sh` and run:

```bash
sudo su
./setup.sh
```

Manual actions might be needed to fully setup the machine. For example, the machine tends to drop my SSH connection in middle of the setup, and it can be necessary to run `dpkg --configure -a'` to fix system packages. I haven't fixed this due to time constraints. 

3. After setup, you can launch the web server:

```bash
uvicorn app.main:app --host 0.0.0.0 --port 80
```

The API will be available on the public IPv4 address under HTTP. 

There is a single endpoint that accepts a PDF url and returns a Markdown response OR an error stacktrace. Refer to `http://<IPv4>/docs`

4. Once you've processed your files, you can delete the Compute Engine instance to prevent unnecessary costs:

```bash
./down.sh
```

## Credits

Marker is used as the underlying OCR engine: https://github.com/VikParuchuri/marker
