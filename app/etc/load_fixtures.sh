#!/usr/bin/env bash

set -ueE 
set -o pipefail

HOST="${DB_HOST:-localhost}"
PORT="${DP_PORT:-6379}"

ARGS=""

[[ "${DB_PASSWORD:-false}" != false ]] && {
    ARGS="${ARGS} -a ${DB_PASSWORD}"
}

echo "Loading DB fixtures to ${DB_HOST}:${PORT}"
redis-cli -h "${HOST}" -p "${PORT}" ${ARGS} set stringFromDB 'Hello World'