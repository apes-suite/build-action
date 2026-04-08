FROM ghcr.io/apes-suite/apes-pyenv:2026.1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
