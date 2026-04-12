call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" 设置 Leader 键
let mapleader = "`"
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 显示命令提示
set showcmd
" 语法高亮
syntax on
" 24bit颜色
set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" 背景颜色黑色
set background=dark
" 设置颜色主题
colorscheme one
"colorscheme onedark
" 关闭错误提示声音
set noerrorbells
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 缩进设置
set autoindent
set cindent
set smartindent
" 统一缩进为2
set tabstop=2
set softtabstop=2
set shiftwidth=2
" 用空格代替制表符
set expandtab
" 显示行号
set number
" 历史记录数
set history=100
" 搜索设置
set ignorecase
set smartcase
set hlsearch
set incsearch
" 行内替换
set gdefault
" 在右下角显示光标位置
set ruler
" 侦测文件类型
filetype on
filetype plugin on
filetype indent on
" 命令行自动完成
set wildmenu
" 允许切换 buffer 时不强制保存
set hidden
" 设置退格键
set backspace=indent,eol,start
" 允许光标键跨越行边界
set whichwrap+=<,>,h,l
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5
" 高亮光标所在行
set cursorline
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

" 设置airline主题
let g:airline_theme='minimalist'
" 顶部显示 buffer 标签栏
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" --- Buffer 切换 ---
nnoremap <Leader>] :bn<CR>
nnoremap <Leader>[ :bp<CR>
nnoremap <Leader>q :bd<CR>

" --- FZF ---
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>s :Rg<CR>
nnoremap <Leader>h :History<CR>

source ~/.vim/format.vim

" ============================================================
" coc.nvim 配置
" ============================================================

" Tab 补全导航
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" 回车确认补全
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
    \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" K 查看文档
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" 诊断跳转
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 重命名
nmap <Leader>rn <Plug>(coc-rename)

" 格式化选中区域
xmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>f <Plug>(coc-format-selected)

" 格式化整个文件
nmap <Leader>F :call CocActionAsync('format')<CR>
