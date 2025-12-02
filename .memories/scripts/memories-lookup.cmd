@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

:: memories-lookup.cmd - 记忆模块速查脚本 (Windows版)
:: 用法: .memories\scripts\memories-lookup.cmd <模块目录名> [关键字...]
::       .memories\scripts\memories-lookup.cmd --list-modules

set "SCRIPT_DIR=%~dp0"
set "MEMORIES_DIR=%SCRIPT_DIR%.."
set "MODULES_DIR=%MEMORIES_DIR%\modules"

:: 检查参数
if "%~1"=="" (
    echo 错误: 缺少模块参数
    echo.
    goto :show_help
)

:: 处理选项
if "%~1"=="--list-modules" goto :list_modules
if "%~1"=="--help" goto :show_help
if "%~1"=="-h" goto :show_help

set "MODULE_NAME=%~1"
set "MODULE_PATH=%MODULES_DIR%\%MODULE_NAME%"

:: 检查模块是否存在
if not exist "%MODULE_PATH%\" (
    echo 错误: 模块 '%MODULE_NAME%' 不存在
    echo.
    goto :list_modules
)

echo ==========================================
echo 模块: %MODULE_NAME%
echo ==========================================

:: 检查是否有关键字参数
if "%~2"=="" (
    :: 无关键字，显示模块概览
    echo.
    echo --- README.md ---
    if exist "%MODULE_PATH%\README.md" (
        type "%MODULE_PATH%\README.md"
    ) else (
        echo (未找到 README.md)
    )
    echo.
    echo --- 文件列表 ---
    dir /b "%MODULE_PATH%"
) else (
    :: 有关键字，搜索内容
    echo 搜索关键字: %2 %3 %4 %5
    echo.
    shift
    :search_loop
    if "%~1"=="" goto :end
    echo --- 匹配 '%~1' ---
    findstr /s /i /n "%~1" "%MODULE_PATH%\*.*" 2>nul || echo (无匹配结果)
    echo.
    shift
    goto :search_loop
)

goto :end

:show_help
echo 用法: %~nx0 ^<模块目录名^> [关键字...]
echo       %~nx0 --list-modules
echo.
echo 选项:
echo   --list-modules    列出所有可用模块
echo   --help, -h        显示此帮助信息
echo.
echo 示例:
echo   %~nx0 demand-forecast           # 查看 demand-forecast 模块全部内容
echo   %~nx0 demand-forecast baseline  # 在模块中搜索 'baseline' 关键字
goto :end

:list_modules
echo 可用模块列表：
echo ===============
if exist "%MODULES_DIR%\" (
    for /d %%d in ("%MODULES_DIR%\*") do (
        echo   - %%~nxd
    )
)
echo.
echo 模块索引: %MODULES_DIR%\INDEX.md
goto :end

:end
endlocal
