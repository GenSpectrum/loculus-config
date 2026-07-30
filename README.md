# GenSpectrum Loculus Configuration

The recommended setup for Loculus is based on Kubernetes and tutorials are available on the Loculus homepage (e.g. [this one for a local setup](https://loculus.org/for-administrators/my-first-loculus/) and [this one using k3d and nginx](https://loculus.org/for-administrators/setup-with-k3d-and-nginx/)).

If Kubernetes is not an option, you may explore the option of using a Docker Compose-based setup. This repository provides a small Docker Compose reference for running Loculus with RSV A and H5N1. It includes ingestion, preprocessing, SILO, LAPIS, Keycloak and PostgreSQL.

## Start

```sh
docker compose up -d
```

The default local endpoints are:

| Service | URL |
| --- | --- |
| Website | http://localhost:3000 |
| Backend | http://localhost:8079 |
| LAPIS gateway | http://localhost:8080 |
| Keycloak | http://localhost:8083 |

Keycloak admin credentials are `admin:admin`. Ingest starts automatically and repeats every two hours.

## Configuration

Runtime configuration lives under `config/`. Copy the optional environment example to change the Loculus image version, ports, or the NCBI API key:

```sh
cp .env.example .env
```

## Stop

```sh
docker compose down
docker compose down -v
```

The second command also removes all local data.
