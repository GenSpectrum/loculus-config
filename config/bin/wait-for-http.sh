#!/bin/sh
set -eu

TIMEOUT_SECONDS="${WAIT_TIMEOUT_SECONDS:-300}"

python - "$TIMEOUT_SECONDS" "$@" <<'PY'
import sys
import time
from urllib.request import Request, urlopen

timeout = int(sys.argv[1])
urls = sys.argv[2:]
deadline = time.time() + timeout

for url in urls:
    while True:
        try:
            request = Request(url, method="GET")
            with urlopen(request, timeout=5) as response:
                if response.status < 500:
                    break
        except Exception:
            pass
        if time.time() >= deadline:
            raise SystemExit(f"Timed out waiting for {url}")
        time.sleep(2)
PY
