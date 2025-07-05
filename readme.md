# SCUM Dedicated Server on Docker

This project allows you to easily run a dedicated SCUM game server using Docker.

## Quick Start

1.  **Get Files:**
    ```bash
    git clone https://github.com/jasonlcsdev/scum-server-docker.git
    cd scum-server-docker
    ```
2.  **Start Server:**
    ```bash
    docker compose up -d --build
    ```
    (The game will be downloaded and installed on first startup.)

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

* For more detailed server setup information, refer to the [SCUM Dedicated server setup guide](https://scum.fandom.com/wiki/Scum_Dedicated_server_setup).