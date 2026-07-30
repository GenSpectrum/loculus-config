#!/bin/sh
set -eu

ORG="${1:?organism is required}"
INTERVAL_SECONDS="${INGEST_INTERVAL_SECONDS:-7200}"
INITIAL_DELAY_SECONDS="${2:-0}"

mkdir -p /package/config
cp "/config/${ORG}/config.yaml" /package/config/config.yaml

if [ "$INITIAL_DELAY_SECONDS" -gt 0 ]; then
  echo "Waiting ${INITIAL_DELAY_SECONDS}s before first ingest run for ${ORG}"
  sleep "$INITIAL_DELAY_SECONDS"
fi

while true; do
  /bin/sh /usr/local/bin/wait-for-http.sh \
    http://keycloak:8080/realms/loculus \
    http://backend:8079/actuator/health
  echo "Starting ingest run for ${ORG}"
  # Upstream runs ingest as a Kubernetes CronJob, i.e. every run starts in a
  # fresh working directory. Here the container is long-lived, so the previous
  # run's results (including the downloaded NCBI dataset) would make Snakemake
  # consider everything up to date and skip the whole workflow.
  rm -rf /package/results
  if snakemake results/submitted results/revised --all-temp; then
    echo "Finished ingest run for ${ORG}"
  else
    status=$?
    echo "Ingest run for ${ORG} failed with exit code ${status}"
  fi
  echo "Waiting ${INTERVAL_SECONDS}s before next ingest run for ${ORG}"
  sleep "$INTERVAL_SECONDS"
done
