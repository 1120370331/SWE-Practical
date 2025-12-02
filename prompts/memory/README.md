# 记忆管理提示词

帮助AI在大型项目中保持上下文记忆，快速理解业务逻辑链路。

## 使用场景

- 特大项目的业务逻辑梳理
- 跨文件/模块的依赖关系追踪
- 历史决策记录与回溯

---

## AI 指导提示词

将以下内容添加到你的 AI 系统提示或项目规则中：

```
# Knowledge Base .memories/

目的：集中沉淀业务背景、产品决策与脚本实现细节，确保接手任务前后都能查阅与补充共享记忆。

## 核心结构

- `modules/` 存放按 `业务-主题` 命名的记忆模块；每个模块必须维护：
  - `README.md`（导航）
  - `PRD.md`（场景目标）
  - 一个或多个 `FUNCTION-*.md`（流程与关键代码片段）
- `modules/INDEX.md` 记录模块清单、负责人和更新时间，便于全局检索。
- `templates/` 提供模块初始化模板，复制后按需填写。
- `scripts/` 包含速查脚本，支持在命令行检索模块内容。

## 推荐流程

1. **开工前**：执行 `.memories/scripts/memories-lookup.sh <模块目录名> [关键字...]`（或 Windows 版本 `.memories\scripts\memories-lookup.cmd ...`）快速定位资料。
2. **阅读顺序**：先读模块 `README.md`，再查看 `PRD.md` 与相关 `FUNCTION-*.md` 核对实现约束。
3. **收工后**：在对应文档补充新的决策、数据位置或遗留问题，并更新 `modules/INDEX.md`。

## Memories 文件管理规范

`./.memories/`（下文简称 `./memories/`）存放团队共享的"记忆"资料，用于速记业务背景与开发决策。开工前先读相关模块，收工后同步更新，保持资料实时。

### 目录结构

每个模块位于 `./memories/modules/<业务-主题>/`，命名采用小写加连字符。

### 必备文件

- `README.md` — 模块导航，列出 FUNCTION 文档及其他资料。
- `PRD.md` — 产品/业务目标、用户场景与边界假设。
- `FUNCTION-*.md` — 单个函数、脚本或流程的说明文档，可按需创建多个。在这里，需要你结合实际的代码情况，介绍业务的实现逻辑，并嵌入关键代码片段便于速查。

### 操作流程

1. 开始任务前，先阅读模块 `README.md`，再按需查看 `PRD.md` 与相关 `FUNCTION-*.md`。
2. 任务完成后，补充新的决策、假设、数据位置或遗留问题。
3. 新增模块时，复制 `.memories/templates/module/` 模板并填写，再在 `modules/INDEX.md` 登记。
4. 需要速查记忆内容时，执行 `sh .memories/scripts/memories-lookup.sh <模块目录名> [关键字...]`；Windows 环境使用 `.memories\scripts\memories-lookup.cmd <模块目录名> [关键字...]`。缺少 module 参数脚本会拒绝执行，可用 `--list-modules` 查看支持的模块列表。

### 命名规范

- 模块目录采用 `业务-主题` 形式（示例：`demand-forecast`），使用小写加连字符。
- 模块下必须包含：
  - `README.md`：模块导引，列出功能文档清单与快速导航。
  - `PRD.md`：业务或功能的目标、用户、场景与边界。
  - `FUNCTION-*.md`：每个函数/脚本/流程一份，文件名使用大写字母与连字符（示例：`FUNCTION-LOAD-BASELINE.md`）。
- 补充资料（数据字典、协议等）可建立子文件夹，但需在模块 `README.md` 中登记链接。

### 快速开始示例（PowerShell）

Copy-Item -Recurse .memories/templates/module .memories/modules/demand-forecast
Rename-Item .memories/modules/demand-forecast/FUNCTION.template.md FUNCTION-CALC-PEAK.md

复制后请逐项填写模板字段，并在 `modules/INDEX.md` 登记模块信息。
```

---

## 配套资源

本仓库已包含完整的 `.memories/` 目录结构：

```
.memories/
├── README.md              # 记忆主目录说明
├── modules/
│   └── INDEX.md           # 模块索引
├── templates/
│   └── module/
│       ├── README.md      # 模块导航模板
│       ├── PRD.md         # 产品需求模板
│       └── FUNCTION.template.md  # 功能文档模板
└── scripts/
    ├── memories-lookup.sh   # Linux/Mac 速查脚本
    └── memories-lookup.cmd  # Windows 速查脚本
```

## 参考

- 示例仓库：https://github.com/1120370331/SWE-Initial/tree/main/.memories
