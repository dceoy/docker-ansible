FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        aptitude ca-certificates curl libffi-dev libssl-dev python3.8-dev \
        python3.8-distutils ssh sudo \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && /usr/bin/python3.8 /tmp/get-pip.py \
      && pip install -U --no-cache-dir ansible pip pyopenssl \
      && rm -f /tmp/get-pip.py

ENTRYPOINT ["/usr/local/bin/ansible"]
