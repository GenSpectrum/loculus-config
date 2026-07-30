#!/bin/sh
set -eu

ORG="${1:?organism is required}"
CONFIG_DIR="/config/${ORG}"

export BACKEND_BASE_URL="http://backend:8079/${ORG}"

mkdir -p /app /preprocessing/input /preprocessing/output
cp "${CONFIG_DIR}/database_config.yaml" /preprocessing/input/database_config.yaml
cp "${CONFIG_DIR}/reference_genomes.json" /preprocessing/input/reference_genomes.json
cp "${CONFIG_DIR}/preprocessing_config.yaml" /app/preprocessing_config.yaml

exec python -m silo_import
