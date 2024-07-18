from fastapi import FastAPI
from . import schemas 
import os
import requests

from marker.convert import convert_single_pdf
from marker.models import load_all_models
from marker.settings import settings

app = FastAPI()

# Load Marker models
model_lst = load_all_models()

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/ocr")
def ocr(input: schemas.OcrInput) -> schemas.OcrOutput:
    fname = None
    try:
        url = input.url

        print(f"Attempting to connect to {url}")
        # Download the file from the URL
        response = requests.get(url)
        response.raise_for_status()

        # Save the file to a random path under tmp
        fname = "/tmp/" + os.urandom(24).hex()
        print(f"Attempting to save contents to {fname}")
        with open(fname, "wb") as f:
            f.write(response.content)
        
        full_text, images, out_meta = convert_single_pdf(fname, model_lst, langs=["Polish"])

        return schemas.OcrOutput(text=full_text, error=False, error_msg=None)
    except Exception as e:
        return schemas.OcrOutput(text=None, error=True, error_msg=repr(e))
    finally:
        # Delete the file
        if fname and os.path.exists(fname):
            os.remove(fname)
        print(f"{fname} deleted.")
    