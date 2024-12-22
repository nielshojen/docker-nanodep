#!/bin/sh

/bin/echo "Starting nanodep ..."

execServe="/usr/local/bin/depserver"

# API Key - Required
if [[ ! ${DEP_API_KEY} ]]; then
  /bin/echo "No API Key Set - Exiting"
  exit 0
else
  execServe="${execServe} -api ${DEP_API_KEY}"
fi

# Set debug
if [[ "${DEBUG}" = "true" ]]; then
  execServe="${execServe} -debug"
fi

# DSN - Required
if [[ ! ${DEP_DBUSER} ]] && [[ ! ${DEP_DBPASS} ]] && [[ ! ${DEP_DBNAME} ]]; then
  /bin/echo "Cannot set DSN - Exiting"
  exit 1
else
  execServe="${execServe} -storage mysql -storage-dsn '${DEP_DBUSER}:${DEP_DBPASS}@tcp(${DEP_DBHOST:=127.0.0.1}:${DEP_DBPORT:=3306})/${DEP_DBNAME}'"
fi

# Port to listen on (default ":9001")
if [[ ${LISTEN} ]]; then
  execServe="${execServe} -listen ${LISTEN}"
fi

echo "Starting using: $execServe"

eval $execServe &
