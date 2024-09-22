#!/bin/bash

set -e

OVERPASS_DB_DIR="/app/db"
OVERPASS_DIFF_DIR="/app/diffs"

start_api_and_updates() {
  echo "Starting Overpass API and update process..."
  /app/osm-3s/bin/dispatcher --osm-base --meta="$OVERPASS_META" --db-dir="$OVERPASS_DB_DIR" &
  
  # Start the continuous update process
  /app/osm-3s/bin/fetch_osc.sh "$OVERPASS_UPDATE_FREQUENCY" "$OVERPASS_DIFF_URL" "$OVERPASS_DIFF_DIR" &
  /app/osm-3s/bin/apply_osc_to_db.sh "$OVERPASS_DIFF_DIR" "$OVERPASS_UPDATE_FREQUENCY" --meta="$OVERPASS_META" &
  /app/osm-3s/bin/rules_loop.sh "$OVERPASS_DB_DIR" "$OVERPASS_RULES_LOAD" &

  echo "Configuring and starting fcgiwrap..."
  sed -i "s/FCGI_CHILDREN=.*/FCGI_CHILDREN=$OVERPASS_FASTCGI_PROCESSES/" /etc/init.d/fcgiwrap
  service fcgiwrap start

  echo "Configuring Overpass settings..."
  echo "$OVERPASS_RATE_LIMIT" > "$OVERPASS_DB_DIR/rate_limit"
  echo "$OVERPASS_TIME" > "$OVERPASS_DB_DIR/max_allowed_time"
  echo "$OVERPASS_SPACE" > "$OVERPASS_DB_DIR/max_allowed_space"
  echo "$OVERPASS_MAX_TIMEOUT" > "$OVERPASS_DB_DIR/max_allowed_timeout"

  echo "Starting nginx..."
  nginx -g 'daemon off;'
}

main() {
  start_api_and_updates
}

main