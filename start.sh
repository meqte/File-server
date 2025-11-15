#!/bin/bash

echo "Starting TempStore - 临时文件存储工具"
echo

# 检查Python是否安装
if ! command -v python3 &> /dev/null; then
    echo "错误: Python3未安装"
    echo "请先安装Python 3.8或更高版本"
    exit 1
fi

# 检查依赖包
if ! python3 -c "import flask" &> /dev/null; then
    echo "正在安装依赖包..."
    pip3 install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo "错误: 依赖包安装失败"
        exit 1
    fi
fi

# 设置环境变量
export TEMPSTORE_MAX_STORAGE="20GB"
export TEMPSTORE_MAX_FILE_SIZE="1GB"
export TEMPSTORE_FILE_EXPIRE_HOURS="24"

# 启动服务
echo
echo "TempStore服务启动中..."
echo "管理员密码: 使用默认密码或环境变量设置的密码"
echo "访问地址: http://localhost:5000"
echo
echo "按 Ctrl+C 停止服务"

# 检查端口是否被占用
if lsof -Pi :5000 -sTCP:LISTEN -t >/dev/null ; then
    echo "警告: 端口5000已被占用，尝试使用端口5001"
    python3 app.py 5001
else
    python3 app.py
fi