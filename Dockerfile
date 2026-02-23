FROM python:3.14

WORKDIR /app

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6 img2pdf -y

RUN pip install ollama_ocr flask

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY main.py /app/main.py

CMD ["python", "main.py"]