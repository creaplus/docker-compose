# Dify

## Change log 
* 跟进官方版本1.1.3

## 配置说明
1. cp docker/.env.example .env  更新 `Self Config`相关配置
2. docker compose up --build -d 
3. 参考nginx模板配置自己的 反向代理
4. 访问域名 http[s]://you_host/install 进行初始化

## 参考说明
* docker-compose 参考官方 [docker/docker-compose.yaml](https://github.com/langgenius/dify/blob/main/docker/docker-compose.yaml)
* 安装说明 参考 [Docker Composer 部署](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/docker-compose)

## submodule 使用说明

```shell
# 将指定的 Git 仓库添加为子模块，放到主项目的 submodule-directory 目录下
git submodule add <子模块仓库的 URL> <子模块在主项目中的路径>

# 示例：将名为 example-submodule 的仓库添加到主项目的 submodules/example 目录下
cd ../
git submodule add https://github.com/langgenius/dify.git dify/dify-office


# 先克隆主项目，再初始化并更新子模块
git submodule init  # 初始化本地配置文件
git submodule update  # 从子模块仓库中拉取数据并检出合适的提交

# 拉取子模块的最新提交
git submodule update --remote
```