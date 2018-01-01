#!/usr/bin/env bash

set -x

##
echo "Install additional dependencies ..."

#sudo apt-get install -y --no-install-recommends $pkg

#libcanberra-gtk-module software-properties-common
#x11-apps

##
echo "Install additional packages ..."

##
echo "Installing IntelliJ IDEA ..."

#idea_link="https://download.jetbrains.com/idea/ideaIC-2017.3.2.tar.gz"
idea_link="https://download.jetbrains.com/idea/ideaIC-2016.3.7.tar.gz"
wget "$idea_link" -O /tmp/idea.tar.gz --no-check-certificate --quiet --show-progress=on

sudo mkdir -p /opt/idea
sudo tar -xf /tmp/idea.tar.gz --strip-components=1 -C /opt/idea

rm /tmp/idea.tar.gz

sudo ln -sf /opt/idea/bin/idea.sh /usr/local/bin/

##
echo "Installing Go ..."

go_link=https://redirector.gvt1.com/edgedl/go/go1.9.2.linux-amd64.tar.gz
wget "$go_link" -O /tmp/go.tar.gz --no-check-certificate --quiet --show-progress=on

sudo tar -xf /tmp/go.tar.gz -C /usr/local/

rm /tmp/go.tar.gz

##
sudo tee -a /etc/bash.bashrc << 'EOF'
export PATH=$PATH:/usr/local/go/bin
EOF

#echo "export PATH=\"\$PATH:$HOME/go/bin:/usr/local/go/bin\"" >> $HOME/.bashrc

sudo git config --system http.sslVerify "false"

#
exit 0