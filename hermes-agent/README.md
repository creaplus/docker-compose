# Hermes Agent（Docker Compose）

以 [Nous Research Hermes Agent](https://hermes-agent.nousresearch.com/) 官方镜像在本地/服务器上运行 **Gateway**（消息与 OpenAI 兼容 API）和 **Web Dashboard** 的 Compose 编排。宿主机 **`${DATA_PATH}`** 直接挂载为容器内 **`/opt/data`**（与 `docker run -v <目录>:/opt/data` 一致），`.env`、`config.yaml`、飞书/Telegram 等平台配置都应在此目录下。

## 环境要求

- Docker 与 Docker Compose v2
- 建议至少约 4GB 可用内存给 `hermes` 服务（见 `deploy.resources`）

## 快速开始

1. **准备配置**

   ```bash
   cp .env.example .env
   ```

2. **编辑 `.env`**

   | 变量 | 说明 |
   | --- | --- |
   | `DATA_PATH` | **Hermes 主目录**，等同于手动运行时的 `-v <这里>:/opt/data`（**不是**强制再加一层 `data/`） |
   | `CONTAINER_NAME` | 容器名，例如 `.env.example` 中 `hermes-agent`；Dashboard 为 `<名称>_dashboard` |
   | `PORT` / `DASHBOARD_PORT` | 宿主机映射：Gateway、Dashboard 端口（默认 8642、9119） |

3. **启动**

   ```bash
   docker compose up -d
   docker compose logs -f
   ```

4. **访问**

   - **Gateway（HTTP / 健康检查）**：`http://<宿主机>:${PORT:-8642}`  
   - **Dashboard**：`http://<宿主机>:${DASHBOARD_PORT:-9119}`

## 服务说明

| 服务 | 作用 |
| --- | --- |
| `hermes` | 执行 `gateway run`，长驻 Gateway。 |
| `dashboard` | Web 控制台，通过 `GATEWAY_HEALTH_URL=http://hermes:8642` 在 Compose 网络内探测同栈 Gateway。 |

Compose 里 **服务名** 为 `hermes`（与自定义 `container_name` 不同），网内其它容器用 **主机名 `hermes`** 访问 Gateway。

## 首次配置与向导

官方建议在首次把数据卷挂好后，在容器里跑交互式配置（会写入 **`${DATA_PATH}`** 下配置，例如 `.env`、API Key 等）。

- **整机/通用向导**（与文档中的 `hermes setup` 对应；运行前可 `docker compose stop hermes` 避免同时写配置）：

  ```bash
  docker compose run --rm -it hermes setup
  ```

- **仅消息 Gateway 相关**（与文档中的 `hermes gateway setup` 等对应）：

  ```bash
  docker compose run --rm -it hermes gateway setup
  ```

配完后用 `docker compose up -d` 启动常驻服务。更多说明见 [Docker | Hermes Agent 文档](https://hermes-agent.nousresearch.com/docs/user-guide/docker/)。

## 密钥与敏感配置

可将密钥写在 **`${DATA_PATH}/.env`** 等由 Hermes 使用的文件（以官方/向导为准），或在 `docker-compose.yml` 里取消注释 `environment` 段注入（**勿**将含密钥的 `.env` 提交到公开仓库）。

## 安全与 Dashboard

当前 Dashboard 使用 `dashboard --host 0.0.0.0 --insecure`，与上游在绑定非回环地址时的要求一致。该模式**不适合**直接暴露到公网，官方说明会暴露 API 与配置面；**仅**建议在受信网络/内网使用。若需对公网开放，应置于反向代理后并配置 TLS 与强鉴权，勿单独依赖本仓库默认参数。

## 权限与数据目录

若 `${DATA_PATH}` 属主与容器内进程不一致，可能出现**权限拒绝**或无法写入配置，可修正属主（按需替换路径）：

```bash
sudo chown -R "$(id -u):$(id -g)" "${DATA_PATH}"
```

## 排错：Compose 里「No messaging platforms enabled」，但 `docker run -v …:/opt/data` 正常

通常是 **挂载路径不一致**：Compose 若写成 `${DATA_PATH}/data`，而你的 `.env`、飞书密钥实际在 **`${DATA_PATH}` 根目录**，容器里读到的就是空配置。本仓库已将卷设为 **`${DATA_PATH}:/opt/data`**，请与 `ini.sh` / 手动 `docker run` 使用**同一目录**。

日志里 **「No user allowlists configured」** 与平台无关：需在 **`${DATA_PATH}/.env`** 里配置各平台允许的用户 ID，或（仅适合你可控的内网）设置 `GATEWAY_ALLOW_ALL_USERS=true`，详见网关启动时的 WARNING 原文。

## 常用命令

```bash
# 拉取新镜像并重建
docker compose pull
docker compose up -d --force-recreate

# 停止
docker compose stop

# 仅查看 hermes 日志
docker compose logs -f hermes
```

## 相关链接

- [Hermes Agent 官方站点与文档](https://hermes-agent.nousresearch.com/)
- 镜像：[nousresearch/hermes-agent](https://hub.docker.com/r/nousresearch/hermes-agent)

## 许可

本仓库中 Compose 与说明文件为本地编排用途；Hermes Agent 本身以 Nous Research 发布的镜像与项目许可为准。
