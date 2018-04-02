#!/bin/bash
function wsl-notify-send() {

  while [ "$#" -ne "0" ]; do
    PARAM=$(echo $1 | awk -F= '{print $1}')
    if echo "$!" | grep -q "="; then
      VALUE=$(echo $1 | awk -F= '{print $2}')
    else
      shift
      VALUE=$($1)
    fi
    
    case $PARAM in
      -? | --help)
        echo "See 'man'."
        exit
        ;;
      -u | --urgency)
        URGENCY="$VALUE"
        ;;
      -t | --expire-time)
        EXPIRE="$VALUE"
        ;;
      -i | --icon)
        ICON="$VALUE"
        ;;
      -c | --category)
        CATEGORY="$VALUE"
        ;;
      -h | --hint)
        HINT=$VALUE
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  DICON="icons/info.png"
  if [ "$URGENCY" -eq "critical" ]; then
    DICON="icons/error.png"
  fi
  
  if [ "$EXPIRE" -ne "" ]; then
    echo "Expire time does not work in this implementation." 1>&2
  fi

  if [ "$ICON" -ne "" ]; then
    DICON="$ICON"
  fi

  
  
  if [ "$#" -eq "0" ]; then
    echo "Set params"
    return 1
  fi
  
  local REQUEST=""

  while [ "$#" -ne "1" ]; do
    REQUEST+="\"$1\", "
    shift
  done 
  REQUEST+=\"$1\"
  
  powershell.exe -ExecutionPolicy Bypass -NoLogo -NoProfile -NonInteractive -COMMAND "Import-Module BurntToast; New-BurntToastNotification -Text $REQUEST"
}
