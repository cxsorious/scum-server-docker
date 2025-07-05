FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

ENV UID=1000
ENV GID=1000

ENV WINEARCH=win64
ENV HOME=/home/scum
ENV WINEPREFIX=${HOME}/wine64

ENV SCUM_PORT=7777
ENV SCUM_MAX_PLAYERS=64
ENV SCUM_NO_BATTLEYE="false"
ENV STEAM_APP_ID=3792580

USER root
    
RUN dpkg --add-architecture i386
RUN apt update && \
    apt install -y \
      curl \
      ca-certificates \
      xvfb \
      wget \
      gnupg \
      software-properties-common && \
    mkdir -pm755 /etc/apt/keyrings && \
    wget -O - https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key && \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources && \
    apt update && \
    apt install -y --install-recommends winehq-stable && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${GID} scum \
    && useradd -m -u ${UID} -g ${GID} -s /bin/bash scum

COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

USER scum

RUN mkdir -p ${WINEPREFIX} && \
    wineboot --init && \
    echo "[*] Wine initialization complete."

RUN mkdir -p ${HOME}/steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
      | tar -xz -C ${HOME}/steamcmd

WORKDIR ${HOME}/SCUM

ENTRYPOINT ["/entrypoint"]