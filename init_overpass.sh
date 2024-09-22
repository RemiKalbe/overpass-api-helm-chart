#!/bin/bash

set -e

OVERPASS_DB_DIR="/app/db"
OVERPASS_DIFF_DIR="/app/diffs"

initialize_database() {
  if [ ! -f "$OVERPASS_DB_DIR/replicate_id" ]; then
    echo "Initializing database..."
    mkdir -p "$OVERPASS_DB_DIR"
    mkdir -p "$OVERPASS_DIFF_DIR"
    wget -O "/app/planet.osm.bz2" "$OVERPASS_PLANET_URL"
    /app/osm-3s/bin/init_osm3s.sh "/app/planet.osm.bz2" "$OVERPASS_DB_DIR" "/app/osm-3s" --meta="$OVERPASS_META" "--compression-method=$OVERPASS_COMPRESSION"
    rm "/app/planet.osm.bz2"
    echo "Database initialization complete."
  else
    echo "Database already initialized."
  fi
}

main() {
  initialize_database
}

main