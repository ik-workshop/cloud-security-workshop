# docker build . --tag test --build-arg AWS_DEFAULT_REGION=eu-west-1 -f Dockerfile
FROM python:3.7-slim as cloudmapper

LABEL maintainer="https://github.com/0xdabbad00/"
# hadolint ignore=DL3018,DL3048
LABEL Project="https://github.com/duo-labs/cloudmapper"

EXPOSE 8000
WORKDIR /opt
ENV AWS_DEFAULT_REGION=us-east-1

# renovate: datasource=github-releases depName=duo-labs/cloudmapper
ENV PACKAGE_VERSION=2.9.1

# hadolint ignore=DL3009
RUN apt-get update -y
RUN apt-get install -y build-essential autoconf automake libtool python3.7-dev python3-tk jq awscli git
RUN apt-get install -y bash

RUN git clone https://github.com/duo-labs/cloudmapper --depth=1
WORKDIR /opt/cloudmapper
RUN git fetch --tags && git checkout tags/${PACKAGE_VERSION}
RUN pip install -r requirements.txt

RUN bash
