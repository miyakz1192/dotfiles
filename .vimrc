"================================================
" NeoBundleのインストール
"================================================
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

"""""""""""""""""""""""""""""""""""""""""""""""
"ここにインストールしたいプラグインの設定を書く
"""""""""""""""""""""""""""""""""""""""""""""""
"  :help neobundle-examples
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'junegunn/seoul256.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'Shougo/neocomplete.vim'
" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
"scala でシンタックスハイライトを実現
NeoBundle 'derekwyatt/vim-scala'

NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \ },
      \ "build": {
      \   "mac": "pip install jedi",
      \   "unix": "sudo pip install jedi",
      \ }}

call neobundle#end()

filetype plugin indent on

"プラグインがインストールされているかチェック
NeoBundleCheck

if !has('vim_starting')
  ".vimrcを読み直したときのための設定
  call neobundle#call_hook('on_source')
endif

"vimのバージョンを 7.4 (2013 Aug 10, compiled Dec 30 2014 20:15:56)
"にしてから、syntax onのを宣言をここの位置で行わないと、シンタックス
"ハイライトが効かなくなった。
syntax on
set title
set background=dark
"===============================================
" その他の設定
"===============================================
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
" メモ:agをインストールするための設定(ubuntu 12.04)
" wget "https://github.com/ggreer/the_silver_searcher/archive/master.zip"
" sudo apt-get install automake
" sudo apt-get install libpcre-ocaml-dev -y
" sudo apt-get install liblzma-dev -y
" sudo apt-get install pkg-config -y
" sudo apt-get install make -y
" ./build.sh
" make install
"""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""
" メモ:luaをインストールするための設定
" sudo apt-get  install lua5.1
" sudo apt-get  install lua5.1-dev
" vimをビルド
"
" sudo apt-get install mercurial
" $ cd /usr/local/src
" $ hg clone https://vim.googlecode.com/hg/ vim
" $ cd vim
" $ vim vuild.sh
"  cat vuild.sh
" #!/bin/sh
" ./configure \
"  --prefix=/usr/local \
"  --with-features=huge \
"  --enable-multibyte \
"  --enable-luainterp \
"  --enable-fail-if-missing && make && make install
" $ chmod +x vuild.sh
" $ ./vuild.sh
" $ alias vim="/usr/local/bin/vim"
"
" #install for vim
" #reference URL
" #http://t2y.hatenablog.jp/entry/2014/04/26/191252
" mkdir ~/source/vim
" cd ~/source/vim
" sudo apt-get build-dep vim -y
" apt-get source vim
" sudo apt-get install devscripts -y
"
" debchange -i
" -------
"  vim (2:7.4.052-1ubuntu4) UNRELEASED; urgency=medium
"
"    * enable lua interface
"
"     -- miyakz <miyakz@ubuntu>  Fri, 02 Jan 2015 23:36:36 +0900
"     -------
"
"     edit "debian/rules"
"     CFLAGS_vim-basic:=$(CFLAGS)
"     CFGFLAGS_vim-basic:=$(CFGFLAGS) $(OPTFLAGS) $(NOXFLAGS)
"     $(ALLINTERPFLAGS)
"
"     change NOINTERPFLAGS to ALLINTERPFLAGS
"
"     debuild -us -uc
"""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""
" メモ:rby連携の設定
" sudo apt-get install ruby-dev
"""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""
" neocompleteの設定
"""""""""""""""""""""""""""""""""""""""""""""""""
"neocompleを有効化するための設定
let g:neocomplete#enable_at_startup = 1
"Rubyのための設定(オムニ補完)
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unite.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""
" jedi(pythonの自動補完)の設定
"""""""""""""""""""""""""""""""""""""""""""""""""
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
  " jediにvimの設定を任せると'completeopt+=preview'するので
  " 自動設定機能をOFFにし手動で設定を行う
  let g:jedi#auto_vim_configuration = 0
  " 補完の最初の項目が選択された状態だと使いにくいためオフにする
  let g:jedi#popup_select_first = 0
  " quickrunと被るため大文字に変更
  let g:jedi#rename_command = '<Leader>r'
  " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
  let g:jedi#goto_assignments_command = '<Leader>g'
endfunction

"
" TAGSファイルの読み込みパス設定
set tags=./TAGS,TAGS,./tags,tags

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

" 長いテキストの折り返し
set wrap

" その代わり80文字目にラインを入れる
set colorcolumn=80

" タブページのラベルを常に表示
set showtabline=2

" 長い行を @ にさせない
set display=lastline

" 対応する括弧などをハイライト表示する
set showmatch

" 対応括弧のハイライト表示を3秒にする
set matchtime=3

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

