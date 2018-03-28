#!/bin/bash
#
# Opens the specified files in windows.
function winstart() {
  if [ "$#" -eq "0" ]; then
    echo "Usage: [file...]" 1>&2;
    return;
  fi
  local call
  for file in "$@"; do
    call+="start \"\" \"${file}\"\n"
  done
  echo -e "$call" | cmd.exe >2 /dev/null
}
