#!/bin/sh
set -eu

org="${1:?organism is required}"
shift

cp "/config/${org}/database_config.yaml" /workspace/database_config.yaml
cp "/config/${org}/reference_genomes.json" /workspace/reference_genomes.json

exec /workspace/entrypoint.sh "$@"
