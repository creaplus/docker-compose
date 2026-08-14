# Home Assistant

> 使用官方 Container 镜像运行 Home Assistant Core，替代原先的 KVM / HA OS 虚拟机。

这是 **Home Assistant Container**，不是 Home Assistant OS：没有 Supervisor，也没有插件商店。插件需要改成独立容器（例如 Mosquitto、Zigbee2MQTT、Node-RED）。

## 设计说明

* 镜像使用官方 `ghcr.io/home-assistant/home-assistant:stable`
* 网络使用 `host`，便于 mDNS / SSDP / DHCP 发现局域网设备；**不接入** `web_net`
* `privileged: true` 方便直通 USB 网关（Zigbee / Z-Wave）
* 蓝牙需要显式 `cap_add: NET_ADMIN`、`NET_RAW`，并挂载宿主机 `/run/dbus`；宿主机需安装并运行 BlueZ
* 配置持久化在 `${DATA_PATH}/config`，对应容器内 `/config`

host 网络仅适用于 Linux 宿主机。启用后不要再写 `ports`，Web UI 直接监听宿主机 `8123`。

## 配置说明

1. `cp .env.example .env`
2. 按需修改 `DATA_PATH`、`TZ`
3. `docker compose up -d`
4. 浏览器访问 `http://<宿主机IP>:8123`

## 从 KVM 迁移

1. 在旧虚拟机里先完整备份，并导出 `/config`（含 `configuration.yaml`、`.storage`、`home-assistant_v2.db` 等）
2. 把导出内容放到本目录的 `config/` 下
3. 确认旧 VM 已关机，避免两个实例同时连同一批设备
4. 启动本 compose，检查集成和设备是否恢复
5. 原先依赖的 Add-on 需要改成独立 Docker 服务后再接入

如果只是新装，不拷贝旧配置，首次启动会走初始化向导。

## 蓝牙

容器版不会自带蓝牙协议栈，依赖宿主机的 BlueZ，并按官方要求加上 `NET_ADMIN` / `NET_RAW`。

宿主机准备：

```bash
sudo apt-get install -y bluez
sudo systemctl enable --now bluetooth
```

改过 compose 权限后必须**重建**容器，`docker compose restart` 不会应用 capability：

```bash
docker compose up -d --force-recreate
```

若仍提示降级模式，可再确认宿主机 D-Bus 实现建议为 [dbus-broker](https://github.com/bus1/dbus-broker/wiki)，以及适配器是否被其他进程占用。

参考：[Docker 的蓝牙权限](https://www.home-assistant.io/integrations/bluetooth/#additional-details-for-container)

## USB 设备

Zigbee / Z-Wave 网关需要把串口映射进容器。先在宿主机确认设备：

```bash
ls -l /dev/serial/by-id/
```

然后在 `docker-compose.yml` 里取消 `devices` 注释，改成实际路径。优先用 `/dev/serial/by-id/...`，避免重启后 `ttyUSB0` 编号变化。

## 更新

```bash
docker compose pull
docker compose up -d
```

更新前建议先备份 `config/`。Container 版没有 OS 的一键快照，目录复制即可。

## 参考文档

* [Installation - Docker](https://www.home-assistant.io/installation/linux#install-home-assistant-container)
* [Home Assistant Container](https://www.home-assistant.io/installation/#advanced-installation-methods)
