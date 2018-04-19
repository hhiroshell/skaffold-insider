FROM docker:18.03

RUN set -ex; \
    apk add --no-cache --virtual .fetch-deps curl

# Install kubectl v1.9.6.
RUN if ! curl --output kubectl --location --fail https://storage.googleapis.com/kubernetes-release/release/v1.9.6/bin/linux/amd64/kubectl; then \
         echo >&2 "error: failed to download kubectl for linux amd64"; \
         exit 1; \
    fi; \
    chmod +x ./kubectl; \
    mv ./kubectl /usr/local/bin/

# Install helm v2.8.2
RUN if ! curl --output helm-v2.8.2-linux-amd64.tar.gz --location --fail https://storage.googleapis.com/kubernetes-helm/helm-v2.8.2-linux-amd64.tar.gz; then \
         echo >&2 "error: failed to download helm for linux amd64"; \
         exit 1; \
    fi; \
    ls; \
    tar -zxvf ./helm-v2.8.2-linux-amd64.tar.gz; \
    chmod +x ./linux-amd64/helm; \
    mv ./linux-amd64/helm /usr/local/bin/; \
    rm -rf ./linux-amd64/ && rm ./helm-v2.8.2-linux-amd64.tar.gz

# Install skaffold latest.
# Version specified download links seems not to be accessible.
RUN if ! curl --output skaffold --location --fail https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 ; then \
         echo >&2 "error: failed to download skaffold for linux amd64"; \
         exit 1; \
    fi; \
    chmod +x ./skaffold; \
    mv ./skaffold /usr/local/bin/

ENTRYPOINT docker-entrypoint.sh && tail -f /dev/null
