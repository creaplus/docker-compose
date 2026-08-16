# Obsidian

> 用 linuxserver 的 Selkies 桌面镜像，在浏览器里跑 Obsidian。

这是 **Web 远程桌面版** Obsidian，不是官方同步服务，也不是本地 App。笔记存在宿主机目录里，容器只提供 GUI。

## 设计说明

* 镜像使用 `lscr.io/linuxserver/obsidian:latest`
* Web 服务接入外部网络 `web_net`，与仓库其它 Web 服务一致
* 数据直接挂到容器 `/config`（linuxserver 家目录），对应 `${DATA_PATH}`，**不再套一层** `config/`
* `shm_size: 1gb` 是 Electron 正常运行的硬性要求
* 映射 HTTP `3000`（宿主机默认 `3005`）给 Nginx 反代；TLS 由 Nginx 终结，容器 HTTPS `3001` 默认不暴露
* `PUID` / `PGID` 对齐宿主机用户，避免 Vault 文件权限错乱
* 默认 `LC_ALL=zh_CN.UTF-8`，界面走中文 locale

认证走容器内置 HTTP Basic Auth（`CUSTOM_USER` / `PASSWORD`）。镜像自带终端且可 sudo，Nginx 只负责 TLS 和反代，**不要再配一层** `auth_basic`，否则会双重弹窗并可能打断 WebSocket。

## 配置说明

1. `cp .env.example .env`
2. 在 `.env` 填写 `PASSWORD`（必填，不设则 compose 会拒绝启动）
3. 按需修改 `DATA_PATH`、`PORT`、`CUSTOM_USER`、`PUID` / `PGID`
4. 确认已有外部网络：`docker network create web_net`（已存在可跳过）
5. `docker compose up -d`
6. 走 Nginx 时反代到 `http://127.0.0.1:3005`，浏览器会弹出容器的账号密码
7. 直连调试可用 `http://<宿主机IP>:3005`

用 `id` 确认宿主机 UID/GID，写入 `PUID` / `PGID`。首次启动 linuxserver 会按这两个值整理 `/config` 属主。

## 数据目录

`${DATA_PATH}` 即容器家目录，常见内容：

* `Obsidian Vault/` — 笔记库
* `.config/` — 应用配置
* `ssl/` — 自签证书

本机已有库时，把整个目录指到 `DATA_PATH` 即可，不要只拷单个 `.md` 文件。

## 认证

在 `.env` 设置：

```bash
CUSTOM_USER=obsidian
PASSWORD=你的密码
```

这是镜像自带的 HTTP Basic Auth。改密码后需要重建容器：

```bash
docker compose up -d --force-recreate
```

Nginx 侧不要再开 `auth_basic`，但要保留 WebSocket 头，并把 `Authorization` 原样转给后端（默认 `proxy_pass` 会转发）。

## GPU（可选）

Intel / AMD 核显可把 `/dev/dri` 映射进容器，见 `docker-compose.yml` 注释。Nvidia 需要宿主机 runtime，不在默认范围。

## 更新

```bash
docker compose pull
docker compose up -d
```

更新前建议备份 `${DATA_PATH}`，尤其是 `Obsidian Vault/`。

## 参考文档

* [linuxserver/obsidian](https://docs.linuxserver.io/images/docker-obsidian/)
* [Obsidian](https://obsidian.md/)
