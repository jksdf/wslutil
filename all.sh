#!/bin/bash
THIS=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
cd $(dirname $THIS)

source ./winstart.bash
source ./winpath.bash

