# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库用途

这是位于 `~/.vim` 的个人 Vim 配置。没有构建流程、没有测试套件、也不发布任何包 —— 改动通过将其 source 进运行中的 Vim 会话来验证。

## 常用命令

- 安装/更新插件：在 Vim 中执行 `:PlugInstall`、`:PlugUpdate` 或 `:PlugClean`。插件管理器（`vim-plug`）以源码形式存放于 `autoload/plug.vim`，安装目标为 `plugged/`（已 gitignore）。
- 不重启重新加载配置：`:source ~/.vimrc`（或编辑 `.vimrc` 时直接 `:source %`）。
- 检查 coc.nvim 语言服务器状态：`:CocInfo`、`:CocList extensions`、`:CocConfig`（编辑 `coc-settings.json`）。
- 通过 `format.vim` 中的自定义命令对当前 C++ 文件做 lint：`:CppLint`（调用 `cpplint.py`，结果输出到 QuickFix）。需要 `cpplint.py` 在 `$PATH` 中。

## 架构

配置刻意保持精简，分散在四个被加载的文件中：

1. **`.vimrc`** —— 入口。在 `plug#begin('~/.vim/plugged')` 与 `plug#end()` 之间声明插件，随后设置编辑器选项、按键映射以及 coc.nvim 相关绑定。文件末尾会 `source` `~/.vim/format.vim`；`format.vim` 必须保持可被 `.vimrc` source，否则 C++ 缩进/空白处理逻辑不会生效。
2. **`format.vim`** —— C++ 专属行为：通过 `autocmd FileType cpp nested setlocal indentexpr=...` 接入的 `FixCppIndent()` 函数（处理原生 `cindent` 搞不定的模板参数与初始化列表）；`BufWritePre` 上挂载的 `RemoveTrailingSpace()` 与 `FixInconsistFileFormat()`；以及 `:CppLint` 用户命令。`RemoveTrailingSpace` 受 `$VIM_HATE_SPACE_ERRORS != '0'` 控制 —— 设为 `0` 可关闭保存时的去尾空白行为。
3. **`coc-settings.json`** —— coc.nvim 配置。当前只为 C/C++/Obj-C 注册了一个 `clangd` 语言服务器。clangd 二进制路径（`/home/mmdev/clang/bin/clangd`）和 `compilationDatabasePath`（`/data/home/blinkchen/QQMail`）都是硬编码的旧机器路径；切换环境时需要更新。
4. **`UltiSnips/cpp.snippets`** —— C++ 用的 UltiSnips 片段。注意：`.vimrc` 的 `Plug` 列表里**没有** UltiSnips，因此除非重新加回 UltiSnips 插件，这些片段不会生效。

### 补全方案

按最近一次重构（commit `243e6a0`），现行补全路径是 **coc.nvim + clangd**，配置在 `coc-settings.json`，按键绑定在 `.vimrc` 中：`<Tab>`/`<CR>`/`gd`/`gy`/`gi`/`gr`/`K`/`<Leader>rn`/`<Leader>f`/`<Leader>F`。遗留的 `.ycm_extra_conf.py`（YouCompleteMe）仍保留在仓库里但**未启用** —— YCM 已不在 `Plug` 列表中。改补全行为不要去改 `.ycm_extra_conf.py`，应改 `coc-settings.json`（以及各项目下的 `compile_commands.json`）。

### 配置中沉淀的约定

- **Leader 键是反引号**（`` ` ``）。`.vimrc` 中所有 `<Leader>x` 映射都基于此。
- **插入模式 `jj` = `<Esc>`**（`imap jj <Esc>`）。
- **缩进统一为 2 空格 + `expandtab`**（`.vimrc` 与 `format.vim` 中 `tabstop`/`softtabstop`/`shiftwidth` 都为 2）。新增选项时保持一致。
- **保存钩子会改写缓冲区**：`BufWritePre` 时去尾空白与残留 `\r` 都会被清除。需要原样保留的内容必须通过 `$VIM_HATE_SPACE_ERRORS=0` 退出该行为。
- 配置中的注释一律使用中文；编辑既有片段时请保持该风格。

## 工作流提示

- 插件改动写在 `.vimrc` 的 `plug#begin … plug#end` 块里，然后在 Vim 内执行 `:PlugInstall` / `:PlugClean`。不要提交 `plugged/` 下的任何内容 —— 已被 gitignore。
- 修改按键映射时，注意检查 `.vimrc` 顶部（通用/FZF/buffer 映射）和底部 coc.nvim 区段两处 —— 它们共享 `<Leader>` 命名空间（例如 `<Leader>f` 是 coc 的 format-selected）。
