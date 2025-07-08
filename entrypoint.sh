#!/bin/bash

PARAMS=""
STEAM_CMD="/serverdata/steamcmd/steamcmd.sh"
STEAM_APP_ID="${STEAM_APP_ID:-3792580}"

if [[ "${SCUM_NO_BATTLEYE}" == "true" ]]; then
    PARAMS="${PARAMS} -nobattleye"
fi

echo "[*] Updating SCUM Server..."
${STEAM_CMD} +@sSteamCmdForcePlatformType windows +force_install_dir "/serverdata/serverfiles" +login anonymous +app_update ${STEAM_APP_ID} validate +quit

echo "[*] Launching SCUM Server..."
cd /serverdata/serverfiles/SCUM/Binaries/Win64 || { echo "Error: Directory not found"; exit 1; }

wine64 SCUMServer.exe -log -port=${SCUM_PORT} -MaxPlayers=${SCUM_MAX_PLAYERS} ${PARAMS}
