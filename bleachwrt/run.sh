#!/usr/bin/ash

# 1. 先通过“挂起”命令让容器启动（生成$HOSTNAME/容器ID），不执行实际服务
# tail -f /dev/null 会让容器保持运行，不退出
echo "容器启动中，等待生成容器ID..."
tail -f /dev/null &
HOLD_PID=$!  # 记录挂起进程的ID，后续要杀掉它

# 2. 延迟执行网络切换（确保容器ID已生成，可根据启动速度调整sleep时间）
sleep 5
echo "开始切换网络（容器ID: $HOSTNAME）..."
docker network disconnect hassio $HOSTNAME
docker network connect macnet $HOSTNAME
echo "网络切换完成"

# 3. 停止挂起进程，执行加载项镜像默认的启动命令
kill $HOLD_PID  # 杀掉tail进程，释放前台
echo "启动加载项核心服务..."

# 4. 执行镜像默认的启动命令（关键：通过docker inspect提取，无需手动写）
# 提取镜像的ENTRYPOINT（若为空则用CMD，二者选其一即可）
ENTRYPOINT=$(docker inspect --format '{{json .Config.Entrypoint}}' $HOSTNAME | sed 's/\["//;s/"]//')
# 提取镜像的CMD（若ENTRYPOINT为空，就用CMD）
CMD=$(docker inspect --format '{{json .Config.Cmd}}' $HOSTNAME | sed 's/\["//;s/"]//')

# 执行默认启动命令（优先用ENTRYPOINT，没有则用CMD）
if [ -n "$ENTRYPOINT" ]; then
  exec $ENTRYPOINT
else
  exec $CMD
fi
