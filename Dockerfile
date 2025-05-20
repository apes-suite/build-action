FROM ghcr.io/apes-suite/apes-pyenv:2025.5

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
