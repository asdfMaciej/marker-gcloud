from pydantic import BaseModel

class OcrInput(BaseModel):
    url: str

    class Config:
        from_attributes = True

class OcrOutput(BaseModel):
    text: str | None 
    error: bool
    error_msg: str | None

    class Config:
        from_attributes = True