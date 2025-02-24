" ===================================================================
" Core rules for vimrc
"
" File          : vimrc_core.vim
" Initial Author: Sven Guckes
" Maintainer    : Luc Hermitte
" Last update   : 28th Nov 2023
" ===================================================================
if !empty($LUCHOME) && $LUCHOME != $HOME
  let paths = split(&rtp, ',')
  let paths0=paths
  call map(paths, 'stridx(v:val, $LUCHOME)>=0 ? (v:val) : substitute(v:val, $HOME, $LUCHOME, "g")')
  let &rtp = join(paths, ',')
endif

" ===================================================================
" Runtime {{{1
"set runtimepath+=$VIMRUNTIME (<=> $VIM/vim60)
set runtimepath+=$VIM
set runtimepath+=$HOME/vimfiles/latexSuite
" }}}1
" ===================================================================
" Help {{{1
  runtime plugin/help.vim
  if exists("*BuildHelp")
    command! -nargs=1 VimrcHelp :call BuildHelp("vimrc", <q-args>)
    nnoremap <S-F1> :<c-u>call ShowHelp('vimrc')<cr>
    inoremap <S-F1> <c-o>:call ShowHelp('vimrc')
    call ClearHelp("vimrc")
  else
    command! -nargs=1 VimrcHelp
  endif

:VimrcHelp "                    -------------------------
:VimrcHelp "                    C U S T O M   M A C R O S
:VimrcHelp "                    -------------------------
:VimrcHelp "
:VimrcHelp "
:VimrcHelp "
" }}}1
" ===================================================================
" SETtings: {{{1
" ===================================================================
" Vim Options: {{{2
  set nocompatible

  set bs=2              " allow backspacing over everything in insert mode
  set ai                        " always set autoindenting on
  set autowrite
  set nobackup          " do not keep a backup file, use versions instead

  set cmdheight=2
  set comments=b:#,:%,fb:-,n:>,n:)
                         "cmts df: sr:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
  set cursorline
  if exists('&cursorlineopt') " <=> has patch 8.1.2019
    set cursorlineopt=number
  endif
" set dictionary=/usr/dict/words,/local/lib/german.words
                        " english words first
  set expandtab
  set nodigraph         " use i_CTRL-K instead!
  set noequalalways     " don't resize windows after splitting or closing a window
  set noerrorbells      " damn this beep!  ;-)
  " set esckeys           " allow usage of curs keys within isrt mode
  set fileformats=unix,dos " Give the priority to UNIX, always.
  set formatoptions=cqrt
                        " Options for the "txt format" cmd ("gq")
                        " I need all those options (but 'o')!
  set helpheight=0      " zero disables this.
" set helpfile=c:\\vim-4.6\\docs\\help.txt
                        " filename of the helpfile
                        " this is where I usually put it on DOS; sometimes
                        " is required to set as the default installation
                        " does not find it  :-(
  set hidden            "
  set highlight=8r,db,es,hs,mb,Mr,n:CursorLineSign,rs,sr,tb,vr,ws
                        "  highlight=8b,db,es,hs,mb,Mn,nu,rs,sr,tb,vr,ws
  set nohlsearch
                        " highlight search - show the current search pattern
                        " This is a nice feature sometimes - but it sure
                        " can get in the way sometimes when you edit.
  set noicon            " ...
" set iconstring        " set iconstring file of icon (Sven doesn't use an icon)
  set noignorecase      " ignore the case in search patterns?  NO!
  set noinsertmode      " start in insert mode?  Naah.
  set isfname+={        " In order to use <c-w>f on ${FOO}/path
  set isfname+=}        " In order to use <c-w>f on ${FOO}/path
  set isfname-==        " In order to use <c-w>f on option=filename
  "set iskeyword=@,48-57,_,192-255,-,.
  set iskeyword+=-
                        " Add the dash ('-') and the dot ('.')
                        "                   as "letters" to "words".
                        "       iskeyword=@,48-57,_,192-255   (default)
  set joinspaces        " insert two spaces after a period with every joining
                        " of lines.  This is very nice!
  set laststatus=2      " show status line?  Yes, always!
                        " Even for only one buffer.
  set lazyredraw        " [VIM5];  do not update screen while executing macros
  let g:mapleader=' '   " Let's go spacemacs/vim's way!
  let g:maplocalleader=','
  set magic             " Use some magic in search patterns?  Certainly!
  set modeline          " Allow the last line to be a modeline - useful when
                        " the last line in sig gives the preferred textwidth
                        " for replies.
  set modelines=3
  set mousemodel=popup  " instead on extend
  set nonumber
  set nrformats-=octal
  " set path=.,$VIMRUNTIME/syntax/,$HOME/vimfiles/ftplugin/
                        " The list of directories to search when you specify
                        " a file with an edit command.
                        " "$VIM/syntax" is where the syntax files are.
  set report=0          " show a report when N lines were changed.
                        " report=0 thus means "show all changes"!
  set ruler             " show cursor position?  Yep!

  set sessionoptions=curdir,folds,options,resize,winsize,globals

" Setting the "shell" is always tricky - especially when you are
" trying to use the same vimrc on different operating systems.
" Now that vim-5 has ":if" I am trying to automate the setting:
" Look in _vimrc_nix | _vimrc_win
"  if has("unix")
"    let shell='tcsh'
"  endif
"

  set shiftwidth=4      " Number of spaces to use for each insertion of
                        " (auto)indent.
  set shortmess=at      " Kind of messages to show.   Abbreviate them all!
                        " New since vim-5.0v: flag 'I' to suppress "intro
                        " message".
  set showcmd           " Show current uncompleted command?  Absolutely!
  set showmatch         " Show the matching bracket for the last ')'?
  set showmode          " Show the current mode?  YEEEEEEEEESSSSSSSSSSS!
  set suffixes=.bak,.swp,.o,~,.class,.exe,.obj,.a
                        " Suffixes to ignore in file completion, see wildignore
  set switchbuf=useopen,split " test!
                        " :cnext, :make uses thefirst open windows that
                        " contains the specified buffer
  set tabstop=8         " tabstop
" set term=rxvt
  set textwidth=72      " textwidth
  set title             " Permet de voir le tit. du doc. crt. ds les XTERM
  " set nottyfast         " are we using a fast terminal?
                        " seting depends on where I use Vim...
  " set nottybuiltin      "
  " set ttyscroll=0       " turn off scrolling -> faster!
" set ttytype=rxvt

  if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
  endif

  set viminfo='50,<100,:1000,n~/.viminfo
                        " What info to store from an editing session
                        " in the viminfo file;  can be used at next session.
  set visualbell        "
  set t_vb=             " terminal's visual bell - turned off to make Vim quiet!
  set whichwrap=<,>     "
  set wildchar=<TAB>    " the char used for "expansion" on the command line
                        " default value is "<C-E>" but I prefer the tab key:
  set wildignore=*.bak,*.swp,*.o,*~,*.class,*.exe,*.obj,/CVS/,/.svn/,/.git/,*.so,*.a,*.lo,*.la,*.Plo,*.Po,*.gcno,*.gcda
  set wildmenu          " Completion on th command line shows a menu
  set winminheight=0    " Minimum height of VIM's windows opened
  set wrapmargin=1
  set nowritebackup

  set cpoptions-=C      " enable commands that continue on the next line

  if 0
    " Is there a tags file? If so I'd like to use it's absolute path in case we
    " chdir later
    if filereadable("tags")
      " exec "set tags+=" . $PWD . "/tags"
      " $PWD => problem is there are spaces within the path name
      exec "set tags+=" . escape(expand('%:p:h'),' ') . "/tags"
    endif
  endif

" Multi-byte support {{{2
" Force utf-8 on windows in order to have airline display nice characters
if has('windows') && has('multi_byte')
  set enc=utf-8
endif
" Cf. http://vim.sourceforge.net/tips/tip.php?tip_id=246 by Tony Mechelynck
if &encoding == 'utf-8'
    setglobal fileencoding=utf-8
    " set bomb
    " set termencoding=iso-8859-15
    " set termencoding=latin2
    set fileencodings=ucs-bom,utf-8,iso-8859-15
    set nodigraph
endif

if 0
  if 0 && has("multi_byte") && (version >= 602)
    " \ && (confirm("change encoding -> utf-8", "&Yes\n&No", 2)==1)
    set encoding=utf-8
    " set encoding=latin2
    " setglobal fileencoding=latin2
    setglobal fileencoding=utf-8
    set bomb
    set termencoding=iso-8859-15
    " set termencoding=latin2
    set fileencodings=ucs-bom,iso-8859-15,iso-8859-3,utf-8
  else
    " set encoding=iso-8859-15
    set encoding=latin1
    set termencoding=iso-8859-15
    " set fileencodings=ucs-bom,iso-8859-15,iso-8859-3,utf-8
  endif
endif

" Diff mode {{{2
" always
  set diffopt=filler,context:3,iwhite,hiddenoff
  if has('nvim-0.3.2') || has("patch-8.1.0360")
    " https://old.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim/
    set diffopt+=internal,algorithm:histogram,indent-heuristic
  endif
  " if $OSTYPE != 'solaris' " some flavour of diff do not support -x flag
    " let g:DirDiffExcludes='CVS,*.o,*.so,*.a,svn,.*.swp'
  " endif
" if &diff " if started in diff mode
" endif
" }}}1
" ===================================================================
" MAPpings {{{1
" ===================================================================
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
"
" -------------------------------------------------------------------
" Adjustments {{{
" -------------------------------------------------------------------
:VimrcHelp " ¤iz : work on current fold (viz, diz, yiz...)
  onoremap iz :<c-u>normal! [zV]z<cr>
  xnoremap iz [zo]z

" Don't use Ex mode, use Q for formatting
:VimrcHelp " Q : formatting key
  nnoremap Q gq
  xnoremap Q gq
  nnoremap gQ Q         " Garde le mode EX disponible
  xnoremap gQ Q         " Garde le mode EX disponible
"
:VimrcHelp " Y : yank till the end of the line
  nnoremap Y y$
  xnoremap Y y$
" Disable the command 'K' (keyword lookup) by mapping it
" to an "empty command".  (thanks, Lawrence! :-):
" map K :<CR>
" map K :<BS>
"
:VimrcHelp "  Disable the suspend for ^Z ; call shell
" I use Vim under "screen" where a suspend would lose the
" connection to the " terminal - which is what I want to avoid.
  nnoremap <C-Z> :<c-u>shell
"
:VimrcHelp " Make CTRL-^ rebound to the *column* in the previous file
  noremap <C-^> <C-^>`"
"
:VimrcHelp " Make 'gf' rebound to last cursor position (line *and* column)
  nnoremap gf gf`"
  xnoremap gf gf`"
"
:VimrcHelp " The command {number}CTRL-G show the current buffer number, too.
" This is yet another feature that vi does not have.
" As I always want to see the buffer number I map it to CTRL-G.
" Please note that here we need to prevent a loop in the mapping by
" using the comamnd "noremap"!
  nnoremap <C-G> 2<C-G>

:VimrcHelp " backspace in Visual mode deletes selection
  xnoremap <BS> d
  snoremap <BS> <c-g>di
  nnoremap <BS> X

:VimrcHelp " <C-Del> and <C-S-Del> Delete a whole word till its end            [I+N]
   noremap <C-Del> dw
   noremap <C-S-Del> dW
  inoremap <C-Del> <space><esc>ce
  inoremap <C-S-Del> <esc>lcW

:VimrcHelp " <leader><up>/<down> Move line up and down [N+X]
  nnoremap <leader><up>   :<c-u>move-2<cr>==
  nnoremap <leader><down> :<c-u>move+<cr>==
  xnoremap <leader><up>   :move-2<cr>='[gv
  xnoremap <leader><down> :move'>+<cr>='[gv

" By default, <CR> will delete spaces before the cursor when hit => to keep
" trailling whitespaces to a minimum
" It can be neutralized with (bpg):trim_trailing_whitespace
function! s:trim_ws_on_the_fly()
  let line = getline('.')
  " TODO: set and reset &bs
  if line =~ '^\s*$'
    let nb = (virtcol('.') + 2*&sw-2) / &sw - 1
    " echomsg "remove "virtcol('.').'/'.&sw.' -> '.nb
  else
    let nb = len(matchstr(line[: col('.')-2], '\s*$'))
    let line = ''
  endif
  return repeat("\<bs>", nb)."\<cr>".line
endfunction
" inoremap <expr> <cr> lh#ft#option#get('trim_trailing_whitespace', &ft, 1)?<sid>trim_ws_on_the_fly():"<cr>"
" inoremap <expr> <cr> lh#ft#option#get('trim_trailing_whitespace', &ft, 1)?repeat("<bs>", len(matchstr(getline('.')[: col('.')-2], '\S\zs\s*$')))."<cr>":"<cr>"
" inoremap <expr> <cr> lh#ft#option#get('trim_trailing_whitespace', &ft, 1)?repeat("<bs>", len(matchstr(getline('.')[: col('.')-2], '\s*$')))."<cr>":"<cr>"

" "Fix" search direction
" 1. ";" is always forward, and "," always backward
if exists('*getcharsearch')
  nnoremap <expr> ; ',;'[getcharsearch().forward]
  nnoremap <expr> , ';,'[getcharsearch().forward]
endif
" 2. "n" is always forward, and "N" always backward
if exists('v:searchforward')
  nnoremap <expr> n 'Nn'[v:searchforward]
  nnoremap <expr> N 'nN'[v:searchforward]
endif

nnoremap <S-right> v<right>
inoremap <S-right> <c-o>v
vnoremap <S-right> <right>

nnoremap <S-left> v<left>
inoremap <S-left> <left><c-o>v
vnoremap <S-left> <left>

nnoremap <S-down> v<down>
inoremap <S-down> <c-o>v<down>
vnoremap <S-down> <down>

nnoremap <S-up> v<up>
inoremap <S-up> <c-o>vho<up>
vnoremap <S-up> <up>

" Non :*noremap-ings because of the dependency to homeLikeVC++.vim that maps
" <home>
nmap <S-home> v<home>
imap <S-home> <c-\><c-n>vo<home>
vmap <S-home> <home>

nmap <S-end> v<end>
" imap <S-end> <c-\><c-n>v<end>
imap <S-end> <c-o>v<end>
vmap <S-end> <end>

" }}}
" -------------------------------------------------------------------
" Customizing the command line {{{
" -------------------------------------------------------------------
" See also plugin/cmdline-motions.vim

" Insert the path of the current file
cnoremap <expr> <c-r>< expand('%:h').'/'

" Searching while something is selected will restrict the search to the
" current selection
xnoremap / <esc>/\\%V
" }}}
" -------------------------------------------------------------------
" My Customs mappings, windows, F-keys, etc {{{
" -------------------------------------------------------------------
"
if has("unix")
  " so $VIM/_vimrc_nix
  source <sfile>:p:h/_vimrc_nix
elseif has("win32")
  source <sfile>:p:h/_vimrc_win
endif
"
:VimrcHelp "
:VimrcHelp " <S-F1>  : Display this help                                       [N]
"
:VimrcHelp " <C-s>   : Save a file                                             [I+N]
  nnoremap <C-s> :<c-u>update<CR>
  inoremap <C-s> <c-o>:update<CR>
  vnoremap <C-s> <c-c>:update<CR>gv
"
:VimrcHelp " <F2>    : Save a file                                             [I+N]
  nnoremap <F2> :<c-u>update<CR>
  inoremap <F2> <c-o>:update<CR>
  vnoremap <F2> <c-c>:update<CR>gv
"
" ---------------------------------
" Abbrebiations pour ecrire francais
"
""so $VIMRUNTIME/../macros/words_tools.vim
""so $VIMRUNTIME/../macros/Triggers.vim
""Runtime plugin/fr-abbr.vim
""call Trigger_Function('<F3>', 'FRabbrInit',
""  \                     expand('$VIM/settings/fr-abbr.vim') )
:VimrcHelp " <F3>    : Activates or desactivates mappings for french edition   [I+N]
:VimrcHelp " <C-F3>  : Reloads the French mappings dictionary                  [N]
:VimrcHelp " <S-F3>  : Split-open the French mappings dictionary               [N]
" ---------------------------------
"
:VimrcHelp " <F4>    : run grep                                                [N]
:VimrcHelp " <F5>    : toggle winaltkeys option                                [N]
   set winaltkeys=no
   """TODO: use lh#menu#def_toggle
   ""    map <F5> ]!wakyes!
   ""noremap ]!wakyes! :map <F5> ]!wakmenu!<CR>:set winaltkeys=yes<CR>
   ""noremap ]!wakmenu! :map <F5> ]!wakno!<CR>:set winaltkeys=menu<CR>
   ""noremap ]!wakno! :map <F5> ]!wakyes!<CR>:set winaltkeys=no<CR>
"
:VimrcHelp " <F6>    : capitalize the previous/current word                    [I+N]
 inoremap <F6> <c-o>gUiw
 nnoremap <F6> gUiw
 xnoremap <F6> gUiw
 inoremap <S-F6> <c-o>gUiW
 nnoremap <S-F6> gUiW
 xnoremap <S-F6> gUiW

 inoremap <C-F6> <c-o>guiw
 nnoremap <C-F6> guiw
 xnoremap <C-F6> guiw
 inoremap <C-S-F6> <c-o>guiW
 nnoremap <C-S-F6> guiW
 xnoremap <C-S-F6> guiW
"
:VimrcHelp " <F7>    : toggle autoindent                                       [I+N]
   set ai
if ! empty(maparg('<F7>'))
   nnoremap <F7> :<c-u>set ai!<CR>:set ai?<CR>
      imap <F7> <c-o><F7>
endif
"
:VimrcHelp " <F9>    : toggle on and off the bracketing shortcuts              [I+N]
:VimrcHelp " <M-F9>  : toggle on and off the use of markers with «brackets»    [I+N]
"
:VimrcHelp " <F10>   : EXIT                                                    [I+N]
:VimrcHelp " <S-F10> : EXIT!                                                   [I+N]
  inoremap <F10> <esc>:q<cr>
  nnoremap <F10> :<c-u>q<cr>
  inoremap <S-F10> <esc>:q!<cr>
  nnoremap <S-F10> :<c-u>q!<cr>
"
:VimrcHelp " <F11>   : Previous Buffer                                         [I+N]
  inoremap <F11> <esc>:bprev<CR>
  "nnoremap <expr> <F11> (&ft=='qf' ? ":colder" : ":bprev")."\<cr>"
:VimrcHelp " <F12>   : Next Buffer                                             [I+N]
  inoremap <F12> <esc>:bnext<CR>
  "nnoremap <expr> <F12> (&ft=='qf' ? ":cnewer" : ":bnext")."\<cr>"
"
:VimrcHelp " <M-PageUp> and <M-PageDown> Go to the next/previous windows and maximize it
" And leave <C-PageUp> to do the default tab next and prev
   nnoremap <silent> <M-PageUp> <c-w>W<c-w>_
   nnoremap <silent> <M-PageDown> <c-w>w<c-w>_

:VimrcHelp " <T-PageUp> and <T-PageDown> Go to the next/previous tab
" And leave <C-PageUp> to do the default tab next and prev
   nnoremap <silent> <T-PageUp> gT
   nnoremap <silent> <T-PageDown> gt


   nnoremap <silent> <Plug>ShowSyntax
         \ :echo synIDattr(synID(line("."), col("."), 1), "name")<cr>
" }}}
" -------------------------------------------------------------------
" Tags Browsing macros {{{
:VimrcHelp " <M-Left> & <M-Right> works like in internet browers, but for tags [N]
nnoremap <M-Left> <C-T>
nnoremap <M-Right> :<c-u>tag<cr>
:VimrcHelp " <M-up> show the current tags stack                                [N]
nnoremap <M-Up> :<c-u>tags<cr>
:VimrcHelp " <M-down> go to the definition of the tag under the cursor         [N]
nnoremap <M-Down> <C-]>

nnoremap <M-C-Up> :<c-u>ts<cr>
nnoremap <M-C-Right> :<c-u>tn<cr>
nnoremap <M-C-Left> :<c-u>tp<cr>
" Tags Browsing }}}
" -------------------------------------------------------------------
" VIM - Editing and updating the vimrc: {{{
" As I often make changes to this file I use these commands
" to start editing it and also update it:
  let vimrc=expand('<sfile>:p')
:VimrcHelp '     ,vu = "update" by reading this file                           [N]
  nnoremap ,vu :<c-u>source <C-R>=vimrc<CR><CR>
:VimrcHelp "     ,ve = vimrc editing (edit this file)                          [N]
  nnoremap ,ve :<c-u>call <sid>OpenVimrc()<cr>

function! s:OpenVimrc()
  if empty(bufname('%')) && (1==line('$')) && empty(getline('$'))
    " edit in place
    exe "e ".g:vimrc
  else
    exe "sp ".g:vimrc
  endif
endfunction
" }}}
" -------------------------------------------------------------------
" Commands: {{{1
if ! exists(':Make')
  command! -nargs=* -complete=file Make cd %:p:h | make <args>
  command! -nargs=* -complete=file MAKE cd %:p:h | make <args>
endif
command! -nargs=0                CD     cd %:p:h
command! -nargs=0                LCD    lcd %:p:h
" http://vim.wikia.com/wiki/Reverse_selected_text
command! -bar -range=% Reverse <line1>,<line2>g/^/m<line1>-1

command! -nargs=? WTF call lh#exception#say_what(<f-args>)


" Recreate tmp directory used by vim
" Sometimes there is cron job that remove old entries in /tmp, when it happens
" on vim sessions that have been running for several days, it becomes
" impossible to run any external command.
" Contribution from Ben Schmidt on vim_use list.
" see also https://vi.stackexchange.com/a/17021/626
command! Mktmpdir call mkdir(fnamemodify(tempname(),":p:h"),"",0700)
" }}}
" -------------------------------------------------------------------
" }}}1
" ===================================================================
" General Editing {{{1
" ===================================================================
:VimrcHelp "
:VimrcHelp " ;rcm    = remove <C-M>s - for those mails sent from DOS:          [C]
  cmap ;rcm %s/<C-M>$//g
"
:VimrcHelp " ,Sws    = Make whitespace visible:                                [N+V]
"     Sws = show whitespace
  nmap ,Sws :<c-u>%s/ /_/g<C-M>
  xmap ,Sws :%s/ /_/g<C-M>
"
"     Sometimes you just want to *see* that trailing whitespace:
:VimrcHelp " Stws    = show trailing whitespace                                [N+V]
  nmap ,Stws :<c-u>%s/  *$/_/g<C-M>
  xmap ,Stws :%s/  *$/_/g<C-M>
"
" Inserting time stamps {{{
:VimrcHelp " ydate   = print the current date                                  [A+C]
  iab ydate <C-R>=lh#time#date()<cr>
  command! -nargs=0 Ydate @=lh#time#date()<cr>
:VimrcHelp " ,last   = updates the 'Last Update'
  nnoremap <silent> ,last gg
        \\|:silent let fdsave = &foldenable
        \\|:silent set nofoldenable
        \\|:silent if search('\clast \(changes\=\\|update\)\s*:\s*\zs')
        \\|:silent! normal "_Cydate<ESC>
        \\|:endif
        \\|:silent let &foldenable = fdsave<cr>
" <m-r> -> return
  inoremap <m-r> return
" }}}
"
" transforming a letter in lower case to a more open reg expr : o -> [oO]
:VimrcHelp " ,up     = o -> [oO]                                               [N]
 nnoremap ,up s[]<esc>PP~2<Right>

" -------------------------------------------------------------------
" General Editing - link to program "screen" {{{
" -------------------------------------------------------------------
"       ,Et = edit temporary file of "screen" program
  "map   ,Et :e /tmp/screen-exchange
" }}}
" -------------------------------------------------------------------
" Part 5 - Reformatting Text {{{
" -------------------------------------------------------------------
"
"  NOTE:  The following mapping require formatoptions to include 'r'
"    and "comments" to include "n:>" (ie "nested" comments with '>').
"
:VimrcHelp " ,b      = break line in commented text (to be used on a space)    [N]
" nmap ,b dwi<CR>> <ESC>
  nmap ,b r<CR>
:VimrcHelp " ,j = join line in commented text (can be used anywhere on the line)[N]
" nmap ,j Jxx
  nmap ,j Vjgq
"
:VimrcHelp " ,B      = break line at current position *and* join the next line [N]
" nmap ,B i<CR>><ESC>Jxx
  nmap ,B r<CR>Vjgq
"
:VimrcHelp " ,,,     = break current line at current column,
:VimrcHelp "           inserting ellipsis and «filling space»                  [N]
  nmap ,,,  ,,1,,2
  nmap ,,1  a...X...<ESC>FXr<CR>lmaky$o<CC-R>"<ESC>
  nmap ,,2  :<c-u>s/./ /g<C-M>3X0"yy$dd`a"yP

: VimrcHelp " [N],mc = move to col number [N]
  nnoremap ,mc :<c-u>call <sid>MoveToCol()<cr>

function! s:MoveToCol()
  let d = v:count - col('.')
  if d > 0
    exe 'normal! '.d."i \<esc>"
  endif
endfunction

" }}}
" -------------------------------------------------------------------
" Useful stuff.  At least these are nice examples.  :-) {{{
" -------------------------------------------------------------------
"
:VimrcHelp " yFILE/YFILE = insert the current filename (+ extension)           [A]
  iab   yFILE <C-R>=expand("%:t:r")<cr>
  iab   YFILE <C-R>=expand("%:t")<cr>
"
:VimrcHelp " ,|      : jump to the last space before the 80th column           [N]
  nnoremap ,\| 80\|F
  xnoremap ,\| 80\|F
"
"------ center the view on the current line
" :VimrcHelp "  ]].    : center the view on the current line                     [I]
   " nnoremap   ].      :<c-u>let vc=virtcol('.')<cr>z.:exe "normal! ".vc."\|"<cr>
   " inoremap     ]].      <c-o>zz
"
"----- place le curseur au de'but du mot (lettre) sous (ou avant) le curseur
   nnoremap      ]!wb!   ylpmz?\<[a-zA-Z_]<CR>mx`zx`x
   xnoremap      ]!wb!   ylpmz?\<[a-zA-Z_]<CR>mx`zx`x
"-----  place dans "y <count> fois le motif @x
"
"-----  Place N fois @x dans "y
"-----  Ne deplace pas le curseur
   nnoremap      ]!count!        i@x<esc>a <esc>BiX<esc>/@x<CR>"ydEhmzlBx`zx
   xnoremap      ]!count!        i@x<esc>a <esc>BiX<esc>/@x<CR>"ydEhmzlBx`zx
"
"------ supprime la ligne courante si elle ne contient que des blancs
"------ l'intervalle [  ] contient un espace et une tabulation
   nnoremap      ]!erase!        :.g/^[  ]*$/-j<CR>$
   xnoremap      ]!erase!        :.g/^[  ]*$/-j<CR>$
"
"------
" :VimrcHelp "  #      : toggle the 'number' option
"------
   set  nonu
   " noremap # :set nu!<CR>:set nu?<CR>
"
"------
:VimrcHelp "# q      : put # words between `quotes'
"------
   " map  q             ]!count!]!wb!mzi`e<esc>"xdlh@ya<c-v>'<esc>w
"
""------
":VimrcHelp "
":VimrcHelp "! @@   : inserts command's result before the cursor               [N]
":VimrcHelp "! @!   - inserts the result of the command that starts after @    [N]
""EX
""EX:   Nous sommes le date@@
""EX:   Nombre de mots du fichier : @wc -c %@!
""so $VIMRUNTIME/../macros/executer.vim
"------
"
:VimrcHelp " ,t      : transposes two characters: from aXb -> bXa              [N]
 nnoremap ,t XplxhhPl
" This macros shortened by one character by
" Preben Guldberg c928400@student.dtu.dk
" map ,t XpxphXp
" map ,t xphXpxp
"
" make space move the cursor to the right - much better than a *beep*
" nmap \  l
"
"     ,E = execute line
" map ,E 0/\$<CR>w"yy$:<C-R>y<C-A>r!<C-E>
" This command excutes a shell command from the current line and
" reads in its output into the buffer.  It assumes that the command
" starts with the fist word after the first '$' (the shell prompt
" of /bin/sh).  Try ",E" on that line, ie place the cursor on it
" and then press ",E":
" $ ls -la
" Note: The command line commands have been remapped to tcsh style!!
"
:VimrcHelp " ,rev    : invert lines order                                      [N+V]
" From the vim mailing list, Bob Hiestand's solution.
 xnoremap ,rev <esc>:execute "'<,'>g/^/m" line("'<")-1<cr>
 nnoremap ,rev :<c-u>execute "%g/^/m" 0<cr>
"
" :digraph oe 156
" :digraph OE 140

" }}}
"
" }}}1
" ===================================================================
" AutoCommands {{{1
" ===================================================================
"
" autocmd!
" -------------------------------------------------------------------
" Syntax files
" -------------------------------------------------------------------
" Toggle syntax coloring on/off with "__":
" nn __ mg:if has("syntax_items")<Bar>syn clear<CR>else<Bar>syn on<CR>en<CR>`g
" Note:  It works - but the screen flashes are quite annoying.  :-/
"

let g:ft_ignore_pat = 'lst'

" loads my own filetype definitions {{{
" let myfiletypefile = "$VIM/myfiletypes.vim"
let myfiletypefile = expand('<sfile>:p:h').'/myfiletypes.vim'
" }}}

" Switch syntax highlighting on, when the terminal has colors {{{
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  "set hlsearch " bof : don't like it => activation sur <F8>
  :VimrcHelp " <F8> activates or desactivates hight lighting on results from searchs
  set nohlsearch
  nnoremap <silent> <F8> :<c-u>set hlsearch!<bar>set hlsearch?<CR>
  imap     <silent> <F8> <c-o><F8>
  xmap     <silent> <F8> <c-\><c-n><F8>gv
  smap     <silent> <F8> <c-\><c-n><F8>gv<c-g>
endif
" }}}

" Only do this part when compiled with support for autocommands. {{{
if has("autocmd")
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78

    " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
    " back to positions in previous files more than once.
    if 0
      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    endif
  augroup END

  " Avoid qfwindow in :bnext & co
  augroup qf_no_bnext
    au!
    au FileType qf set nobuflisted
  augroup END

  ""source $VIMRUNTIME/settings/gz.set
endif " has("autocmd")
" }}}

runtime macros/matchit.vim
" }}}

" global variable used by Triggers.vim in order to determine if some echoing
" can be done or not yet.
augroup Triggers
  au VimEnter * :let g:loaded_vimrc = 1
augroup END
" As this must be done after the plugins are loaded, but before the very
" end of the vim initialization, this phase has been moved to the .gvimrc

" Folding {{{
" I use Johannes Zellner's way to do it, and some of his files
if has("autocmd") && has("folding")
    augroup folding
      au!
      au FileType * silent! runtime fold/<amatch>-fold.vim
      au FileType * if &foldmethod != 'manual'
      \ | set foldcolumn=1 | else | set foldcolumn=0 | endif
    augroup END
endif
" }}}

" }}}1
" ===================================================================
" Plugins {{{1
" ===================================================================
" Options for differents plugins. {{{2
let g:tex_flavor = 'tex'
" -- Mail_Re_set {{{3
let g:mail_tag_placement = "tag_second"
" -- EnhCommentify {{{3
let g:EnhCommentifyUseAltKeys     = "yes"
let g:EnhCommentifyRespectIndent  = "yes"
"let g:EnhCommentifyFirstLineMode = "yes"
let g:EnhCommentifyPretty         = "yes"
let g:EnhCommentifyUseSyntax      = 'yes'
let g:EnhCommentifyUseBlockIndent = 'yes'

" -- Michael Geddes's Buffer Menu <http://vim.sf.net/>  {{{3
let g:buffermenu_use_disable     = 1
let g:want_buffermenu_for_tex    = 2 " 0 : no, 1 : yes, 2 : global disable
                                     " cf. tex-maps.vim & texmenus.vim

" -- lhBrackets {{{3
let g:marker_select_empty_marks    = 1
let g:marker_center                = 0

" -- muTemplate {{{3
" To override in some ftplugins if required.
let g:url         = 'http://github.com/LucHermitte/«»'
let g:author_name = "Luc Hermitte"
let g:author_short= "Luc Hermitte"
let g:author_email= "luc {dot} hermitte {at} gmail {dot} com"
let g:author      = "Luc Hermitte <EMAIL:".g:author_email.">"
" let g:author_short="Luc Hermitte <hermitte at free.fr>"
" let g:author      ="Luc Hermitte <EMAIL:hermitte {at} free {dot} fr>\<c-m>" .
" \ '"'. "\<tab>\<tab><URL:http://github.com/LucHermitte>"
imap <c-s-space>  <Plug>MuT_ckword
vmap <c-space>  <Plug>MuT_Surround

" -- lh-tags {{{3
let g:tag_options = { 'no_auto': 0}

" -- latex-suite {{{3
let g:Tex_SmartKeyQuote = 0
let g:Tex_SmartKeyBS    = 0
let g:Tex_SmartKeyDot   = 1

" -- lhVimSpell {{{3
let g:VS_aspell_add_directly_to_dict = 1
let g:loaded_lhVimSpell = 'no'


" -- local vimrc {{{3
let g:local_vimrc = ['.config', '_vimrc_local.vim']

" -- lh-vim-lib#project {{{3
let g:lh#project = get(g:, 'lh#project', {})
let g:lh#project.auto_chdir  = get(g:lh#project, 'auto_chdir', 1)
let g:lh#project.auto_detect = get(g:lh#project, 'auto_detect', 1)

" -- BTW {{{3
let g:BTW = get(g:, 'BTW', {})
let g:BTW.qf_position = 'bot'
let g:BTW.autoscroll_background_compilation = 1
" let g:BTW.make_in_background = 1
" let g:BTW.make_multijobs = 1

" -- SearchInRuntime {{{3
let g:sir_goto_hsplit = "Hsplit"
let g:sir_goto_vsplit = "Vsplit"

" -- Mark.vim {{{3
" Prevent mark.vim to map anything to numpad keys
nmap <leader>sm1 <Plug>MarkSearchGroup1Next
nmap <leader>sm2 <Plug>MarkSearchGroup2Next
nmap <leader>sm3 <Plug>MarkSearchGroup3Next
nmap <leader>sm4 <Plug>MarkSearchGroup4Next
nmap <leader>sm5 <Plug>MarkSearchGroup5Next
nmap <leader>sm6 <Plug>MarkSearchGroup6Next
nmap <leader>sm7 <Plug>MarkSearchGroup7Next
nmap <leader>sm8 <Plug>MarkSearchGroup8Next
nmap <leader>sm9 <Plug>MarkSearchGroup9Next
let g:mwDefaultHighlightingPalette = 'maximum'

" -- Johannes Zellner's Man <http://www.zellner.org/> {{{3
let g:man_vim_only = 1

" -- Yegappan Lakshmanan's grep.vim <http://vim.sf.net/>  {{{3
let Grep_key = '<F4>'
if has('win32')
  " let       Grep_Path = 'd:/users/hermitte/bin/usr/local/wbin/grep'
  " let      Fgrep_Path = 'd:/users/hermitte/bin/usr/local/wbin/fgrep'
  " let      Egrep_Path = 'd:/users/hermitte/bin/usr/local/wbin/egrep'
  " let     Agrep_Path = 'd:/users/hermitte/bin/usr/local/wbin/agrep'
  " let  Grep_Find_Path = 'd:/users/hermitte/bin/usr/local/wbin/find'
  " let Grep_Xargs_Path = 'd:/users/hermitte/bin/usr/local/wbin/xargs'
endif

" -- grep.vim {{{3
let Grep_Key = ',g'

" -- Doxygen syntax {{{3
let g:load_doxygen_syntax = 1

" -- Dr Chip Campbell's StlShowFunc {{{3
hi User1 ctermfg=white ctermbg=black guifg=white guibg=black
hi User2 ctermfg=lightblue ctermbg=black guifg=lightblue guibg=black
hi User3 ctermfg=yellow ctermbg=black guifg=lightyellow guibg=black

" -- Dr Chip Campbell's hiLink {{{3
" don't map <S-F10>'
nmap <Leader>hlt <Plug>HiLinkTrace
xmap <Leader>hlt <Plug>HiLinkTrace

" -- William Lee's DirDiff {{{3
let g:DirDiffExcludes = '*.gz,*.bz2,*.7z,*.vba,*.rss,CVS,SunWS_cache,ir.out,.*.state,exe,bin,obj,*.o,*.os,tags,lib,.svn,.git,html,*.a,*.so'.&wildignore
let g:DirDiffIgnore   = '$Id,$Date'
let g:DirDiffAddArgs  = "-b"

" -- VCS commands.vim {{{3
let VCSCommandDisableMappings = 1
augroup VCSCommand
  au User VCSBufferCreated silent! nmap <unique> <buffer> q :<c-u>bwipeout<cr>
augroup END

" -- clang_indexer@lh {{{3
" Keybindings
let clang_key_usr          = '<c-x>U'
let clang_key_declarations = '<c-x>d'
let clang_key_references   = '<c-x>r'
let clang_key_subclases    = '<c-x>S'

" -- clang_complete {{{3
let g:clang_complete_auto = 0
" g:clang_library_path can be filled with `:call clang#libpath()`

set completeopt-=menu,preview
set completeopt+=menuone

" -- no mark ring/preview word {{{3
let g:loaded_markring = 1000
" imap <m-p> <Plug>PreviewWord
" nmap <m-p> <Plug>PreviewWord

" -- diffchar {{{3
nmap ]<f7> <Plug>ToggleDiffCharAll
nmap ]<f8> <Plug>ToggleDiffCharOneLine

" -- viewdoc {{{3
let g:viewdoc_open = "new"

" -- You Complete Me    {{{3
let g:ycm_key_invoke_completion    = '<C-S-Space>'
let g:ycm_key_detailed_diagnostics = '<C-X>d'
let g:ycm_server_log_level = 'debug'
let g:ycm_server_use_vim_stdout = 1

" -- Unite              {{{3
nnoremap <C-p> :<c-u>Unite file_rec/async<cr>
augroup LhUnite
  au!
  autocmd FileType unite call s:unite_my_settings()
augroup END
function! s:unite_my_settings()
  " Overwrite settings.
  imap <silent><buffer><expr> <CR> unite#do_action('split')
endfunction


" -- vim addons manager {{{3
let s:my_plugins = [
      \ 'lh-vim-lib'         ,
      \ 'local_vimrc'        ,
      \ 'lh-brackets'        ,
      \ 'build-tools-wrapper',
      \ 'lh-tags'            ,
      \ 'lh-dev'             ,
      \ 'mu-template@lh'     ,
      \ 'alternate-lite'     ,
      \ 'lh-cpp'             ,
      \ 'lh-refactor'        ,
      \ 'search-in-runtime'  ,
      \ 'system-tools'       ,
      \ 'UT'                 ,
      \ 'lh-compil-hints'    ,
      \ 'lh-misc'            ,
      \ 'lh-cmake'           ,
      \ 'dirdiff-svn'        ,
      \]

if has('pythonx')
  let s:my_plugins += ['vim-clang@lh']
endif

let g:vim_addon_manager = get(g:, 'vim_addon_manager', {})
let g:vim_addon_manager['plugin_sources'] = {}
let g:vim_addon_manager['plugin_sources']['vim-jira-complete'] = { 'type': 'git', 'url': 'ssh://ssh.github.com/LucHermitte/vim-jira-complete'}
let g:vim_addon_manager['scms'] = {
      \  'git': {'clone': ['VAM_git_proxy_checkout', []],
      \         'update': ['vam#utils#RunShell', ['cd $p && git pull'        ]],
      \          'wdrev': ['vam#utils#System',   ['git --git-dir=$p/.git rev-parse HEAD']],
      \            'log': ['vam#utils#System',   ['git --git-dir=$2p/.git log $1 $[3]..$[4]', '--pretty=format:%s%n']],
      \           'supports_shallow_clone': 'auto',
      \          }
      \ }

" TODO: check whether we still need this X() function thanks to VAM_git_proxy_checkout()
fun! X(plugin_sources, www_vim_org, scm_plugin_sources, patch_function, snr_to_name)
  " run default:
  call vam_known_repositories#MergeSources(a:plugin_sources, a:www_vim_org, a:scm_plugin_sources, a:patch_function, a:snr_to_name)

  " patch sources the way you like:
  let s:pwd = 'to_be_defined'
  if !exists('s:pwd')
    runtime addons/vim-pwds.vim
    let s:pwd = GetPwd('googlecode')
  endif
  let g:ps = a:plugin_sources
  for k in s:my_plugins
    let g:k = k
    if !has_key(a:plugin_sources, k)
      echomsg "plugin ".(k)." unknown to VAM"
      continue
    endif
    " echomsg a:plugin_sources[k]['url']
    if a:plugin_sources[k]['url'] =~ 'svn'
      let a:plugin_sources[k]['username'] = join(['luc.hermitte','gmail.com'], '@')
      let a:plugin_sources[k]['password'] = s:pwd
      let a:plugin_sources[k]['url'] = substitute(a:plugin_sources[k]['url'], '^http\>', 'https', '')
      let a:plugin_sources[k]['url'] = substitute(a:plugin_sources[k]['url'], 'git://\(repo.or.cz\)/\(.*\)','LucHermitte@\1:srv/git/\2', '')
    endif
    unlet k
  endfor
  " TODO: identify work place and not home place
  if $USERDOMAIN != 'TOPAZE'
    silent! unlet k
    for k in keys(a:plugin_sources)
      " Convert git protocol to SSH protocol for github access
      if get(a:plugin_sources[k],'type','') == 'git'
        if executable('corkscrew')
          " When accessing through a proxy with corkcrew
          let a:plugin_sources[k]['url'] = substitute(a:plugin_sources[k]['url'], 'git://\(github.com\)/\(.*\)', 'ssh://ssh.\1/\2', '')
          let a:plugin_sources[k]['url'] = substitute(a:plugin_sources[k]['url'], 'git@\(bitbucket.org\)[/:]\(.*\)', 'ssh://git@\1/\2', '')
        elseif exists('$https_proxy')
          let a:plugin_sources[k]['url'] = substitute(a:plugin_sources[k]['url'], 'git://\(github.com\)/\(.*\)', 'https://\1/\2', '')
          let a:plugin_sources[k]['url'] = substitute(a:plugin_sources[k]['url'], 'git@\(bitbucket.org\)[/:]\(.*\)', 'https://git@\1/\2', '')
        else
          " When every thing works
          let a:plugin_sources[k]['url'] = substitute(a:plugin_sources[k]['url'], 'git://\(github.com\)/\(.*\)', 'git@\1:\2', '')
        endif
      endif
    endfor
  endif
endf

function! VAM_git_proxy_checkout(repository, targetDir) abort
    " Convert git URL to something compatible with the proxy used
    call vam#Log(string(a:repository), 'None')
    " assert: a:repository.type == 'git'
    let url = a:repository.url
    if executable('corkscrew')
        " When accessing through a proxy with corkcrew
        let url = substitute(url, 'git://\(github.com\)/\(.*\)', 'ssh://ssh.\1/\2', '')
        let url = substitute(url, 'git@\(bitbucket.org\)[/:]\(.*\)', 'ssh://git@\1/\2', '')
    elseif (exists('$https_proxy') && !empty('$https_proxy')) || get(g:, 'VAM_force_https', 0)
        let url = substitute(url, 'git://\(github.com\)/\(.*\)', 'https://\1/\2', '')
        let url = substitute(url, 'git@\(bitbucket.org\)[/:]\(.*\)', 'https://git@\1/\2', '')
    else
        let url = substitute(url, 'git://\(github.com\)/\(.*\)', 'git@\1:\2', '')
    endif
    let a:repository.url = url

    call vam#Log('git repo for '.(a:repository.name).' used '.(a:repository.url), 'None')
    " TODO: handle filename escaping for windows...
    call vam#vcs#GitCheckoutFixDepth(a:repository, a:targetDir)
endfunction

" ===================================================================
" Load plugins {{{2
function! s:ActivateAddons()
  runtime addons/lh-vim-lib/autoload/lh/has.vim
  runtime addons/lh-vim-lib/autoload/lh/list.vim
  runtime addons/lh-vim-lib/autoload/lh/path.vim
  let vimfiles = lh#path#vimfiles()
  " echomsg "vimfiles: ".string(vimfiles)
  exe 'set rtp+='.fnameescape(vimfiles).'/addons/vim-addon-manager'
  " tell VAM to use your MergeSources function:
  let g:vim_addon_manager['MergeSources'] = function('X')
  " There should be no exception anyway
  " try
  " latex-suite stuff, only in run for latex
  if match(argv(), 'tex$') >= 0
    " call vam#ActivateAddons(['vim-latex'])
  endif
  " script #3361
  call vam#ActivateAddons(['Indent_Guides']) " not autoloaded
  call vam#ActivateAddons(['stakeholders'])
  call vam#ActivateAddons(['vcscommand']) " not autoloaded
  call vam#ActivateAddons(['Splice'])
  call vam#ActivateAddons(['fugitive']) " required by gitv
  call vam#ActivateAddons(['gitv'])
  call vam#ActivateAddons(['vim-addon-json-encoding'])
  call vam#ActivateAddons(['viewdoc'])
  call vam#ActivateAddons(['vim-airline'])
  call vam#ActivateAddons(['xmledit'])
  call vam#ActivateAddons(['github:rickhowe/diffchar.vim'])
  if has('pythonx')
    call vam#ActivateAddons(['github:5long/pytest-vim-compiler'])
  endif
  call vam#ActivateAddons(['github:inkarkat/vim-mark']) " Ingo Karkat's fork of mark.vim
  call vam#ActivateAddons(['github:inkarkat/vim-ingo-library']) " Ingo Karkat's dependency for mark.vim
  call vam#ActivateAddons(['editorconfig-vim']) " used to test my plugins
  call vam#ActivateAddons(['undotree'])
  if 0 && has('pythonx')
    call vam#ActivateAddons(['vim-jira-complete'])
  endif
  let g:airline_powerline_fonts = 1
  let g:airline_theme = 'lh_dark'
  " let g:airline_solarized_bg = 'dark'
  " call vam#ActivateAddons(['Syntastic'])
  " s:my_plugins is copied otherwise VAM will mutate its content
  call vam#ActivateAddons(copy(s:my_plugins), {'auto_install' : 0})
  " pluginA could be github:YourName see vam#install#RewriteName()
  " catch /.*/
  " echoe v:exception
  " endtry
  "
  " Unite stuff
  call vam#ActivateAddons(['unite', 'unite-locate', 'unite-outline', 'vimproc'])
  " COC
  if executable('node') && has("patch-8.0.1630")
    " Because CoC requires trim(), defined in Vim 8.0.1630
    call vam#ActivateAddons(['github:neoclide/coc.nvim'])
  endif

  " Impossible to make it work! :(
  " let g:vim_addon_manager['plugin_sources']['BreakPts@albfan'] = { 'type': 'git', 'url': 'git@github.com:albfan/BreakPts.git',
        " \ 'dependecies': {'genutils': g:vim_addon_manager['plugin_sources']['genutils']}}
  " call vam#ActivateAddons(['BreakPts@albfan', 'genutils'])
endfunction
call s:ActivateAddons()

"" Optionally generate helptags:
" UpdateAddon vim-addon-manager

" Options for plugins that relies on autoloaded functions {{{2
" -- xml edit {{{3
let g:xml_jump_string = lh#marker#txt()

" -- Machine specifics {{{3
"       Specific configuration for the current machine (i.e. where corporate
"       and personal projects are stored, ...). Used to configure local_vimrc
"       whitelists
runtime plugin/let.vim
runtime machine-specifics.vim
let g:guifontsize = 10
call lh#menu#def_toggle_item({'variable': 'guifontsize', 'values': [10, 26], 'hook': ':let &guifont="DejaVu Sans Mono for Powerline ".g:guifontsize', 'menu': {'priority': '500.2700.10', 'name': '&Plugin.&LH.&font'}})

" -- VimFold4C {{{3
LetTo g:fold_options.fallback_method.line_threshold = 500

" -- Python indent {{{3
" :h ft-python-indent
" What black usually enforces
LetTo g:python_indent.closed_paren_align_last_line = v:false
LetTo g:python_indent.continue = 'shiftwidth() * 2'

" -- BTW {{{3
LetIfUndef g:BTW.make_in_background = 1

" -- COC                {{{3
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

if !empty(globpath(&rtp, 'autoload/coc.vim'))
  function! s:coc_configure_and_start() abort
    let g:coc_user_config = {}
    let g:coc_user_config['suggest.noselect'] = v:true
    " let g:coc_user_config['suggest.enablePreselect'] = v:false
    let g:coc_user_config['coc.preferences.jumpCommand'] = ':SplitIfNotOpen4COC'
    " let g:coc_user_config['tsserver.trace.server'] = 'verbose'

    let g:coc_user_config['pyright.inlayHints.variableTypes'] = v:false
    " As &shellredir isn't set yet in the .vimrc (see :h starting), we need to
    " delay the execution of |system()| till after these options has been set.
    " That's where |VimEnter| autocommand helps.
    " Here, system() is indirectly called through lh#cpp#tags#compiler_includes()
    if executable('ccls') && executable('clang++')
      let g:coc_user_config['languageserver'] = {
            \ 'ccls': {
            \     'command': 'ccls',
            \     'filetypes': ['c', 'cpp', 'objc', 'objcpp'],
            \     'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/'] + g:local_vimrc + g:lh#project.root_patterns,
            \     'initializationOptions': {
            \         'cache': {'directory': lh#option#get('lh.tmpdir', lh#string#or($TMPDIR, '/tmp'))},
            \         'index': {'threads': 2},
            \         'clang': {'extraArgs': map(copy(lh#cpp#tags#compiler_includes('clang++')), '"-isystem".v:val')}
            \         }
            \     }
            \ }
      " \     'args' : ['-log-file='.lh#option#get('lh.tmpdir', lh#string#or($TMPDIR, '/tmp')).'/ccls.log','-v=1'],
      " \     'trace.server': 'verbose',
    endif
    " Workaround bug 659 to launch gvim forked
    "   Required to permit gvim to fork on launch
    "   https://github.com/neoclide/coc.nvim/issues/659
    CocStart
  endfunction

  let g:coc_start_at_startup = 0
  augroup COCGroup
    autocmd!
    " Required to permit gvim to fork on launch
    " https://github.com/neoclide/coc.nvim/issues/659
    autocmd VimEnter * call s:coc_configure_and_start()
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

    " Highlight action triggers requests for a feature I'm not interreted in.
    " Moreover, it messes mark.vim
    " au CursorHold * sil call CocActionAsync('highlight')
    au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
  augroup end


  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
        " \ coc#pum#visible() ? coc#_select_confirm() :
  inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-n>"
  inoremap <expr> <C-N>   pumvisible() ? "\<C-p>" : "\<C-n>"
  inoremap <expr> <C-P>   pumvisible() ? "\<C-n>" : "\<C-p>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
  endfunction

  " Use <C-Space> to trigger completion.
  " <c-s-space> is used by mu-template
  inoremap <silent><expr> <C-space> coc#refresh()

  """ Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
  """ Coc only does snippet and additional edit on confirm.
  function! s:coc_cr() abort
    " Option 1: condensed
    return coc#pum#visible() && coc#pum#info().index >= 0 ? coc#_select_confirm()
          \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " Option 2: to debug
    let g:debug_last_cr = {}
    if coc#pum#visible()
      let info = coc#pum#info()
      let has_selected = info.index >= 0
      let g:debug_last_cr["info"] = info
      let g:debug_last_cr["has_selected"] = has_selected
      if !has_selected
        return "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
      else
        return coc#_select_confirm()
      endif
    else
      return "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    endif
  endfunction
  inoremap <silent><expr> <Plug>VimrcCR <sid>coc_cr()
  imap <silent> <cr> <Plug>VimrcCR
  " TODO: check how it's would interact with lh-brackets (add newline
  " between brackets)... it seems OK

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  let s:coc_prio = '500.120.'
  let s:coc_menu = '&Plugin.&COC.'

  " Remap keys for gotos
  call lh#menu#make('n', s:coc_prio.'10', s:coc_menu.'&Goto Definition',     'gd',  '<Plug>(coc-definition)')
  call lh#menu#make('n', s:coc_prio.'20', s:coc_menu.'T&ype Definition',     '<leader>gt',  '<Plug>(coc-type-definition)')
  call lh#menu#make('n', s:coc_prio.'30', s:coc_menu.'Goto &Implementation', '<leader>gi',  '<Plug>(coc-implementation)')
  call lh#menu#make('n', s:coc_prio.'40', s:coc_menu.'Goto &References',     '<leader>gr',  '<Plug>(coc-references)')
  amenu 50.120.99 &Plugin.&COC.--<sep>-- <Nop>

  " Use K to show documentation in preview window
  nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  " autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  call lh#menu#make('n', s:coc_prio.'100', s:coc_menu.'Re&Name',            '<leader>xr',  '<Plug>(coc-rename)')

  " Remap for format selected region
  call lh#menu#make('xn', s:coc_prio.'110', s:coc_menu.'&Format selection', '<leader>f',  '<Plug>(coc-format-selected)')

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  call lh#menu#make('xn', s:coc_prio.'120', s:coc_menu.'Code &Action on selection',   '<leader>xa',  '<Plug>(coc-codeaction-selected)')

  " Remap for do codeAction of current line
  call lh#menu#make('n', s:coc_prio.'130', s:coc_menu.'Code &Action on current line', '<leader>xal',  '<Plug>(coc-codeaction)')
  " Fix autofix problem of current line
  call lh#menu#make('n', s:coc_prio.'140', s:coc_menu.'Auto Fi&x current line',       '<leader>xqf',  '<Plug>(coc-fix-current)')

  amenu 50.120.199 &Plugin.&COC.---<sep>--- <Nop>
  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold   :call CocAction('fold', <f-args>)

  " Add diagnostic info for https://github.com/itchyny/lightline.vim
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'cocstatus': 'coc#status'
        \ },
        \ }

  let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

  " Using CocList
  " Show all diagnostics
  call lh#menu#make('n', s:coc_prio.'200', s:coc_menu.'Show all &Diagnostic',                '<leader>ca',  ':<C-u>CocList diagnostics<cr>')
  " Manage extensions
  call lh#menu#make('n', s:coc_prio.'210', s:coc_menu.'&Manage extensions',                  '<leader>ce',  ':<C-u>CocList extensions<cr>')
  " Show commands
  call lh#menu#make('n', s:coc_prio.'220', s:coc_menu.'Show Commands',                       '<leader>cc',  ':<C-u>CocList commands<cr>')
  " Find symbol of current document
  call lh#menu#make('n', s:coc_prio.'230', s:coc_menu.'Show &Outline',                       '<leader>cO',  ':<C-u>CocList outline<cr>')
  " Search workspace symbols
  call lh#menu#make('n', s:coc_prio.'240', s:coc_menu.'Search Workspace &Symbols',           '<leader>cs',  ':<C-u>CocList -I symbols<cr>')
  " Do default action for next item.
  call lh#menu#make('n', s:coc_prio.'250', s:coc_menu.'Do default action for next item',     '<leader>cdn',  ':<C-u>CocNext<cr>')
  " Do default action for previous item.
  call lh#menu#make('n', s:coc_prio.'260', s:coc_menu.'Do default action for previous item', '<leader>cdp',  ':<C-u>CocPrev<CR>')
  " Resume latest coc list
  call lh#menu#make('n', s:coc_prio.'270', s:coc_menu.'Resume latest coc list',              '<leader>cr',  ':<C-u>CocListResume<CR>')

  if executable('ccls') && executable('clang++')
    " # Playing with the API...
    " :let cclsid = filter(lh#list#get(CocAction('services'), 'id'), 'v:val =~ "ccls"')[0]
    " :let symbols = CocRequest(cclsid, 'workspace/symbol', {'query': 'apattern'})
    " -> returns a list of definitions and declarations mathing the pattern
    " see https://microsoft.github.io/language-server-protocol/specification#workspace_symbol
    " and for symbol kinds: https://microsoft.github.io/language-server-protocol/specification#textDocument_documentSymbol
    "
    " :echo CocRequest(cclsid, 'textDocument/documentSymbol', {'textDocument': {'uri': 'file://'.expand('%:p')} })
    " -> lists all symbols defined in the current document
    " --> Alas it doesn't permit to extract scopes/contexts (classes, namespaces, functions...)
    " see https://microsoft.github.io/language-server-protocol/specification#textDocument_documentSymbol
    "
    " :echo CocRequest(cclsid, 'textDocument/definition', {'textDocument': {'uri': 'file://'.expand('%:p')}, 'posision':{'line':line('.')-1,'character': col('.')-1}})
    " -> should return where the symbol under the cursor is defined.
    "    But I cannot make it work!!!
    " see https://microsoft.github.io/language-server-protocol/specification#textDocument_definition
    "
    " However if :Check is a command that stores its `<f-args>` the following
    " permits to extract where the symbol is defined
    " :call CocAction('jumpDefinition', 'Check')
    "
    " # $ccls/navigate
    "   Semantic navigation. Roughly,
    "   D" => first child declaration "L" => previous declaration "R" => next declaration "U" => parent declaration
    "   TODO: move to ftplugin
    " nn <silent><buffer> <C-l> :call CocLocations('ccls','$ccls/navigate',{'direction':'D'})<cr>
    " nn <silent><buffer> <C-k> :call CocLocations('ccls','$ccls/navigate',{'direction':'L'})<cr>
    " nn <silent><buffer> <C-j> :call CocLocations('ccls','$ccls/navigate',{'direction':'R'})<cr>
    " nn <silent><buffer> <C-h> :call CocLocations('ccls','$ccls/navigate',{'direction':'U'})<cr>
    "
    " # Cross reference extensions
    function! s:coc_bind_colocate(key, prio, text, what, ...) abort
      " Evaluate all functions now
      " let a000 = map(deepcopy(a:000), {k0,v0 -> string(map(v0, { k, v -> type(v)==2 ? v() : v}))})
      " let arg = join([string('$ccls/'.a:what)] + a000, ', ')
      let arg = string('$ccls/'.a:what)
      for a in a:000
        call lh#assert#type(a).is({})
        let arg .= ', {'
        let args = []
        for [k,l:V] in items(a)
          " Little trick to inject v:count that shall not be evaluated
          " yet -> It's passed through a lambda
          let args += [string(k).': '.(type(l:V)==type(function('has')) ? l:V() : string(l:V))]
        endfor
        let arg .= join(args, ', ') . '}'
      endfor
      call lh#menu#make('n', s:coc_prio.a:prio, s:coc_menu.a:text, a:key, ':<c-u>call CocLocations("ccls", '.arg.')<cr>')
    endfunction

    " ccls/vars ccls/base ccls/derived ccls/members have a parameter while others are interactive.
    " (ccls/base 1) direct bases
    " (ccls/derived 1) direct derived
    " (ccls/member 2) => 2 (Type) => nested classes / types in a namespace
    " (ccls/member 3) => 3 (Func) => member functions / functions in a namespace
    " (ccls/member 0) => member variables / variables in a namespace
    " (ccls/vars 1) => field
    " (ccls/vars 2) => local variable
    " (ccls/vars 3) => field or local variable. 3 = 1 | 2
    " (ccls/vars 4) => parameter
    "
    " Bases & Children
    amenu 50.120.299 &Plugin.&COC.----<sep>---- <Nop>
    call s:coc_bind_colocate('<leader>gb', '300', 'Direct base class (count=1 level)', 'inheritance', {'levels': {-> 'v:count1'}})
    call s:coc_bind_colocate('<leader>gB', '310', 'Base classes up to 3 levels',       'inheritance', {'levels': 3})
    call s:coc_bind_colocate('<leader>gd', '320', 'Derived class (count=1 level)',     'inheritance', {'derived': v:true, 'levels': {-> 'v:count1'}})
    call s:coc_bind_colocate('<leader>gD', '330', 'Derived classes ut to 3 levels',    'inheritance', {'derived': v:true, 'levels': 3})

    " caller/callee
    call s:coc_bind_colocate('<leader>gc', '340', 'Caller', 'call')
    call s:coc_bind_colocate('<leader>gC', '350', 'Callee', 'call', {'callee': v:true})

    " $ccls/member
    " member variables / variables in a namespace
    call s:coc_bind_colocate('<leader>gm', '350', 'Variables (member/namespace)',  'member')
    call s:coc_bind_colocate('<leader>gf', '360', 'Functions (member/namespace)',  'member', {'kind': 3})
    call s:coc_bind_colocate('<leader>gs', '370', 'Nested classes (/types in ns)', 'member', {'kind': 2})

    call s:coc_bind_colocate('<leader>gv', '380', 'Variables',  'vars')
    call s:coc_bind_colocate('<leader>gV', '390', 'Variables (fields)',  'vars', {'kind': 1})
    call s:coc_bind_colocate('<leader>gP', '400', 'Parameters',  'vars', {'kind': 4})

    " Inject in coc/ccls settings:
    " - clangs system paths (dynamic)
    " - SplitIfNotOpen4COC (done earlier)
  endif
endif

" }}}1
" ===================================================================
" vim600: set fdm=marker:
