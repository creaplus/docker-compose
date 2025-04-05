# Docker Compose 服务集合

这是一个使用 Docker Compose 管理的服务集合项目,包含了多个常用的开发和运维服务。

## 目录介绍

- **dify** - Dify AI 应用开发平台
- **firecrawl** - 网页爬虫服务
- **lobe-chat** - LobeChat AI 聊天服务
- **minio** - MinIO 对象存储服务
- **monitor** - Prometheus + Grafana 监控系统
- **mongodb** - MongoDB 数据库服务
- **mysql** - MySQL 数据库服务
- **neo4j** - Neo4j 图数据库服务
- **open-webui** - OpenWebUI 界面服务
- **postgres** - PostgreSQL 数据库服务
- **redis** - Redis 缓存服务
- **rustdesk** - RustDesk 远程控制服务

## 使用说明

1. 确保已安装 Docker 和 Docker Compose

2. 初始化配置文件:
```bash
cp .env.example .env
```

3. 修改 `.env` 文件中的配置参数

4. 启动服务:
```bash
docker compose up -d
```

## 网络配置

- Web 服务统一使用 `web_net` 网络
- 监控服务统一使用 `monitor_net` 网络,关联 `web_net`

## 系统要求

- Docker Engine 24.0+
- Docker Compose 2.0+
- 最小配置:
  - CPU: 2 核
  - 内存: 4GB
  - 磁盘: 20GB

## 参考文档

各个服务的详细配置说明请参考对应目录下的 README 文件:

- [Dify 配置说明](/dify/README.md)
- [Firecrawl 配置说明](/firecrawl/README.md)
- [MinIO 配置说明](/minio/README.md)
- [监控系统配置说明](/monitor/README.md)
- [MySQL 配置说明](/mysql/README.md)
- [Neo4j 配置说明](/neo4j/README.md)
- [OpenWebUI 配置说明](/open-webui/README.md)
- [PostgreSQL 配置说明](/postgres/README.md)
- [Redis 配置说明](/redis/README.md)
- [RustDesk 配置说明](/rustdesk/README.md)

## 贡献

欢迎提交 Issue 和 Pull Request 来完善这个项目。

## 许可证

本项目采用 MIT 许可证。