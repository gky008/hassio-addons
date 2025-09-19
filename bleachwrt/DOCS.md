# BleachWRT HAOS 使用文档

## 简介

BleachWRT haos 是一个基于 OpenWRT 的 Home Assistant 加载项，提供旁路由功能和完整的 Web 管理界面。本加载项可以让您的 Home Assistant 设备同时作为网络旁路由使用，提供丰富的网络管理功能。

## 安装前准备

在安装和配置 BleachWRT haos 之前，请确保您了解以下内容：

1. 旁路由的基本工作原理
2. 您当前网络的 IP 地址范围、网关地址和子网掩码
3. 确保选择的虚拟 IP 不会与现有网络中的设备冲突

## 安装步骤

1. 在 Home Assistant 中添加本仓库作为自定义存储库
2. 在加载项商店中找到并安装"BleachWRT Plus"
3. 等待安装完成


## 使用指南

### 首次访问

1. 配置完成并启动加载项后，等待约 1 分钟让所有服务完全启动
2. 使用浏览器访问您设置的虚拟 IP 地址：http://[虚拟 IP]
3. 使用默认账号密码登录：root/password
4. 首次登录后，建议立即修改默认密码

### 基本功能

BleachWRT haos 提供了丰富的功能，包括但不限于：

- 网络状态监控
- 防火墙配置
- 流量统计
- 端口转发
- 自定义防火墙规则
- 软件包管理

### DHCP 配置

本加载项默认已禁用 DHCP 服务器功能（option ignore '1'），以避免与主路由器的 DHCP 服务冲突。如需启用，可通过 Web 界面修改 DHCP 配置。

## 故障排除

### 无法访问 Web 界面

1. 检查虚拟 IP 配置是否正确
2. 确认 Home Assistant 主机能够正常访问网络
3. 检查加载项日志，将 log_level 设置为"debug"获取更详细信息
4. 确认主机防火墙未阻止相关端口

### 网络连接问题

1. 检查虚拟 IP 与网关配置是否正确
2. 确认 IP 转发功能已启用
3. 查看详细日志以排查网络接口配置问题
4. 检查 NAT 规则是否正确设置

### 性能优化

1. 如果不需要详细日志，将 log_level 设置为"info"可减少日志输出
2. 根据实际需求启用或禁用不必要的服务
3. 定期清理缓存和日志文件

## 更新与维护

1. 定期检查加载项更新
2. 更新前建议备份重要配置
3. 更新后可能需要重新配置部分设置

## 支持与反馈

如有问题或建议，请通过以下方式获取支持：

1. 查阅本文档
2. 在 GitHub 仓库提交 Issue
3. 在 Home Assistant 社区论坛寻求帮助

本项目基于[BleachWRT](https://openwrt.mpdn.fun/?dir=lede)开发。

```bash
# 需要在宿主机上进行下面操作

#开启桥接网卡混淆模式
ip link set enp2s1 promisc on

# 添加macvlan
docker network create -d macvlan --subnet=192.168.2.0/24 --gateway=192.168.2.1 -o parent=enp2s1 macnet
```
