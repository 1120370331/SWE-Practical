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

## 什么是记忆文件管理系统

记忆文件管理系统是一套帮助你（AI）在大型项目中保持上下文记忆的方案。通过在项目根目录维护 `.memories/` 目录，集中沉淀业务背景、产品决策与代码实现细节，让你在接手任务时能快速理解项目，完成任务后能留下知识供后续查阅。

## 为什么需要它

- 大型项目代码量大，你无法一次性理解全部业务逻辑
- 每次对话上下文有限，之前的决策和讨论容易丢失
- 多次迭代后，历史决策的原因难以追溯
- 通过结构化的记忆文件，你可以快速定位相关资料，避免重复踩坑

## 核心结构

```
.memories/
├── README.md              # 记忆主目录说明
├── modules/               # 记忆模块目录
│   ├── INDEX.md           # 模块索引（清单、负责人、更新时间）
│   └── <业务-主题>/       # 具体模块，如 user-auth、order-flow
│       ├── README.md      # 模块导航
│       ├── PRD.md         # 产品需求、场景、边界
│       └── FUNCTION-*.md  # 功能实现文档（可多个）
├── templates/             # 模块模板
│   └── module/
│       ├── README.md
│       ├── PRD.md
│       └── FUNCTION.template.md
└── scripts/               # 速查脚本
    ├── memories-lookup.sh   # Linux/Mac
    └── memories-lookup.cmd  # Windows
```

## 你的工作流程

### 第一步：检查项目是否已有记忆系统

开始任何任务前，先检查项目根目录是否存在 `.memories/` 目录。

### 第二步：如果不存在，主动搭建

如果项目中没有 `.memories/` 目录，你需要主动为项目初始化这套体系：

1. 创建目录结构：
   ```bash
   mkdir -p .memories/modules .memories/templates/module .memories/scripts
   ```

2. 创建 `.memories/README.md`（记忆主目录说明）

3. 创建 `.memories/modules/INDEX.md`（模块索引）

4. 创建模板文件：
   - `.memories/templates/module/README.md`（模块导航模板）
   - `.memories/templates/module/PRD.md`（产品需求模板）
   - `.memories/templates/module/FUNCTION.template.md`（功能文档模板）

5. 创建速查脚本（可选）：
   - `.memories/scripts/memories-lookup.sh`
   - `.memories/scripts/memories-lookup.cmd`

6. 根据当前任务涉及的业务，创建第一个记忆模块

### 第三步：如果已存在，查阅相关模块

1. 执行 `--list-modules` 查看现有模块列表：
   ```bash
   sh .memories/scripts/memories-lookup.sh --list-modules
   # Windows: .memories\scripts\memories-lookup.cmd --list-modules
   ```

2. 如果相关模块已存在：
   - 执行 `.memories/scripts/memories-lookup.sh <模块目录名> [关键字...]` 快速定位资料
   - 先读模块 `README.md`，再查看 `PRD.md` 与相关 `FUNCTION-*.md`
   - 核对实现约束后再动手

3. 如果相关模块不存在，新建模块：
   ```powershell
   # PowerShell
   Copy-Item -Recurse .memories/templates/module .memories/modules/<业务-主题>
   # Linux/Mac
   cp -r .memories/templates/module .memories/modules/<业务-主题>
   ```
   - 将 `FUNCTION.template.md` 重命名为具体功能名，如 `FUNCTION-LOGIN.md`
   - 填写 `README.md`、`PRD.md` 的基本信息
   - 在 `modules/INDEX.md` 中登记新模块

### 第四步：收工后更新记忆

1. 在对应文档中补充你本次工作中产生的：
   - 新的决策及其原因
   - 数据位置、接口地址等关键信息
   - 遗留问题或技术债务
   - 踩过的坑和解决方案

2. 更新 `modules/INDEX.md` 中的"最后更新"时间

## 模块文件说明

### README.md（模块导航）

列出模块包含的所有文档，提供快速导航入口。

### PRD.md（产品需求）

记录：
- 业务目标：这个模块要解决什么问题
- 用户场景：谁在什么情况下使用
- 边界假设：前提条件和限制

### FUNCTION-*.md（功能文档）

记录单个函数、脚本或流程的实现细节：
- 输入输出说明
- 核心实现逻辑
- 关键代码片段（便于速查）
- 依赖关系
- 注意事项和踩坑记录

## 命名规范

- 模块目录：`业务-主题` 形式，小写加连字符（如 `user-auth`、`order-flow`）
- 功能文档：`FUNCTION-功能名.md`，大写加连字符（如 `FUNCTION-LOGIN.md`）
```

---

## 配套资源

本仓库已包含完整的 `.memories/` 目录结构，可直接复制到你的项目中使用：

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
