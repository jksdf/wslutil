#!/bin/bash

function winstart() {
  local call
  for file in "$@"
  do
    call+="start \"\" \"${file}\"\n"
  done
  echo -e "$call" | cmd.exe >2 /dev/null
}
