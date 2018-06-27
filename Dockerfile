FROM alpine

LABEL maintainer="Lachlan Evenson <lachlan.evenson@gmail.com>"

ARG VCS_REF
ARG BUILD_DATE

# Metadata
ARG BRANCH=unknown
ARG BUILD_URL=http://localhost
ARG PULL_REQUEST=false
ARG REPO_URL='https://github.com/OpenGov/k8s-kubectl'
ARG REVISION={$VCS_REF}
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/OpenGov/k8s-helm" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      com.opengov.build.branch=${BRANCH} \
      com.opengov.build.build-url=${BUILD_URL} \
      com.opengov.build.pull-request=${PULL_REQUEST} \
      com.opengov.build.repo-url=${REPO_URL} \
      com.opengov.build.revision=${REVISION} \
      com.opengov.build.service=helm

ENV HELM_LATEST_VERSION="v2.9.1"

RUN apk add --update ca-certificates \
 && apk add --update -t deps wget \
 && wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && helm init --client-only

ENTRYPOINT ["helm"]
CMD ["help"]
