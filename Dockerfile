# Use Ubuntu as the base image
FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Add ARG for Overpass API version and mode
ARG OVERPASS_VERSION=0.7.55
ARG OVERPASS_MODE=api

# Install dependencies
RUN apt-get update && apt-get install -y \
  wget \
  g++ \
  make \
  expat \
  libexpat1-dev \
  libosmium2-dev \
  libbz2-dev \
  zlib1g-dev \
  osmium-tool \
  bzip2 \
  fcgiwrap \
  nginx \
  curl \
  jq \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Download and install Overpass API
RUN wget https://dev.overpass-api.de/releases/osm-3s_v${OVERPASS_VERSION}.tar.gz \
  && tar -xzf osm-3s_v${OVERPASS_VERSION}.tar.gz \
  && cd osm-3s_v${OVERPASS_VERSION} \
  && ./configure --prefix="/app/osm-3s" \
  && make \
  && make install \
  && cd .. \
  && rm -rf osm-3s_v${OVERPASS_VERSION} osm-3s_v${OVERPASS_VERSION}.tar.gz

# Set up environment variables
ENV PATH="/app/osm-3s/bin:${PATH}" \
  OVERPASS_META="yes" \
  OVERPASS_PLANET_URL="https://planet.openstreetmap.org/planet/planet-latest.osm.bz2" \
  OVERPASS_DIFF_URL="https://planet.openstreetmap.org/replication/minute/" \
  OVERPASS_COMPRESSION="gz" \
  OVERPASS_RULES_LOAD=1 \
  OVERPASS_UPDATE_FREQUENCY="minute" \
  OVERPASS_DB_DIR="/app/db" \
  OVERPASS_DIFF_DIR="/app/diffs" \
  OVERPASS_FASTCGI_PROCESSES=4 \
  OVERPASS_RATE_LIMIT=1024 \
  OVERPASS_TIME=1000 \
  OVERPASS_SPACE=536870912 \
  OVERPASS_MAX_TIMEOUT=1000

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the default Overpass API port
EXPOSE 80

# The entrypoint will be set by the Kubernetes manifest