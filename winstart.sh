#!/bin/bash
#
# Opens the specified files in windows.
THIS=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
source "$(dirname $THIS)/winpath.sh"

function winstart() {
  if [ "$#" -eq "0" ]; then
    echo "Usage: [file...]" 1>&2;
    return;
  fi
  local call
  local winfile
  for file in "$@"; do
    winfile=$(winpath "$file" | sed "s/\\\\/\\\\\\\\/g")
    call+="start \"\" \"$winfile\"\n"
  done
  echo -e "$call" | cmd.exe > /dev/null
}
