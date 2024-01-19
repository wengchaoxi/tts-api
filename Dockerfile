FROM python:3.10-slim-buster

WORKDIR /app

RUN --mount=type=cache,target=/var/cache/apt \
    sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install build-essential libssl-dev ca-certificates libasound2 wget -y && \
    wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb && \
    dpkg -i libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb && \
    rm -f libssl1.1_1.1.1f-1ubuntu2.20_amd64.deb

COPY requirements.txt ./
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

COPY . .

EXPOSE 9000
CMD ["python", "main.py"]
