# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is a personal Vim configuration that lives at `~/.vim`. There is no build, no test suite, and no package to publish — changes are validated by sourcing them into a running Vim session.

## Common commands

- Install / update plugins: launch Vim and run `:PlugInstall`, `:PlugUpdate`, or `:PlugClean`. Plugin manager (`vim-plug`) is vendored at `autoload/plug.vim` and installs into `plugged/` (gitignored).
- Reload config without restart: `:source ~/.vimrc` (or `:source %` while editing it).
- Inspect coc.nvim language server state: `:CocInfo`, `:CocList extensions`, `:CocConfig` (edits `coc-settings.json`).
- Lint current C++ file via the custom command in `format.vim`: `:CppLint` (runs `cpplint.py`, results go to QuickFix). Requires `cpplint.py` on `$PATH`.

## Architecture

The config is intentionally small and split across four loaded files:

1. **`.vimrc`** — entry point. Declares plugins between `plug#begin('~/.vim/plugged')` and `plug#end()`, then sets editor options, key mappings, and coc.nvim bindings. It `source`s `~/.vim/format.vim` near the bottom; `format.vim` must remain sourceable from `.vimrc` for C++ indent/whitespace behavior to apply.
2. **`format.vim`** — C++-specific behaviors: a `FixCppIndent()` function wired via `autocmd FileType cpp nested setlocal indentexpr=...` (handles template params and initializer lists where stock `cindent` fails), `RemoveTrailingSpace()` and `FixInconsistFileFormat()` on `BufWritePre`, and the `:CppLint` user command. `RemoveTrailingSpace` is gated on `$VIM_HATE_SPACE_ERRORS != '0'` — set that env var to `0` to disable trim-on-save.
3. **`coc-settings.json`** — coc.nvim configuration. Currently registers a single `clangd` language server for C/C++/Obj-C. Both the clangd binary path (`/home/mmdev/clang/bin/clangd`) and the `compilationDatabasePath` (`/data/home/blinkchen/QQMail`) are hardcoded to a previous machine; expect to update these when moving environments.
4. **`UltiSnips/cpp.snippets`** — UltiSnips snippets for C++. Note: UltiSnips is *not* in the `Plug` list in `.vimrc`, so these snippets are inert unless a UltiSnips plugin is added back.

### Completion stack

Per the most recent refactor (commit `243e6a0`), the live completion path is **coc.nvim + clangd**, configured in `coc-settings.json` and bound to `<Tab>`/`<CR>`/`gd`/`gy`/`gi`/`gr`/`K`/`<Leader>rn`/`<Leader>f`/`<Leader>F` in `.vimrc`. The legacy `.ycm_extra_conf.py` (YouCompleteMe) is kept in the tree but is **not** wired up — YCM is no longer in the `Plug` list. Don't edit `.ycm_extra_conf.py` to change completion behavior; edit `coc-settings.json` (and per-project `compile_commands.json`) instead.

### Conventions baked into the config

- **Leader key is backtick** (`` ` ``). All `<Leader>x` mappings in `.vimrc` assume this.
- **`jj` in insert mode = `<Esc>`** (`imap jj <Esc>`).
- **Indent is 2 spaces, `expandtab`** everywhere (`tabstop`/`softtabstop`/`shiftwidth` all 2 in both `.vimrc` and `format.vim`). Match this when adding new options.
- **Save hooks rewrite the buffer**: trailing whitespace and stray `\r` are stripped on `BufWritePre`. Anything that should be preserved verbatim must opt out via `$VIM_HATE_SPACE_ERRORS=0`.
- Comments throughout the config are in Chinese; preserve that style when editing existing sections.

## Workflow notes

- Plugin changes go in the `plug#begin … plug#end` block in `.vimrc`, then `:PlugInstall` / `:PlugClean` from inside Vim. Don't commit anything under `plugged/` — it's gitignored.
- When changing key mappings, check both the top of `.vimrc` (general/FZF/buffer maps) and the coc.nvim section at the bottom — they share the `<Leader>` namespace (e.g. `<Leader>f` is coc format-selected).
