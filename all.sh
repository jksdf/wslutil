#!/bin/bash
THIS=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
cd $(dirname $THIS)

source ./winstart.sh
source ./winpath.sh

