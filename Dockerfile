FROM python:3.14

# Start of code to make Poppler work in a container
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    cmake \
    libnss3 \
    libnss3-dev \
    libcairo2-dev \
    libjpeg-dev \
    libgif-dev \
    cmake \
    libblkid-dev \
    e2fslibs-dev \
    libboost-all-dev \
    libaudit-dev \
    libopenjp2-7-dev \
    g++  # Aggiunto il pacchetto g++

RUN wget https://poppler.freedesktop.org/poppler-21.09.0.tar.xz \
    && tar -xvf poppler-21.09.0.tar.xz \
    && cd poppler-21.09.0 \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release \
             -DCMAKE_INSTALL_PREFIX=/usr \
             -DTESTDATADIR=$PWD/testfiles \
             -DENABLE_UNSTABLE_API_ABI_HEADERS=ON \
             .. \
    && make \
    && make install

ENV PATH="/poppler-21.09.0/build/utils:${PATH}"

# End of code to make Poppler work in a container

WORKDIR /app

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6 -y

RUN pip install img2pdf ollama_ocr flask

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY main.py /app/main.py

CMD ["python", "main.py"]