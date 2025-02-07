# firecrawl

## 配置说明
1. cp .env.example .env 
2. docker compose up --build -d 

## submodule 使用说明

```shell
# 将指定的 Git 仓库添加为子模块，放到主项目的 submodule-directory 目录下
git submodule add <子模块仓库的 URL> <子模块在主项目中的路径>

# 示例：将名为 example-submodule 的仓库添加到主项目的 submodules/example 目录下
cd ../
git submodule add https://github.com/mendableai/firecrawl.git firecrawl/office-src


# 先克隆主项目，再初始化并更新子模块
git submodule init  # 初始化本地配置文件
git submodule update  # 从子模块仓库中拉取数据并检出合适的提交

# 拉取子模块的最新提交
git submodule update --remote
```

## 常用api
```curl
curl -X POST http://localhost:3002/v1/crawl \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer this_is_just_a_preview_token' \
    -d '{
      "url": "https://mendable.ai"
    }'

curl -X POST http://home-server:3002/v1/crawl \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://mendable.ai"
    }'
```