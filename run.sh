#!/bin/sh

/bin/echo "Starting nanodep ..."

execServe="/usr/local/bin/depserver"

# API Key - Required
if [[ ! ${API_KEY} ]]; then
  /bin/echo "No API Key Set - Exiting"
  exit 1
else
  execServe="${execServe} -api ${API_KEY}"
fi

# Set debug
if [[ "${DEBUG}" = "true" ]]; then
  execServe="${execServe} -debug"
fi

# DSN - Required
if [[ ! ${DBUSER} ]] && [[ ! ${DBPASS} ]] && [[ ! ${DBNAME} ]]; then
  /bin/echo "Cannot set DSN - Exiting"
  exit 1
else
  execServe="${execServe} -storage mysql -dsn '${DBUSER}:${DBPASS}@tcp(${DBHOST:=127.0.0.1}:${DBPORT:=3306})/${DBNAME}'"
fi

# Port to listen on (default ":9000")
if [[ ${LISTEN} ]]; then
  execServe="${execServe} -listen ${LISTEN}"
fi

echo "Starting using: $execServe"

eval $execServe
