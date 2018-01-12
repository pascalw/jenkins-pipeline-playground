#!/usr/bin/env bash
[[ $TRACE ]] && set -x
CACHE_TAR="/cache/cache-$JOB_BASE_NAME.tar"
FALLBACK_CACHE_TAR="/cache/cache-master.tar"

store() {
  tar cf "$CACHE_TAR" -C /tmp/ .
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

  clean
}

clean() {
  echo "Cleaning up old caches"

  cd /cache/
  ls -tp | grep -v '/$' | tail -n +6 | xargs -I {} rm -- {}
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
