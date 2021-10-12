#!/bin/bash
set -e

create_log_dir() {
  mkdir -p ${SQUID_LOG_DIR}
  chmod -R 755 ${SQUID_LOG_DIR}
}

create_cache_dir() {
  mkdir -p ${SQUID_CACHE_DIR}
}

create_log_dir
create_cache_dir

# allow arguments to be passed to squid
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --  #If no arguments follow this option, then the positional parameters are unset.
          #Otherwise, the positional parameters are set to the arguments,
          #even if some of them begin with a '-'.
elif [[ ${1} == squid || ${1} == $(which squid) ]]; then # if the first parameter is "squid" or "/some/dir/squid" then the extra args start later.
  EXTRA_ARGS="${@:2}"
  set --
fi

# default behaviour is to launch squid
if [[ -z ${1} ]]; then #if there are no extra arguments i.e. ${1} is null.
  if [[ ! -d ${SQUID_CACHE_DIR}/00 ]]; then
    echo "Initializing cache..."
    $(which squid) -N -f /etc/squid/squid.conf -z
  fi
  echo "Starting squid..."
  exec $(which squid) -f /etc/squid/squid.conf -NYCd 1 ${EXTRA_ARGS}
else
  exec "$@"
fi