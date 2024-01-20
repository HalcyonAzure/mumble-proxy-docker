# 基于最新版的 Ubuntu 镜像
FROM ubuntu:latest

# 将预下载的文件复制到镜像中
COPY libssl1.1_1.1.1f-1ubuntu2.17_amd64.deb /tmp/
COPY mumble-web-proxy /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/

# 安装 libnice-dev 和 libssl，设置 mumble-web-proxy 和 entrypoint.sh 的权限
# 清理缓存，所有操作合并成一个 RUN 指令来减少层数
RUN apt-get update && \
    apt-get install -y libnice-dev && \
    dpkg -i /tmp/libssl1.1_1.1.1f-1ubuntu2.17_amd64.deb && \
    rm /tmp/libssl1.1_1.1.1f-1ubuntu2.17_amd64.deb && \
    chmod +x /usr/local/bin/mumble-web-proxy && \
    chmod +x /usr/local/bin/entrypoint.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV MWP_LISTEN_WS=64737 \
    MWP_SERVER=mumble-server:64738 \
    MWP_ACCEPT_INVALID_CERTIFICATE= \
    MWP_ICE_PORT_MIN= \
    MWP_ICE_PORT_MAX= \
    MWP_ICE_IPV4= \
    MWP_ICE_IPV6=

# 指定非 root 用户运行
USER 1000

# 暴露端口 64737
EXPOSE 64737

# 设置入口点
CMD ["/usr/local/bin/entrypoint.sh"]
