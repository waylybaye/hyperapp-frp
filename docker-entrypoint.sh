#!/bin/sh

CONF=/etc/frp/frps.ini
if ! [ -f $CONF ]; then
  echo "Create frps.ini"
  echo > $CONF
  echo "[common]" >> $CONF
  if [ ! -z $DASHBOARD_PORT] && [ ! -z $DASHBOARD_USER ] && [ ! -z $DASHBOARD_PWD ]; then
    echo "Create dashboard config"
    echo "dashboard_port = $DASHBOARD_PORT" >> $CONF
    echo "dashboard_user = $DASHBOARD_USER" >> $CONF
    echo "dashboard_pwd = $DASHBOARD_PWD" >> $CONF
  fi
  echo "[HyperApp]"
  echo "listen_port = $PROXY_PORT" >> $CONF
  echo "auth_token = $AUTH_TOKEN" >> $CONF
else
  echo "frps.ini already existed, ignore configures"
fi

exec "$@"
