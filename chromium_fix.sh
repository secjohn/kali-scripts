#!/bin/bash
#Simple script to allow Chromium to run as root for Kali Linux
#Used Chromium not Chrome because there is a package for it and the
#Kali dudes love packages, apt-get install chromium is required
#to be run before you use the script.
#John Woods

#Note, this is hard coded in the sed statement, if you change it here change it
#manually in the sed statement below or things won't work out.
HOMEDIR=/home/chrome

if [ -d $HOMEDIR ] ;
  then
  echo -e "\e[1;34m[*] Using existing $HOMEDIR dir.\e[0m"
else
  mkdir $HOMEDIR
  echo -e "\e[1;34m[*]Using new $HOMEDIR dir.\e[0m"
fi

if [ -f /usr/bin/chromium ] ;
  then
  grep $HOMEDIR /usr/bin/chromium
  if [ $? = 0 ] ;
    then
    echo -e "\e[1;34m[*]Looks like you are already good.\e[0m"
  else
  sed -i 's|exec $LIBDIR/$APPNAME $CHROMIUM_FLAGS "$@"|exec $LIBDIR/$APPNAME $CHROMIUM_FLAGS "$@"--user-data-dir=/home/chrome|g' /usr/bin/chromium
  echo -e "\e[1;34m[*]Chromium should run for the root user now.\e[0m"
  fi
else
  echo -e "\e[1;34m[*]Chromium not installed, install it and try again, use apt-get install chromium\e[0m"
fi
