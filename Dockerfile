# 基于最新版的 Ubuntu 镜像
FROM ubuntu:latest

# 安装必要的软件包、下载并安装 libssl1.1、下载 mumble-web-proxy、
# 复制 entrypoint 脚本，并清理缓存，所有操作合并成一个 RUN 指令来减少层数
RUN apt-get update && \
    apt-get install -y libnice-dev curl && \
    curl -o /tmp/libssl1.1.deb https://git.termer.net/termer/mumble-web-prebuilt/raw/branch/master/libssl1.1_1.1.1f-1ubuntu2.17_amd64.deb && \
    dpkg -i /tmp/libssl1.1.deb && \
    rm /tmp/libssl1.1.deb && \
    curl -o /usr/local/bin/mumble-web-proxy https://git.termer.net/termer/mumble-web-prebuilt/raw/branch/master/mumble-web-proxy && \
    chmod +x /usr/local/bin/mumble-web-proxy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

# 复制 entrypoint 脚本并设置执行权限
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

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

