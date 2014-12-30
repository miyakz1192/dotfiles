"""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundleのインストール
"""""""""""""""""""""""""""""""""""""""""""""""""
" neobundle.vim の設定 {{{
" neobundle.vim が無ければインストールする
if ! isdirectory(expand('~/.vim/bundle'))
    echon "Installing neobundle.vim..."
    silent call mkdir(expand('~/.vim/bundle'), 'p')
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    echo "done."
    if v:shell_error
        echoerr "neobundle.vim installation has failed!"
        finish
    endif
endif

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))

"neobundle自身をneobundle.vimで管理する
NeoBundleFetch 'Shugo/neobundle.vim'

"ここにインストールしたいプラグインの設定を書く
"  :help neobundle-examples
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'junegunn/seoul256.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'rking/ag.vim'

call neobundle#end()

filetype plugin indent on

"プラグインがインストールされているかチェック
NeoBundleCheck

if !has('vim_starting')
  ".vimrcを読み直したときのための設定
  call neobundle#call_hook('on_source')
endif

"""""""""""""""""""""""""""""""""""""""""""""""""
" その他の設定
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:is_unix = has('unix')
let g:is_windows = has('win32') || has('win64')
let g:is_gui = has('gui_running')
let g:is_terminal = !g:is_gui
let g:is_unicode = (&termencoding ==# 'utf-8' || &encoding == 'utf-8') && !(exists('g:discard_unicode') && g:discard_unicode != 0)

"lightlineの設定
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" カラースキーム
" Unified color scheme (default: dark)
let g:seoul256_background = 236
colo seoul256

"""""""""""""""""""""""""""""""""""""""""""""""""
" agをインストールするための設定(ubuntu 12.04)
" wget "https://github.com/ggreer/the_silver_searcher/archive/master.zip"
" sudo apt-get install automake
" sudo apt-get install libpcre-ocaml-dev
" sudo apt-get install liblzma-dev
" ./build.sh
" make install
"""""""""""""""""""""""""""""""""""""""""""""""""

" TAGSファイルの読み込みパス設定
set tags=./TAGS,TAGS

" must be set with multibyte strings
scriptencoding utf-8

" Vim options {{{
" ### Indent ### {{{
" 新しい行のインデントを現在行と同じにする
"set autoindent

" 高度なインデント
"set smartindent

" タブが対応する空白の数
set tabstop=2

" インデントでずれる幅
set shiftwidth=2

" タブキーでカーソルが動く幅
set softtabstop=2

" タブの代わりに空白を挿入
set expandtab

" 空白文字をいいかんじで挿入する
"set smarttab
" }}}


" ### Search ### {{{
" ハイライトで検索
set hlsearch
nohlsearch

" 大文字小文字を無視
set ignorecase

" インクリメンタル検索
set incsearch

" 大文字が入力されたら大文字小文字を区別する
set smartcase
" }}}

" ### Buffer ### {{{
" 外部でファイルが変更されたら自動で読みなおす
"set autoread

" 隠れ状態にしない
"set nohidden

" 漢には不要
"set noswapfile

" on だと guard が複数回実行されてしまう問題がある
"set nowritebackup

" 既存のファイルを開くときはとりあえず utf-8
set fileencodings=utf-8,default,ucs-bom,latin1

" Vim を終了しても undo の記録を残す
set undofile undodir=~/.vimundo
" }}}

" ### View ### {{{
" 色数
"set t_Co=256

" コマンドラインの行数
set cmdheight=1

" 現在行の色を変える
set cursorline
let g:cursorline_flg = 1 " cursorline はウィンドウローカルなのでグローバルなフラグを用意しておく
let g:cursorcolumn_flg = 0

" ステータス行を常に表示
set laststatus=2

" 再描画しない (gitv.vim で推奨されている)
set lazyredraw

" 不可侵文字を可視化
set list
set listchars=tab:>\ "

" 最低でも上下に表示する行数
"set scrolloff=5

set number

" 入力したコマンドを画面下に表示
set showcmd

" 自動折り返ししない
set textwidth=0

" タブページのラベルを常に表示
set showtabline=2

" 長い行を @ にさせない
set display=lastline

" 埋める文字
"set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-

" vim の継続行(\)のインデント量を 0 にする
"let g:vim_indent_cont = 0

" 補完メニューで preview しない
"set completeopt-=preview
" }}}

" ### Input ### {{{
" バックスペースで削除できる文字
set backspace=indent,eol,start

" ヤンクなどで * レジスタにも書き込む
"set clipboard=unnamed

" ヤンクなどで + レジスタにも書き込む
"if has('unnamedplus')
"  set clipboard+=unnamedplus
"endif
"
" マッピングの受付時間 (<Leader> とか)
set timeout
set timeoutlen=1000

" キーコードの受付時間 (<Esc> とか)
"set ttimeoutlen=100

" 矩形選択を可能にする
"set virtualedit& virtualedit+=block

" 行連結で変なことをさせない
"set nojoinspaces

" 折り返した行の表示
"if g:is_unicode
"  let &showbreak = "\u21b3 "
"else
"  let &showbreak = "`-"
"endif
"" }}}


