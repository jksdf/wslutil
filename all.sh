#!/bin/bash
__WSL_TMP=$(pwd)
__WSL_THIS=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
cd $(dirname $__WSL_THIS)
source ./winstart.sh
source ./winpath.sh
source ./wsl-notify-send.sh

cd "$__WSL_TMP"

