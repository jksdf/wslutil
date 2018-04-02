#!/bin/bash

__WSL_TMP=$(pwd)
__WSL_THIS=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
cd $(dirname $__WSL_THIS)
source ./winpath.sh
cd "$__WSL_TMP"

wsl-notify-send() {
  
  ISVAL=0
  VALNAME=""

  while [ "$#" -ne "0" ]; do
    if [ "$ISVAL" -eq "1" ]; then
      if echo "$1" | grep -q "="; then
        VALUE=$(echo $1 | awk -F= '{print $2}')
      else
        VALUE=$1
        shift
      fi
      #echo "setting $VALNAME to $VALUE"
      declare $VALNAME=$VALUE
      VALNAME=""
      ISVAL=0
    else
      EQSPLIT=0
      if echo "$1" | grep -q "="; then
        EQSPLIT=1
      fi
      PARAM=$(echo $1 | awk -F= '{print $1}')
      case $PARAM in
        -hh | --help)
          echo "See 'man'."
          return 1
          ;;
        -u | --urgency)
          ISVAL=1
          VALNAME="URGENCY"
          ;;
        -t | --expire-time)
          ISVAL=1
          VALNAME="EXPIRE"
          ;;
        -i | --icon)
          ISVAL=1
          VALNAME="ICON"
          ;;
        -c | --category)
          ISVAL=1
          VALNAME="CATEGORY"
          ;;
        -h | --hint)
          ISVAL=1
          VALNAME="HINT"
          ;;
        *)
          break
          ;;
      esac
      if [ $EQSPLIT -eq "0" ]; then
        shift
      fi
    fi
  done

  DICON="icons/info.png"
  if [ "0$URGENCY" == "0critical" ]; then
    DICON="icons/error.png"
  fi

  if [ "x$URGENCY" == "xinfo" ]; then
    SOUND="-Silent"
  fi
  
  if [ "x$EXPIRE" != "x" ]; then
    echo "Expire time does not work in this implementation." 1>&2
  fi

  if [ "x$ICON" != "x" ]; then
    DICON="$ICON"
  fi
  
  if [ "$#" == "0" ]; then
    echo "Set params"
    return 1
  fi
  
  local REQUEST=""
  while [ "$#" -ne "1" ]; do
    REQUEST+="\"$1\", "
    shift
  done 
  REQUEST+=\"$1\"
  
  DICON=$(winpath "$DICON")

  #echo "Import-Module BurntToast; New-BurntToastNotification -AppLogo \"$DICON\" $SOUND -Text $REQUEST"
  powershell.exe -ExecutionPolicy Bypass -NoLogo -NoProfile -NonInteractive -COMMAND "Import-Module BurntToast; New-BurntToastNotification -AppLogo \"$DICON\" $SOUND -Text $REQUEST"
}
