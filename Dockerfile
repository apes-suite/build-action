FROM ghcr.io/apes-suite/apes-pyenv:2025.6

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
