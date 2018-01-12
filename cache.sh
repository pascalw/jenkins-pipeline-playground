#!/usr/bin/env bash
CACHE_TAR="/cache/cache-$JOB_BASE_NAME"
FALLBACK_CACHE_TAR="/cache/cache-master"

store() {
  tar cf "$CACHE_TAR" -c /tmp/ .
}

restore() {
  if [ -e "$CACHE_TAR" ]; then
    echo "Restoring branch specific cache: $CACHE_TAR"
    cd /tmp/ && rm -rf ./* && tar xf "$CACHE_TAR"
  elif [ -e "$FALLBACK_CACHE_TAR" ]; then
    echo "Restoring master (fallback) cache: $FALLBACK_CACHE_TAR"
    cd /tmp/ && rm -rf ./* && tar xf "$FALLBACK_CACHE_TAR"
  else
    echo "Found no cache to restore"
  fi
}

case "$1" in
  "store")
    store
    ;;
  "restore")
    restore
    ;;
  *)
    echo "Invalid command given"
    exit 1
    ;;
esac
