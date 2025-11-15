@echo off
echo Starting TempStore - 临时文件存储工具
echo.

REM 检查Python是否安装
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: Python未安装或未添加到PATH环境变量
    echo 请先安装Python 3.8或更高版本
    pause
    exit /b 1
)

REM 检查依赖包
python -c "import flask" >nul 2>&1
if %errorlevel% neq 0 (
    echo 正在安装依赖包...
    pip install -r requirements.txt
    if %errorlevel% neq 0 (
        echo 错误: 依赖包安装失败
        pause
        exit /b 1
    )
)

REM 设置环境变量
set TEMPSTORE_MAX_STORAGE=20GB
set TEMPSTORE_MAX_FILE_SIZE=1GB
set TEMPSTORE_FILE_EXPIRE_HOURS=24

REM 启动服务
echo.
echo TempStore服务启动中...
echo 管理员密码: 使用默认密码或环境变量设置的密码
echo 访问地址: http://localhost:5000
echo.
echo 按 Ctrl+C 停止服务
python app.py

pause