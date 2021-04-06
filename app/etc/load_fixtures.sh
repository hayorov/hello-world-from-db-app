#!/usr/bin/env bash

set -ueE 
set -o pipefail

echo "Loading DB fixtures..."
redis-cli set stringFromDB 'Hello World'