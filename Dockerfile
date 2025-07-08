FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV UID=99
ENV GID=100
ENV WINEARCH=win64
ENV HOME=/home/scum
ENV WINEPREFIX=${HOME}/wine64

ENV SCUM_PORT=7777
ENV SCUM_MAX_PLAYERS=64
ENV SCUM_NO_BATTLEYE="false"
ENV STEAM_APP_ID=3792580

USER root

RUN dpkg --add-architecture i386 && \
    apt update && \
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

# สร้าง user/group ตาม UID GID
RUN groupadd -g ${GID} scum && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash scum

# เตรียม steamcmd โฟลเดอร์ (mount จาก host)
RUN mkdir -p /serverdata/steamcmd

# คัดลอก entrypoint และตั้งสิทธิ์ให้รันได้
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

USER scum

# เตรียม wine prefix
RUN mkdir -p ${WINEPREFIX} && \
    wineboot --init && \
    echo "[*] Wine initialization complete."

# ตั้ง working directory ที่โฟลเดอร์เกม (จะ map จาก host เป็น /serverdata/serverfiles)
WORKDIR /serverdata/serverfiles

ENTRYPOINT ["/entrypoint"]
