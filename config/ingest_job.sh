#!/bin/bash

set -euo pipefail

logdir="{{ loculus_path }}/log"

run_ingest() {
    local organism=$1
    cd "{{ loculus_path }}"
    docker compose run "ingest-$organism" snakemake results/submitted results/revised --all-temp >> "$logdir/ingest_$organism.log" 2>&1
    echo -e "\n\n-------------------------\n\n" >> "$logdir/ingest_$organism.log"
}

run_ingest h5n1
run_ingest rsv-a
run_ingest rsv-b
run_ingest mpox
