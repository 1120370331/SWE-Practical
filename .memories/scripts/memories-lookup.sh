#!/bin/bash
# memories-lookup.sh - 记忆模块速查脚本
# 用法: sh .memories/scripts/memories-lookup.sh <模块目录名> [关键字...]
#       sh .memories/scripts/memories-lookup.sh --list-modules

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MEMORIES_DIR="$(dirname "$SCRIPT_DIR")"
MODULES_DIR="$MEMORIES_DIR/modules"

# 显示帮助信息
show_help() {
    echo "用法: $0 <模块目录名> [关键字...]"
    echo "      $0 --list-modules"
    echo ""
    echo "选项:"
    echo "  --list-modules    列出所有可用模块"
    echo "  --help, -h        显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 demand-forecast           # 查看 demand-forecast 模块全部内容"
    echo "  $0 demand-forecast baseline  # 在模块中搜索 'baseline' 关键字"
}

# 列出所有模块
list_modules() {
    echo "可用模块列表："
    echo "==============="
    if [ -d "$MODULES_DIR" ]; then
        for dir in "$MODULES_DIR"/*/; do
            if [ -d "$dir" ]; then
                module_name=$(basename "$dir")
                if [ "$module_name" != "*" ]; then
                    echo "  - $module_name"
                fi
            fi
        done
    fi
    echo ""
    echo "模块索引: $MODULES_DIR/INDEX.md"
}

# 检查参数
if [ $# -eq 0 ]; then
    echo "错误: 缺少模块参数"
    echo ""
    show_help
    exit 1
fi

# 处理选项
case "$1" in
    --list-modules)
        list_modules
        exit 0
        ;;
    --help|-h)
        show_help
        exit 0
        ;;
esac

MODULE_NAME="$1"
shift
KEYWORDS="$*"

MODULE_PATH="$MODULES_DIR/$MODULE_NAME"

# 检查模块是否存在
if [ ! -d "$MODULE_PATH" ]; then
    echo "错误: 模块 '$MODULE_NAME' 不存在"
    echo ""
    list_modules
    exit 1
fi

echo "=========================================="
echo "模块: $MODULE_NAME"
echo "=========================================="

if [ -z "$KEYWORDS" ]; then
    # 无关键字，显示模块概览
    echo ""
    echo "--- README.md ---"
    if [ -f "$MODULE_PATH/README.md" ]; then
        cat "$MODULE_PATH/README.md"
    else
        echo "(未找到 README.md)"
    fi

    echo ""
    echo "--- 文件列表 ---"
    ls -la "$MODULE_PATH"
else
    # 有关键字，搜索内容
    echo "搜索关键字: $KEYWORDS"
    echo ""
    for keyword in $KEYWORDS; do
        echo "--- 匹配 '$keyword' ---"
        grep -rni "$keyword" "$MODULE_PATH" 2>/dev/null || echo "(无匹配结果)"
        echo ""
    done
fi
