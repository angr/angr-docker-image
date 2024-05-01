FROM ubuntu:noble

RUN apt-get update \
    && apt-get -o APT::Immediate-Configure=0 install -y python3-dev python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -s /bin/bash -m angr
USER angr
WORKDIR /home/angr

RUN python3 -m venv --prompt angr .venv
RUN echo "source /home/angr/.venv/bin/activate" >> /home/angr/.bashrc
RUN /home/angr/.venv/bin/pip install -U pip setuptools  # setuptools required for capstone with python 3.12

ARG ANGR_VERSION
RUN /home/angr/.venv/bin/pip install angr[AngrDB,pcode]==${ANGR_VERSION}
