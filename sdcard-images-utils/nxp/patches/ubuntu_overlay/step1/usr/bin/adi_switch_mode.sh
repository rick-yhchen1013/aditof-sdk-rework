#! /bin/bash

if ! [ "x$1" = "xhost" -o "x$1" = "xembedded" ]; then
  echo "Please specify mode: host|embedded"
  exit -1
fi

if [ "x$1" = "xhost" ]; then
  systemctl enable uvc-gadget.service
  systemctl disable adi-embd.service
  systemctl set-default multi-user.target
elif [ "x$1" = "xembedded" ]; then
  systemctl enable adi-embd.service
  systemctl disable uvc-gadget.service
  systemctl set-default graphical.target
fi

