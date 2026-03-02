#!/usr/bin/env bash
set -euo pipefail

# Au redémarrage du Codespace, on s'assure que les conteneurs sont up.
docker compose up -d
