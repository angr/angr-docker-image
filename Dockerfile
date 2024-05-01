FROM ubuntu:noble
ARG ANGR_VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -o APT::Immediate-Configure=0 install -y python3-dev python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -s /bin/bash -m angr
USER angr
WORKDIR /home/angr

RUN python3 -m venv --prompt angr .venv
RUN bash -c "source .venv/bin/activate && pip install -U pip"
RUN bash -c "source .venv/bin/activate && pip install setuptools"  # Required for capstone with pyhton 3.12
RUN bash -c "source .venv/bin/activate && pip install angr[AngrDB,pcode]==${ANGR_VERSION}"
RUN echo "source /home/angr/.venv/bin/activate" >> /home/angr/.bashrc

CMD ["/bin/bash"]
