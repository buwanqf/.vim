call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-signify'

"Plug 'Valloric/YouCompleteMe'
Plug 'dense-analysis/ale'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rhysd/vim-clang-format'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'fatih/vim-go'
Plug 'dgryski/vim-godef'
Plug 'Blackrush/vim-gocode'
call plug#end()
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 显示命令提示
set showcmd
" 语言色彩
syntax enable
" 语法高亮
syntax on
" 24bit颜色
set termguicolors
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" 背景颜色黑色
set background=dark
" 设置颜色主题
"colorscheme molokai
colorscheme one
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
" 使用c语言的缩进
set cindent
" Tab键的宽度
" 统一缩进为4
set tabstop=4
set softtabstop=4
set shiftwidth=4
" 用空格代替制表符
set expandtab
set autoindent
" 显示行号
set number
" 历史记录数
set history=100
" 搜索忽略大小写
set ignorecase
" 搜索逐字符高亮
set hlsearch
" 忽略大小写搜索
set incsearch
" 行内替换
set gdefault
" 在编辑过程中，在右下角显示光标位置的状态行
set ruler
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 设置退格键
set backspace=indent,eol,start
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5
" 设置智能缩进
set smartindent
"高亮光标所在行
set cursorline
" 关闭遇到错误时的声音提示
set noerrorbells
" 编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set fenc=utf-8

" 快捷键配置
imap jj <Esc>

" 退出时记住位置
autocmd BufReadPost *
    \ if line("'\"")>0&&line("'\"")<=line("$") |
    \   exe "normal g'\"" |
    \ endif

" clang-format格式化代码
let g:clang_format#command="/opt/rh/llvm-toolset-7/root/bin/clang-format"
let g:clang_format#auto_format=0
let g:clang_format=1
autocmd FileType c,cpp,proto nnoremap <buffer><Leader>cf :<C-l>ClangFormat<CR>
autocmd FileType c,cpp,proto vnoremap <buffer><Leader>cf :ClangFormat<CR>

" NERDTree设置
map <Leader>nd :NERDTreeMirror<CR>
map <Leader>nd :NERDTreeToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\~$','\.swp']
let NERDTreeShowHidden=1
let g:NERDTreeIndicatorMapCustom={
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" 设置airline主题
let g:airline_theme='minimalist'

" YouCompleteMe
set completeopt=menu,menuone,longest
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt=0
let g:ycm_show_diagnostics_ui=0
let g:ycm_key_invoke_completion='<c-l>'
noremap <c-l> <NOP>
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_min_num_identifier_candidate_chars=2
let g:ycm_semantic_triggers={
    \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
    \ 'cs,lua,javascript': ['re!\w{2}'],
    \ }
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_complete_in_strings=1

" dense-analysis/ale
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta
