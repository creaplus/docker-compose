#!/bin/bash

# 配置变量
POSTGRES_CONTAINER_NAME="your_postgres_container_name"
BACKUP_DIR="/path/to/backup/directory"
DB_NAME="your_database_name"
DB_USER="your_database_user"

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 备份函数
backup_postgres() {
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="${BACKUP_DIR}/${DB_NAME}_${timestamp}.sql"
    
    echo "开始备份数据库 ${DB_NAME}"
    docker exec "$POSTGRES_CONTAINER_NAME" pg_dump -U "$DB_USER" "$DB_NAME" > "$backup_file"
    
    if [ $? -eq 0 ]; then
        echo "备份成功: $backup_file"
    else
        echo "备份失败"
        exit 1
    fi
}

# 恢复函数
restore_postgres() {
    local backup_file="$1"
    
    if [ ! -f "$backup_file" ]; then
        echo "备份文件不存在: $backup_file"
        exit 1
    fi
    
    echo "开始恢复数据库 ${DB_NAME}"
    docker exec -i "$POSTGRES_CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$backup_file"
    
    if [ $? -eq 0 ]; then
        echo "恢复成功: $backup_file"
    else
        echo "恢复失败"
        exit 1
    fi
}

# 帮助函数
usage() {
    echo "使用方法:"
    echo "  $0 backup   - 执行数据库备份"
    echo "  $0 restore <备份文件路径>  - 恢复数据库"
}

# 主逻辑
case "$1" in
    backup)
        backup_postgres
        ;;
    restore)
        if [ -z "$2" ]; then
            echo "错误：请提供备份文件路径"
            usage
            exit 1
        fi
        restore_postgres "$2"
        ;;
    *)
        usage
        exit 1
        ;;
esac
