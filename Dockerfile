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
    openssh-client \
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
    xterm \
    libcanberra-gtk-module

RUN ln -sf bash /bin/sh

##
ENV LOGIN=vcap
ENV HOME /home/$LOGIN

RUN echo "Add su user $LOGIN ..." \
    && useradd -m -b /home -s /bin/bash $LOGIN \
    && echo "$LOGIN ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "export PATH=\"\$PATH:$HOME/go/bin:/usr/local/go/bin\"" >> /etc/bash.bashrc

# Install additional packages
RUN echo "Installing IntelliJ IDEA ..." \
    && wget "https://download.jetbrains.com/idea/ideaIC-2016.3.7.tar.gz" -O /tmp/idea.tar.gz --no-check-certificate --quiet --show-progress=off \
    && mkdir -p /opt/idea \
    && tar -xf /tmp/idea.tar.gz --strip-components=1 -C /opt/idea \
    && rm /tmp/idea.tar.gz

RUN ln -sf /opt/idea/bin/idea.sh /usr/local/bin/ide

##
RUN echo "Installing Go ..." \
    && wget "https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz" -O /tmp/go.tar.gz --no-check-certificate --quiet --show-progress=off \
    && tar -xf /tmp/go.tar.gz -C /usr/local/ \
    && rm /tmp/go.tar.gz

ENV GOROOT /usr/local/go

#
RUN git config --system http.sslVerify "false"

##
USER $LOGIN
ENV GOPATH /home/$LOGIN/go

WORKDIR /home/$LOGIN

#
ADD --chown=vcap:vcap .dhnt $HOME

##
CMD ["/bin/bash"]

##
