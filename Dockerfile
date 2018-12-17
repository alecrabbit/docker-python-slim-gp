FROM python:3.7.1-alpine3.8

ENV PS1='\[\033[1;32m\]🐳 \[\033[1;36m\][\u\033[38;05;224m@\h\[\033[1;36m\]] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
ENV PATH /scripts:/scripts/aliases:$PATH
ENV PATH /home/user/.local/bin:$PATH
ENV PYTHONUNBUFFERED 1

RUN apk update \
  && apk add \
    bash nano \
    build-base \
    postgresql \
    postgresql-dev \
    libpq \
  && rm -rf /home/user \
  && mkdir /home/user \
  && chmod 777 /home/user

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY ./keep-alive.sh /scripts/keep-alive.sh
COPY ./aliases/* /scripts/aliases/
