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
colorscheme tender
"colorscheme gruvbox
"set guifont=Courier_New:h13
set guifont=Inconsolata:h13

" 解决菜单乱码问题
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" 窗口大小

"set lines=50 columns=140
"winpos 700 100
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
"不显示工具/菜单栏
" set guioptions-=T
" set guioptions-=m
" set guioptions-=L
" set guioptions-=r
" set guioptions-=b

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
nnoremap sp :sp<cr>
nnoremap vs :vs<cr>

nnoremap H ^
nnoremap L $
omap H ^
omap L $

" 快速切换窗口
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" 切换buffer
nnoremap <M-h> :bprev<cr>
nnoremap <M-l> :bnext<cr>
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


map <leader>x :bnext<CR>
map <leader>z :bprev<CR>
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

" alias {{{
"Hot key for comments
ab ccc   //-----------------------------------------------------------------------------------
ab ccl*  *************************************************************************************
ab ccl=  =====================================================================================
ab ccl#  #------------------------------------------------------------------------------------
ab ccl+  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ab ccl-  -------------------------------------------------------------------------------------
ab ccs   //-------------------------------------
ab cc+   +++++++++++++++++++++++++++++++++++++++
ab cc=   =======================================
ab cc*   ***************************************
ab cc-   ---------------------------------------
ab cc#   #--------------------------------------
" }}}


"  functions {{{
" this abbreviation %% expands to the full path of the directory that contains
" the current file. For example, while editing file /some/path/myfile.txt,
" typing: e %%/ on the command line will expand to :e /some/path/.
cabbr <expr> %% expand('%:p:h') 



"Self-defined function Cnt_match to count and show the matched search_wd
function Cnt_match(search_wd)
   let cnt = 0 
   let i = 1 
   let cur_line = line(".")
   normal G
   let last_lie = line(".")
   echo "Searching ... " a:search_wd

   normal gg

   while search(a:search_wd,"W") > 0 
      echo "Yes ... Line".line(".")."  >::>::>".getline(".")
      let cnt = cnt + 1
   endwhile


   echo "Match Counter : ". cnt
   execute cur_line
endfunction



"Self-defined function Clum_i to insert number to signal list
"This is helpful to name huge signal list with number
function Clum_i(start,end,span)
   let cnt = a:start
   let line_num = line(".")
   let clum_num = col(".")

   while cnt <= a:end
      execute "normal i".cnt."\<ESC>"
      let line_num = line_num + a:span + 1 
      call cursor(line_num,clum_num)
      let cnt = cnt + 1
   endwhile
endfunction;
" }}}



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle插件设置  使用 :PluginInstall即可安装列表中的插件
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle插件环境设置 {{{
filetype off
set rtp+=~/vimfiles/bundle/Vundle.vim

call vundle#rc('~/vimfiles/bundle/')
" vundle管理的插件列表必须位于vundle#begin()和vundle#end()之间
call vundle#begin()
" 插件管理插件
Plugin 'VundleVim/Vundle.vim'
" 主题
Plugin 'altercation/vim-colors-solarized'
Plugin 'jacoborus/tender.vim'
Plugin 'morhetz/gruvbox'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'scrooloose/nerdtree'
Plugin 'neoclide/coc.nvim'
Plugin 'honza/vim-snippets'
" git plugins
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'
" 插件列表结束
call vundle#end()
filetype plugin indent on
" }}}


" @airline{{{


set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
"这个是安装字体后 必须设置此项" 
set guifont=Consolas_for_Powerline_FixedD:h13:cANSI:qDRAFT
let g:airline_powerline_fonts = 1
set laststatus=2  "永远显示状态栏
let g:airline_theme='bubblegum' "选择主题
let g:airline#extensions#tabline#enabled=1              "Smarter tab line: 显示窗口tab和buffer
"let g:airline#extensions#tabline#buffer_nr_show=1              "Smarter tab line: 显示窗口tab和buffer

let g:airline#extensions#tabline#formatter = 'unique_tail'  "formater
"let g:airline#extensions#whitespace#symble = '!'
"let g:airline#extensions#tabline#left_sep = ' '         "separater
"let g:airline#extensions#tabline#left_alt_sep = '|'     "separater
"
"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
" }}}

" @NERDTree {{{
"map <leader>t :NERDTreeMirror<CR>
map <leader>t :NERDTreeToggle<CR>

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" }}}

" @cocnvim {{{
set hidden   " vim在文件未保存的情况下,不允许文件跳转,添加这个设置可以让vim允许跳转

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" cocnvim检查的语法报错问题,和行号共用同一栏位
"if has("nvim-0.5.0") || has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" 使用回车选择补全, 不换行
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
"nmap <silent> <leader>y <Plug>(coc-type-definition)
"nmap <silent> <leader>i <Plug>(coc-implementation)
"nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <leader>h :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}


