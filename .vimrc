call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'rakr/vim-one'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-signify'

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
let g:clang_format#command="/usr/local/bin/clang-format"
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
let g:NERDTreeGitStatusIndicatorMapCustom={
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


source ~/.vim/format.vim
