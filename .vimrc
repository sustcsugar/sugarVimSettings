"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 定义折叠 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startup {{{
filetype indent plugin on


" vim 文件折叠方式为 marker
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
augroup END
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General {{{
syntax on                   " 开启语法高亮 
set nocompatible            "不兼容原始vi模式
set nu rnu                  "abs nu & relative nu
set nobackup
set noswapfile
set history=500
filetype plugin indent on   " 打开文件类型检测
set autochdir
"set whichwrap=b,s,<,>,[,]
set nobomb
"set backspace=indent,eol,start whichwrap+=<,>,[,]
set clipboard+=unnamed
set winaltkeys=no           " 设置 alt 键不映射到菜单栏
"set aststatus              "总是显示状态栏
set cursorline              "设置光标行高亮
set hlsearch
set scrolloff=5            "移动光标时,始终保留上下五行
set list                      " 显示不可见字符, tab和换行符
set listchars=tab:>-,trail:.  " 将tab和换行符显示的符号修改,同时修改行尾空格trail为.
" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码缩进与排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缩进排版{{{
set autoindent
filetype indent on  "自适应不同语言的智能缩进
set expandtab       "将制表符扩展为空格
set tabstop=4       "设置编辑时制表符所占的空格数
set shiftwidth=4    "设置格式化时制表符占用的空格数
set softtabstop=4    "设置4个空格为制表符
"}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lang & Encoding {{{
"set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
set encoding=utf-8
set langmenu=zh_CN
let $LANG = 'en_US.UTF-8'
"language messages zh_CN.UTF-8   "显示中文消息
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI设置 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI {{{
" 设置主题格式
colorscheme solarized
"colorscheme gruvbox
"set guifont=Courier_New:h13
"set guifont=Inconsolata:h13
if has('win32')
    set guifont=Monaco:h14
elseif has('unix')
    set guifont=Monaco:h14
elseif has('mac')
    set guifont=Monaco:h14
endif

" 解决菜单乱码问题
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" 窗口大小
" set lines=50 columns=140
"winpos 700 100
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
"不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b

" 使用内置 tab 样式而不是 gui
"set guioptions-=e
"set nolist
" set listchars=tab:▶\ ,eol:¬,trail:·,extends:>,precedes:<
"set guifont=Inconsolata:h12:cANSI
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 优化设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
let mapleader = " "         "设置leader键
inoremap jk <Esc>

nnoremap <leader>f *
nnoremap <leader>e :e $MYVIMRC<cr>
nnoremap <leader>r :source $MYVIMRC<cr>

nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^
onoremap L $
onoremap H ^


" 快速切换窗口
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" 切换buffer
nnoremap <leader>x :bprev<cr>
nnoremap <leader>z :bnext<cr>
" 插入模式移动光标 alt + 方向键
"inoremap <M-j> <Down>
"inoremap <M-k> <Up>
"inoremap <M-h> <Left>
"inoremap <M-l> <Right>

" 修改分屏大小
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
" }}}


" 添加作者信息 {{{
"第一部分
"将键盘上的F4功能键映射为添加作者信息的快捷键
map <leader>a ms:call TitleDet()<cr>'s
function AddTitle()
    call append(0,"##############################################")
    call append(1,"#")
    call append(2,"# Author: Shi Gang")
    call append(3,"#")
    call append(4,"# Email : 1144392179@qq.com")
    call append(5,"#")
    call append(6,"# Creat Time : ".strftime("%Y-%m-%d %H:%M"))
    call append(7,"#")
    call append(8,"# Last modified: ".strftime("%Y-%m-%d %H:%M"))
    call append(9,"#")
    call append(10,"# Filename: ".expand("%:t"))
    call append(11,"#")
    call append(12,"# Description: ")
    call append(13,"##############################################")
    call append(14,"")
    call append(15,"")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
endfunction
"此处为预显示的格式
"第二部分
"更新最近修改时间和文件名
function UpdateTitle()
    normal m'
    execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction
"第三部分
"判断前10行代码里面，是否有Last modified这个单词（为更新时间的依据），
"如果没有的话，代表没有添加过作者信息，需要新添加；
"如果有的话，那么只需要更新即可
function TitleDet()
    let n=1
    while n < 13
        let line = getline(n)
        if line =~ '^\#\s*\S*Last\smodified:\S*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction

" }}}


" Plugin Settings {{{
call plug#begin() " The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"
"}}}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" NERDTree {{{
nnoremap <leader>t :NERDTreeToggle<CR>
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" }}}
