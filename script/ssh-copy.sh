#!/bin/bash

set -x

##
[ $# -lt 1 ] && exit 1

target=$1

ssh_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp -R $ssh_dir $target
chmod 700 $target
chmod 600 $target/id_rsa
chmod 622 $target/id_rsa.pub
chmod 622 $target/known_hosts

##