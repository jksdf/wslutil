#!/bin/bash
#
# Converter between bash and Windows paths

LXSSPATH="C:\\Users\\noro\\AppData\\Local\\lxss\\"
LXSSPATHESCAPED="$(echo $LXSSPATH | sed -e 's/[\/&]/\\&/g')"

function winpath(){
  if [ "$#" -eq "0" ]; then
    echo "Usage: winpath [file]" 1>&2
    return
  elif [ "$#" -eq "1" ]; then
    local file
    file=$(readlink -f "$1" | sed "s/^\(.*[^\/]\)$/\1\//g")
    # /mnt/x...  --->  x:\...
    if echo "$file" | grep -q "^\/mnt\/."; then
       echo $file \
        | sed -e "s/^\/mnt\/\([^\/]*\)\/\(.*\)$/\1:\/\2/g;\
                  s/\/$//g;\
                  s/\//\\\\/g"
    # /home/...  --->  $LXSSPATH\...
    elif echo "$file" | grep -q "^\/home\/"; then
      echo $file | sed -e "s/^\///g; \
                           s/\/$//g; \
                           s/\//\\\\/g; \
                           s/^/$LXSSPATHESCAPED/g"
    # /...  --->  $LXSSPATH\rootfs\...
    else
      echo $file | sed -e "s/^\/\(.*\)$/\1/g; \
                           s/\/$//g; \
                           s/\//\\\\/g; \
                           s/^/${LXSSPATHESCAPED}rootfs\\\\/g"
    fi
  fi
}


#function bashpath(){}
