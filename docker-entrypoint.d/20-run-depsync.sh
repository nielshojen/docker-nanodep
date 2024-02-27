#!/bin/sh

if [ ! ${DEPNAMES} ]; then
  /bin/echo "Not starting depsyncer"
  exit 0
fi

/bin/echo "Starting depsyncer ..."

execServe="/usr/local/bin/depsyncer"

# Set debug
if [[ "${DEBUG}" = "true" ]]; then
  execServe="${execServe} -debug"
fi

if [[ "${DEBUG_ASSIGNER}" = "true" ]]; then
  execServe="${execServe} -debug-assigner"
fi

if [[ "${DEBUG_SYNCER}" = "true" ]]; then
  execServe="${execServe} -debug-syncer"
fi

# Duration in seconds between DEP syncs (default 1800)
if [[ "${DURATION}" = "true" ]]; then
  execServe="${execServe} -duration"
fi

# Limit fetch and sync calls to this many devices
if [[ "${LIMIT}" = "true" ]]; then
  execServe="${execServe} -limit"
fi

# DSN - Default is file
if [[ ${DBUSER} ]] && [[ ${DBPASS} ]] && [[ ${DBNAME} ]]; then
  execServe="${execServe} -storage mysql -storage-dsn '${DBUSER}:${DBPASS}@tcp(${DBHOST:=127.0.0.1}:${DBPORT:=3306})/${DBNAME}'"
fi

# Port to listen on (default ":9001")
if [[ ${WEBHOOK} ]]; then
  execServe="${execServe} -webhook-url ${WEBHOOK}"
fi

# Depnames
for name in ${DEPNAMES}; do
  execServe="${execServe} ${name}"
done

echo "Starting using: $execServe"

eval $execServe &