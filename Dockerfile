FROM python:slim
LABEL Description="Python container"

ENV PS1='\[\033[1;32m\]🐳 \[\033[1;36m\][\u\033[38;05;224m@\h\[\033[1;36m\]] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
ENV PATH /scripts:/scripts/aliases:$PATH
ENV PATH /home/user/.local/bin:$PATH
ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/src/app
COPY ./requirements.txt /usr/src/app/requirements.txt

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
      nano \
      libfreetype6-dev \
      libpng-dev \
      python3-tk \
      libpq-dev \
    && rm -rf /home/user \
    && mkdir /home/user \
    && chmod 777 /home/user \
    && pip install -r /usr/src/app/requirements.txt \
    && rm -rf /var/lib/apt/lists/* \
    && rm /usr/src/app/requirements.txt

COPY ./keep-alive.sh /scripts/keep-alive.sh
COPY ./aliases/* /scripts/aliases/
WORKDIR /usr/src/app
