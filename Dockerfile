FROM docker:18.03

# Install kubectl and skaffold.
RUN set -ex; \
    apk add --no-cache --virtual .fetch-deps curl; \
    \
    if ! curl --output kubectl --location --fail https://storage.googleapis.com/kubernetes-release/release/v1.9.6/bin/linux/amd64/kubectl; then \
         echo >&2 "error: failed to download kubectl for linux amd64"; \
         exit 1; \
    fi; \
    chmod +x ./kubectl; \
    mv ./kubectl /usr/local/bin/; \
    \
    if ! curl --output skaffold --location --fail https://storage.googleapis.com/skaffold/releases/download/v0.4.0/skaffold-linux-amd64; then \
         echo >&2 "error: failed to download skaffold for linux amd64"; \
         exit 1; \
    fi; \
    chmod +x ./skaffold; \
    mv ./skaffold /usr/local/bin/

ENTRYPOINT docker-entrypoint.sh && tail -f /dev/null
