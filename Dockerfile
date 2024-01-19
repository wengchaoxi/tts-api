# syntax=docker/dockerfile:1.2
FROM python:3.10-slim-buster

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive \
    DEBIAN_APT_MIRROR=mirrors.ustc.edu.cn \
    PIP_NO_CACHE_DIR=off \
    PIP_INDEX_URL=https://mirrors.aliyun.com/pypi/simple/

RUN --mount=type=cache,target=/var/cache/apt \
    sed -i "s/deb.debian.org/${DEBIAN_APT_MIRROR}/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install build-essential libssl-dev ca-certificates libasound2 wget -y && \
    wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb && \
    dpkg -i libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb && \
    rm -f libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt

COPY . .

EXPOSE 9000
CMD ["python", "main.py"]
