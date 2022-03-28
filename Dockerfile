FROM quay.io/evryfs/base-ubuntu:focal-20220316
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ARG JDK_VERSION=18+36
ARG DOWNLOAD_URL=https://github.com/adoptium/temurin18-binaries/releases/download/jdk-18%2B36/OpenJDK18U-jdk_x64_linux_hotspot_18_36.tar.gz
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN	mkdir -p /usr/lib/jvm && \
	curl -Ls ${DOWNLOAD_URL} | tar xzv -C /usr/lib/jvm && \
	sh -c 'for bin in /usr/lib/jvm/jdk-${JDK_VERSION}/bin/*; do update-alternatives --install /usr/bin/$(basename $bin) $(basename $bin) $bin 100 ;done' && \
	sh -c 'for bin in /usr/lib/jvm/jdk-${JDK_VERSION}/bin/*; do update-alternatives --set $(basename $bin) $bin; done' && \
	java -Xshare:dump
