##
FROM ubuntu:16.04

MAINTAINER Qiang Li "li.qiang@gmail.com"

##
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    curl \
    git \
    sudo \
    unzip \
    wget \
    zip \
    \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libxslt1.1 \
    libgtk2.0-0 \
    \
    xterm

RUN ln -sf bash /bin/sh

##
ENV LOGIN=vcap
ENV HOME /home/$LOGIN

RUN useradd -m -b /home -s /bin/bash $LOGIN \
    && echo "$LOGIN ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $LOGIN
WORKDIR /home/$LOGIN

# Install additional packages
COPY script/install-pkg.sh /tmp/install-pkg.sh
RUN /bin/bash /tmp/install-pkg.sh

##
CMD ["/bin/bash"]