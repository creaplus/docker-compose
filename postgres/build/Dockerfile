# 使用官方的PostgreSQL镜像作为基础镜像
FROM postgres:17


# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 安装依赖包
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl wget ca-certificates gnupg apt-transport-https lsb-release 

RUN wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor -o /etc/apt/trusted.gpg.d/timescaledb.gpg && \
    echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/timescaledb.list


# 将 pigsty 的 gpg 公钥添加到你的系统钥匙链中，从而验证软件包签名
RUN curl -fsSL https://repo.pigsty.cc/key | gpg --dearmor -o /etc/apt/keyrings/pigsty.gpg && \
    distro_codename=$(lsb_release -cs) && \
    tee /etc/apt/sources.list.d/pigsty-io.list > /dev/null <<EOF
deb [signed-by=/etc/apt/keyrings/pigsty.gpg] https://repo.pigsty.cc/apt/infra generic main
deb [signed-by=/etc/apt/keyrings/pigsty.gpg] https://repo.pigsty.cc/apt/pgsql/${distro_codename} ${distro_codename} main
EOF

# 更新包信息
RUN apt-get update 

# 安装常用扩展
RUN apt-get install -y --no-install-recommends \
    postgresql-client-17 timescaledb-2-postgresql-17 postgresql-17-pgvector postgresql-17-pgmq postgresql-17-cron postgresql-17-pg-vectorize postgresql-17-wal2json

    # TODD
# 清理减小镜像大小
RUN rm -rf /var/lib/apt/lists/*

# 创建并添加初始化脚本
COPY init-extensions.sh /docker-entrypoint-initdb.d/
