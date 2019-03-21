FROM python:stretch
LABEL Description="Python container"

ENV PS1='\[\033[1;32m\]🐳 \[\033[1;36m\][\u\033[38;05;224m@\h\[\033[1;36m\]] \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'
ENV PATH /scripts:/scripts/aliases:$PATH
ENV PATH /home/user/.local/bin:$PATH
ENV PYTHONUNBUFFERED 1

RUN set -xe \
  && apt-get update \
  && apt-get install -y \
      nano \
      # build-essential \
      libffi-dev \
      # libopenssl-dev \
      libfreetype6-dev \
      libpng-dev \
      libpq-dev \
      # python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose \
    && rm -rf /home/user \
    && mkdir /home/user \
    && chmod 777 /home/user

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY ./keep-alive.sh /scripts/keep-alive.sh
COPY ./aliases/* /scripts/aliases/

# COPY bin/entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
# CMD []
