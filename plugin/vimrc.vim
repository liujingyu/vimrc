""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  vimrc配置                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("g:loaded_vimrc") || &cp
    finish
else
    let g:loaded_vimrc = 1
end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    基本配置                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"line no
set nu
"光标
set mouse=a
" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atl
" 帮助文件使用中文
set helplang=cn
" 设置折叠模式
set foldcolumn=4
" 光标遇到折叠就打开
set foldopen=all
"突出显示当前行
set cursorline
"no bomb
set nobomb
set history=10000

set encoding=utf-8

set shortmess=atI "去掉欢迎界面

" No beeps
set noerrorbells

" Fast saving or quit
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>Q :qa!<cr>
nmap <Leader>WQ :wqa<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

set incsearch "Make search act like search in modern browsers

" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" 将制表符扩展为空格
set expandtab
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 设置编辑时制表符占用空格数
set tabstop=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

"光标处理
if exists('$TMUX')
   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Always hide the statusline
set laststatus=2

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/apple/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
   if &paste
       return 'PASTE MODE  '
   else
       return ''
   endif
endfunction

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ " Line:\ %l/%L:%c

" ctags设置
" set tags+=/Users/apple
" set autochdir
set tags=tags;/
" 生成一个tags文件
nmap <F9> <Esc>:!ctags -R *<CR>

" 设置好后，可在Vim中使用如下功能：Ctrl-]转至最佳匹配的相应Tag，Ctrl-T返回上一个匹配。
" 如果有多个匹配，g Ctrl-]可显示所有备选的tags。如有需要，可互换Ctrl-]和g Ctrl-] [11]：
"在普通和可视模式中，将<c-]>与g<c-]>互换
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" 删除行尾的空格
func! DeleteTrailingWS()
    exe "normal mA"
    %s/\s\+$//ge
    exe "normal `A"
    exe "normal dmA"
endfunc

au BufWrite *.php :call DeleteTrailingWS()
au BufWrite *.py :call DeleteTrailingWS()
au BufWrite *.js :call DeleteTrailingWS()
au BufWrite *.vimrc :call DeleteTrailingWS()
au BufWrite *.md :call DeleteTrailingWS()

" 为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" 使用 <Space>p 与 <Space>y 进行剪切板拷贝、粘贴：
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" nmap <Leader><Leader> V

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     缩进                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 使用自动缩进可能需要设置，vim中对自动缩进的详细设置办法见Vim代码缩进设置。

" 在不同的模式中调整缩进的方法不同：

" 插入模式
" Ctrl-T增加缩进，Ctrl-D减小缩进。
" 命令模式
" >> 右缩进， << 左缩进，注意n<< 或 n>>是缩进多行，如4>>
" 可视模式
" < 、 > 用于左右缩进， n< 、 n> 可做多节缩进，如 2> 。
" 另外，= 可对选中的部分进行自动缩进；]p可以实现p的粘贴功能，并自动缩进。

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                php settings                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"php complete system function
au FileType php set omnifunc=phpcomplete#CompletePHP
func! AddPHPFuncList()
    set dictionary-=~/vim/funclist.txt dictionary+=~/vim/funclist.txt
    set complete-=k complete+=k
endfunction
au FileType php call AddPHPFuncList()

" You might also find this useful
" PHP Generated Code Highlights (HTML & SQL)
let php_sql_query=1
let php_htmlInStrings=1

"php手册 打开PHP文件后，把光标移动到某个函数下，按大写的K键即可查看函数的文档内容
"利用composer 安装pman,命令 composer global require gonzaloserrano/pman-php-manual:dev-master
au FileType php setlocal keywordprg=pman


