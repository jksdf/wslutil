#!/bin/bash
#
# Opens the specified files in windows.
function winstart() {
  if [ "$#" -eq "0" ]; then
    echo "Usage: [file...]" 1>&2;
    return;
  fi
  local call
  local winfile
  for file in "$@"; do
    winfile=$(winpath "$file")
    call+="start \"\" \"$winfile\"\n"
  done
  echo -e "$call" | cmd.exe > /dev/null
}
