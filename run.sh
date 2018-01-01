#!/usr/bin/env bash

#
set -x

#docker pull dhnt/ide

# behind corporate firewall - http_proxy host needs to be ip address
# e.g. export http_proxy=http://10.10.10.10:8080

[ -z "$http_proxy" ] && proxy="" || proxy="-e http_proxy=$http_proxy -e https_proxy=$http_proxy -e no_proxy=$no_proxy"

#find local ip for X server
#required utils
printf "ifconfig \n awk \n xset \n xhost \n" | xargs -n1 -I{} sh -c 'which {} || exit 255'; if [ $? -ne 0 ]; then
    exit 1
fi
#
ipaddr=$(ifconfig | grep 'inet ' | grep -e '10\.' -e '172\.' -e '192\.'| awk '{$1=$1; print}'|cut -d' ' -f2 | cut -d: -f2 | xargs -n1 -I{} bash -c 'export DISPLAY={}:0; xset q 2>&1 > /dev/null && echo {} && exit 255;' 2> /dev/null)

export DISPLAY=${ipaddr}:0
xhost + $ipaddr

#
export DHNT_BASE=~/.dhnt

unix_name=$(uname)
if [ "$unix_name" =~ "Microsoft" ]; then
    export DHNT_BASE=/c/Users/liqiang/AppData/.dhnt
fi

#
volume="-v ${DHNT_BASE}/go:/home/vcap/go"
[ -d "/private/tmp" ] && volume="$volume -v /private/tmp:/private/tmp"

docker run $proxy $volume -e DISPLAY=${DISPLAY} -it --rm --privileged --name dhnt-ide dhnt/ide
