#!/bin/bash

# TODO replace absolute file path

file="./user_functions"
functionfile="$(realpath "$file")"

if [ -f "$functionfile" ]; then

source "$functionfile"

# tests for the nessacery file
needed="V1.50 *patched"
# needed="V1.50 *patched"

id="$(whoami)"

if [[ "$id" == "root" ]]; then
  if [ -f /opt/encore/scripts/encore ]; then

    encore version >/tmp/version
    version="$(cat /tmp/version)"

    if [[ "$version" == "$needed" ]]; then
      while getopts 'np:c:s:l:' OPTION; do
        case "$OPTION" in
        n)
          # ! Creating new user
          create_user
          ;;
        p)
          # ! changing passwd
          user="$OPTARG"
          change_passwd $OPTARG
          ;;
        c)
          user="$OPTARG"
          echo "Creating user $user"
          ;;
        s)
          user="$OPTARG"
          echo "Creating user $user"
          ;;
        l)
          user="$OPTARG"
          echo "Creating user $user"
          ;;
          #?)
          
        esac
      done
      shift "$(($OPTIND - 1))"

      # if a function exits wrong itll start executing here
      echo "Usage: usermod [-n] [-p] [-c] [-s] [-l] user"
      # echo -e "This script requires arguments \n"
      # echo -e "# user_script  "
      exit 1

    else
      echo -e "This version on encore is not supported please \n"
      echo -e "Use $needed or later \n"
      echo -e "Installed version $version"
      exit 1
    fi
  fi

else
  echo "you dont have the permission to run this ?"
  exit 1
fi

else 
echo -e "function file could not be sources"
exit 1
fi

# user modifications

# -n new user

# -p set passwd

# user_mod -p darrionw

# checks " initial password set = 1"
# enter new passwd
# enter new passwd again
# passwd set

# -c change passwd
# enter old passwd
# enter new passwd
# enter new passwd again

# -s sudo change passwd ( will require uid of zero )

# sudo user_mod -sc darrion

# enter new passwd
# enter new passwd again

# -l list user info

# user_mod list darrion

# enter passwd

# name xxx xxx

# phone number xxx xxx

# home dir /x/x/

# shell /shell
