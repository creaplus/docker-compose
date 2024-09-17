# Dify

## 配置说明
1. cp .env.example .env  更新 `Self Config`相关配置
2. docker compose up --build -d 
3. 参考nginx模板配置自己的 反向代理
4. 访问域名 http[s]://you_host/install 进行初始化

## 参考说明
* docker-compose 参考官方 [docker/docker-compose.yaml](https://github.com/langgenius/dify/blob/main/docker/docker-compose.yaml)
* 安装说明 参考 [Docker Composer 部署](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/docker-compose)