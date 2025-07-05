FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEARCH=win64
ENV WINEPREFIX=/opt/wine64

ENV SCUM_PORT=7777
ENV SCUM_MAX_PLAYERS=64
ENV SCUM_NO_BATTLEYE="false"
ENV STEAM_APP_ID=3792580

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

RUN mkdir -p /opt/wine64 && \
    wineboot --init && \
    echo "[*] Wine initialization complete."

RUN mkdir -p /opt/steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
      | tar -xz -C /opt/steamcmd

WORKDIR /opt/SCUM

COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

ENTRYPOINT ["/entrypoint"]