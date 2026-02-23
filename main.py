from ollama_ocr import OCRProcessor
from pdf2image import convert_from_bytes
import requests
import uuid
import os
from flask import Flask, request

image_dpi = 125

def save_images(url):
    pdf_bytes = requests.get(url).content

    images = convert_from_bytes(pdf_bytes, dpi=image_dpi)

    myuuid = uuid.uuid4()

    image_paths = []

    os.makedirs(f"images/{myuuid}")

    for i in range(len(images)):
        image = images[i]
        path = f'images/{myuuid}/{i}.png'
        image_paths.append(path)
        image.save(f'images/{myuuid}/{i}.png')

    return image_paths

def delete_images(paths):
    for path in paths:
        os.remove(path)

def get_text(url):
    if (url == None):
        raise Exception("Must provide url to pdf")

    paths = save_images(url)

    ocr = OCRProcessor(model_name='ministral-3:3b')
    
    result = ocr.process_batch(
        input_path=paths,
        format_type="markdown",
        language="nl",
    )

    delete_images(paths)

    return result

app = Flask(__name__)

@app.route('/', methods=["POST"])
def handleDocument():
    url = request.get_json().get("url")

    res = get_text(url)

    return str(res)

app.run()