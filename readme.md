# SCUM Dedicated Linux Server (for Docker on Unraid Server)

This project allows you to easily run a dedicated SCUM game server using Docker.

## Quick Start

1.  **Get Files:**
    ```bash
    mkdir -p /mnt/user/appdata/SCUM-SV1/Build
    cd /mnt/user/appdata/SCUM-SV1/Build
    git clone https://github.com/cxsorious/scum-server-docker.git .
    ```
2.  **Start Build**
    ```bash
    docker build -t scum-server-local .
    ```
3. **After Build Finished:**
    Download and Place File: my-SCUM-SV1.xml in /boot/config/plugins/dockerMan/templates-user
    ```bash
    Goto > Add Container > Template Select a template SCUM-SV1 > Apply
    ```
    Start Container SCUM-SV1

## Configuration

### Environment Variables

Set these in `compose.yml` under `environment`:

| Variable           | Description                      |
| :----------------- | :------------------------------- |
| `SCUM_PORT`        | Main server port (e.g., 7777).   |
| `SCUM_MAX_PLAYERS` | Max players (128 max).    |
| `SCUM_NO_BATTLEYE` | `"true"` to disable BattlEye.    |
| `STEAM_APP_ID`     | SCUM Steam App ID (3792580).     |

## Ports

Ensure these ports are open in your firewall and mapped in `docker-compose.yml`:

* `7777-7779/udp`, `7777/tcp`: Default SCUM Game Ports
* `27015-27016/udp`: Steam Query Ports

## Troubleshooting

* If the server won't start, check logs: `docker compose logs SCUM`.

## Resources

* Fork form (https://github.com/jasonlcsdev/scum-server-docker)
* For more detailed server setup information, refer to the [SCUM Dedicated server setup guide](https://scum.fandom.com/wiki/Scum_Dedicated_server_setup).
