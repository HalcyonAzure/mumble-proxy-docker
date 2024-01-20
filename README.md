# Mumble Web Proxy Docker 镜像
本项目包含一个 Docker 镜像，用于运行 Mumble Web Proxy。Mumble Web Proxy 是一个用于将 Mumble 服务器（一个开源的语音通讯服务器）的流量转发到 Web 客户端的代理。

## 构建流程
在构建这个 Docker 镜像之前，请确保您的机器上已经安装了 Docker。

### 克隆仓库：
克隆或下载此仓库到您的本地机器。

### 构建 Docker 镜像：
在包含 Dockerfile 的目录下运行以下命令来构建镜像：

  ```bash
  docker build -t mumble-web-proxy .
  ```
这将使用 Dockerfile 中的指令构建镜像，并将其标记为 mumble-web-proxy。

## 使用流程
运行 Docker 容器时，您需要通过设置特定的环境变量来配置 Mumble Web Proxy。

### 启动容器
使用以下命令启动 Docker 容器：

  ```bash
  docker run -d --name mumble-proxy -p 64737:64737 -e MWP_LISTEN_WS=64737 -e MWP_SERVER=mumble-server:64738 mumble-web-proxy
  ```

这将在后台为你的murmur服务器启动一个proxy。

## 环境变量
以下是可用于配置 Mumble Web Proxy 的环境变量：

MWP_LISTEN_WS: Websocket 监听端口，必须设置此变量。
MWP_SERVER: Mumble 服务器的地址和端口，必须设置此变量。
MWP_ACCEPT_INVALID_CERTIFICATE: 若设置为 true，则接受无效的 SSL 证书。可能用于自签名证书的情况。
MWP_ICE_PORT_MIN 和 MWP_ICE_PORT_MAX: 定义 ICE 协议使用的端口范围。
MWP_ICE_IPV4 和 MWP_ICE_IPV6: 分别指定要使用的 IPv4 和 IPv6 地址。当应用位于防火墙之后时，通过这些变量指定公网地址以确保 WebRTC 功能的正常使用。

## 注意事项
确保您的 Mumble 服务器已正确配置，并且可通过 MWP_SERVER 指定的地址和端口访问。
根据您的网络环境调整容器的端口映射和环境变量以满足您的需求。
