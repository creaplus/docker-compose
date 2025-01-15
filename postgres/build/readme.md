# 参考资料
* [pigsty 收集扩展参考](https://pigsty.cc/zh/docs/pgext/list/)
* [pigsty 收集Deb扩展参考](https://pigsty.cc/zh/docs/pgext/list/deb/)
* [pigsty APT Repo](https://ext.pigsty.io/#/?id=apt-repo)
* [pigsty Debian Package](https://ext.pigsty.io/#/deb?id=postgresql-17)
* [timescaleDB Install](https://docs.timescale.com/self-hosted/latest/install/installation-linux/)
* [pgvector Install](https://github.com/pgvector/pgvector?tab=readme-ov-file#installation-notes---linux-and-mac)
* [pg_vectorize Install](https://github.com/tembo-io/pg_vectorize)
* [pg_cron Install pg17暂不支持](https://github.com/citusdata/pg_cron)
* [pg_stat_statements Note](https://www.postgresql.org/docs/current/pgstatstatements.html)
* [pg_stat_statements Config](https://www.postgresql.org/docs/current/pgstatstatements.html#PGSTATSTATEMENTS-PG-STAT-STATEMENTS-INFO)
* [index_advisor Install](https://github.com/supabase/index_advisor)
* []()
# 支持情况
- [X] timescaledb 时序数据库扩展插件
- [X] pgvector 向量数据类型和 ivfflat / hnsw 访问方法
- [X] pgmq 基于Postgres实现类似AWS SQS/RSMQ的消息队列
- [X] pg_stat_statements 跟踪所有执行的 SQL 语句的计划和执行统计信息
- [-] pg_vectorize 在PostgreSQL中封装RAG向量检索服务
- [] pg_summarize 使用LLM对文本字段进行总结
- [] pg_cron 定时任务调度器
- [] jsquery 用于内省 JSONB 数据类型的查询类型
- [] postgis PostGIS 几何和地理空间扩展
- [] pg_background 在后台运行 SQL 查询
- [] PostgreSQL高级任务调度器
- [] geoip IP 地理位置扩展（围绕 MaxMind GeoLite 数据集的包装器）
- [] pg_search ParadeDB BM25算法全文检索插件，ES全文检索
- [] zhparser 中文分词，全文搜索解析器
- [] pg_duckdb 在PostgreSQL中的嵌入式DuckDB扩展
- [] pg_strom 使用GPU与NVMe加速大数据处理
- [] index_advisor 查询索引建议器
- [] table_log 记录某张表的修改日志并做表/行级时间点恢复
- [] pgaudit 提供审计功能
- [] pgauditlogtofile pgAudit 子扩展，将审计日志写入单独的文件中
- [] pg_analytics 由 DuckDB 驱动的数据分析引擎
- [] pg_duckdb 在PostgreSQL中的嵌入式DuckDB扩展
- [] duckdb_fdw DuckDB 外部数据源包装器
- [] pg_partman DuckDB 用于按时间或 ID 管理分区表的扩展
