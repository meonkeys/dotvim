" Init / Plugins {{{1

set nocompatible
filetype off " required by Vundle

" set up Vundle
set runtimepath+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'

" Vundle-managed plugins
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'honza/vim-snippets'
Plugin 'jamessan/vim-gnupg'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'elzr/vim-json'
Plugin 'Slava/vim-spacebars'
Plugin 'marijnh/tern_for_vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'chrisbra/csv.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
Plugin 'shumphrey/fugitive-gitlab.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/nginx.vim'

" Fix leader for VimOutliner files. Not sure why this is necessary.
let maplocalleader=",,"
Plugin 'vimoutliner/vimoutliner'
Plugin 'wincent/Command-T'

call vundle#end() " required by Vundle
filetype plugin indent on " required by Vundle

" General options {{{1

" These are in alphabetical order, except that the characters 'no' are ignored
" if they appear at the beginning of an option name.
set autoindent
set background=light
set backspace=indent,eol,start    " allow backspace over anything in insert mode
set nocompatible

" comments option settings from http://stripey.com/vim/vimrc.html
" lots of other great help at http://stripey.com/vim/

" get rid of the default style of C comments; define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::

set completeopt=menuone,preview
set dictionary+=/usr/share/dict/words
set expandtab
" automatically resize open windows
set equalalways
set foldlevelstart=99
set history=500
set hlsearch
set ignorecase
set incsearch
" from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
set listchars=tab:··,trail:·,eol:¶
set nolist
set matchtime=2
set matchpairs=(:),{:},[:],<:>
set mousemodel=popup
set nojoinspaces
set nonumber
" see :help 'statusline' for format of printheader (note spaces need escaping)
set printheader=%<%f\ %y%=Adam\ Monsen\ \ --\ \ Page\ %N\ (%P)
"set printheader=%<%f\ %y%=Page\ %N\ (%P)
set printoptions=paper:letter,duplex:off,number:n,left:10mm,portrait:y
" good settings for XML
"set printoptions=paper:letter,duplex:off,number:n,left:10mm,portrait:n,header:0
set ruler
set shiftround
set showcmd        " display incomplete commands
set showfulltag    " show prototype when completing words using tags file
set showmatch
set smarttab
set smartindent
set shiftwidth=2
set nostartofline
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.class
set tabstop=2
set title
set ttyfast        " we have a fast terminal connection
set ttyscroll=3
if version >= 703
    set undofile
endif
set visualbell
set virtualedit=
set wildmenu
set wildmode=list:longest

let g:netrw_list_hide='^\.[^.]\+'

" Functions {{{1

" F8 is my magic color switcher...
" toggles syntax highlighting for light/dark backgrounds
function s:Swapcolor()
    if exists("g:syntax_on")
        syntax off
    else
        " see eval.txt in the vim helpfiles...
        " &background checks the background option
        if     &background == 'light'
            set background=dark
        elseif &background == 'dark'
            set background=light
        endif
        syntax on
    endif
endfunction

" Bracketed paste mode

if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

" Key Mappings {{{1

set pastetoggle=<F2>
map <F3> :set number!<CR>
map <F4> :set wrap!<CR>
map <F5> :set list!<CR>
nmap <F6> :make<CR>
" map F8 to switch on and off syntax highlighting
map <F8> :call <SID>Swapcolor()<CR>
" gf usually just opens the file in the same window
nmap gf :split <cfile><CR>
" throw in the date, ala [ Sun Sep 26 22:41:43 PDT 2004 ]
nmap <Leader>dt a[<Esc>:r !date<CR>kJ$a ]<Esc>
" Use K to grep word under cursor and open all matches in a quickfix window.
" Requires Tim Pope's Fugitive plugin (installed above).
" see http://robots.thoughtbot.com/faster-grepping-in-vim
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

" Language-specific settings {{{1

" Simple filetype detection {{{2
autocmd BufRead,BufNewFile *inputrc setfiletype readline
autocmd BufNewFile,Bufread mig.cf setfiletype html
autocmd BufNewFile,Bufread *.jad setfiletype java
autocmd BufNewFile,Bufread *.jspf setfiletype jsp
" cause javaclassfile.vim ftplugin to be executed, which uses jad
" to decompile and display on the fly
autocmd BufNewFile,Bufread *.class setfiletype javaclassfile
" autocmd BufNewFile *.pl 0r ~/.vim/templates/newperlfile
autocmd BufRead,BufNewFile Rakefile setfiletype ruby
autocmd BufRead,BufNewFile *.rhtml setfiletype eruby
" FreeMarker
autocmd BufNewFile,BufRead *.ftl setfiletype ftl
" zipped files w/o .zip extension (see :he zip-extension)
au BufReadCmd *.jar,*.xpi,*.prpt call zip#Browse(expand("<amatch>"))
au BufNewFile,BufRead *.t2t setfiletype txt2tags
au BufNewFile,BufRead *.gradle setfiletype groovy
" since I probably want to email around plain-text recipes
au BufNewFile,BufRead */personal/ref/recipes/* setfiletype mail
au FileType tags set noexpandtab nosmarttab
au BufNewFile,BufRead ~/.gvfs/* set noswapfile
au BufNewFile,BufRead */bv-secrets/pwd* set noexpandtab nosmarttab
au BufNewFile,BufRead /var/log/apache* setfiletype apachelog
au BufNewFile,BufRead /etc/my.cnf setfiletype dosini
au BufNewFile,BufRead *.twig setfiletype twig
au BufNewFile,BufRead deps setfiletype dosini

" Complex filetype adaptations {{{2
" some C shortcuts
autocmd FileType c call <SID>CProgSettings()
function s:CProgSettings()
  if exists("g:loaded_prog_settings")
      return
  endif

  set foldmethod=syntax
  setlocal cscopequickfix=s-,c-,d-,i-,t-,e-
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
      setlocal cscopetag
  " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
      setlocal cscopetag
  endif
  setlocal csverb
  " from http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
  function s:SwitchSourceHeader()
      if (expand ("%:t") == expand ("%:t:r") . ".c")
          find %:t:r.h
      else
          find %:t:r.c
      endif
  endfunction
  nmap ,s :call <SID>SwitchSourceHeader()<CR>
  let g:loaded_prog_settings = 1
endfunction
" for some reason this must be outside of CProgSettings()
"let g:c_space_errors = 1

" just happens to be the kind of assembly I'm editing lately.
" MIPS syntax script here: http://www.vim.org/scripts/script.php?script_id=2045
let g:asmsyntax = "mips"

" some C++ shortcuts
autocmd FileType cpp call <SID>CppProgSettings()
function s:CppProgSettings()
    if exists("g:loaded_prog_settings")
        return
    endif
    "set makeprg=g++\ -ansi\ -pedantic\ -Wall\ -g\ %
    " from http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
    function s:SwitchSourceHeader()
        if (expand ("%:t") == expand ("%:t:r") . ".cpp")
            find %:t:r.h
        else
            find %:t:r.cpp
        endif
    endfunction
    nmap ,s :call <SID>SwitchSourceHeader()<CR>
    let g:loaded_prog_settings = 1
endfunction

" Maven pom.xml files
autocmd BufRead,BufNewFile pom.xml call <SID>PomXmlSettings()
function s:PomXmlSettings()
    set tabstop=4 shiftwidth=4 expandtab smartindent
endfunction

" Vimoutliner
autocmd BufRead,BufNewFile *.otl call <SID>VimOutlinerSettings()
function s:VimOutlinerSettings()
    set filetype=vo_base
    set foldcolumn=0
    " Work around Vundle or whatever breaks VimOutliner stuff.
    source $HOME/.vim/bundle/vimoutliner/ftdetect/votl.vim
    source $HOME/.vim/bundle/vimoutliner/ftplugin/votl.vim
    source $HOME/.vim/bundle/vimoutliner/syntax/votl.vim
endfunction
autocmd FileType vo_base highlight Folded ctermfg=4

autocmd BufNewFile *.java call <SID>NewJavaFileTemplate()
function s:NewJavaFileTemplate()
    " inserts boilerplate code for a new Java file
    execute "normal iclass \<C-R>%\<C-W>\<C-W> {\<C-M>public static void main(String args[]) {\<C-M>}\<C-M>}\<C-C>kk"
endfunction

autocmd FileType java call <SID>JavaPrgSettings()
function s:JavaPrgSettings()
    iabbrev print System.out.println
    iabbrev warn System.err.println
    let g:java_highlight_java_lang_ids=1
    let g:java_highlight_debug=1
    " Disable // comment auto-insertion behavior
    " (from http://vimdoc.sourceforge.net/cgi-bin/vimfaq2html3.pl#27.7)
    set comments=sr:/*,mb:*,el:*/
endfunction

autocmd FileType python call <SID>PythonPrgSettings()
function s:PythonPrgSettings()
    set shiftwidth=4 tabstop=4 expandtab
    nmap <Leader>pd :!pydoc <cword><CR>
    "set makeprg=python\ -tt\ %
    " cindent seems to make comments on a new line stay on the current column
    " and this is what I want.
    set cindent
    set comments=:#
    " not in plugin dir because I rarely want folds
    "so ~/.vim/python_fold.vim
    nmap <Leader>pdb oimport pdb; pdb.set_trace()<Esc>
endfunction

autocmd FileType php call <SID>PhpPrgSettings()
function s:PhpPrgSettings()
    iab pdd ?><pre><?php print_r() ?></pre><?php <Esc>15hi
    iab udd <pre><?php print_r() ?></pre><Esc>9hi
    set indentexpr=
    set shiftwidth=4
    set tabstop=4
    set autoindent
    set smartindent
    set keywordprg=php_doc
endfunction

autocmd BufNewFile *.pl call <SID>SetupNewPerlFile()
function s:SetupNewPerlFile()
    execute "normal i#!/usr/bin/perl -w\<C-M>\<C-C>xiuse strict;\<C-M>\<C-C>xo"
endfunction

autocmd FileType perl call <SID>PerlProgSettings()
function s:PerlProgSettings()
    set cindent
    " perl comments start with #, anywhere on the line
    set comments=:#
    set cinkeys-=0#
    " If you want complex things like '@{${"foo"}}' to be parsed:
    let g:perl_extended_vars = 1
    let g:perl_sync_dist = 100
    " See ':help syntax'
    let g:perl_fold = 1
    set foldlevelstart=1
    " handy abbreviations
    iab udd use Data::Dumper; print Dumper ();<Esc>hi
    iab ddd use Data::Dumper; die Dumper ();<Esc>hi
    iab wdd use Data::Dumper; warn Dumper ();<Esc>hi
    set makeprg=perl\ -w\ %
    nmap <Leader>pf :!perldoc -f <cword><CR>
    nmap <Leader>pd :e `perldoc -ml <cword>`<CR>
endfunction

autocmd FileType xml call <SID>XMLFileSettings()
function s:XMLFileSettings()
    set foldmethod=syntax
    "use the left margin to show folds
    "set foldcolumn=8
    set foldlevel=1
endfunction

" Not in a FileType function like the other filetype-specific mappings since
" I think this must be set *before* SQL bits are loaded
let g:omni_sql_no_default_maps = 1

autocmd FileType mail call <SID>MailFileSettings()
function s:MailFileSettings()
    set spell
    set formatoptions+=n
    " See 'smartindent' and
    " http://stackoverflow.com/questions/6418348/why-does-vim-use-bash-indenting-rules-even-when-filetype-is-unset
    set nosmartindent
endfunction

autocmd FileType changelog call <SID>ChangeLogSettings()
function s:ChangeLogSettings()
    let g:changelog_username = 'Adam Monsen <haircut@gmail.com>'
endfunction

autocmd BufNewFile,Bufread NEWS call <SID>NewsFileSettings()
function s:NewsFileSettings()
    set tw=72
endfunction

function FindPriorDayInIrcLog()
    let l=line('.')
    while l
       let date=matchlist(getline(l), '--- \%(Log opened\|Day changed\) \(.*\)')
       let l-=1
       if !len(date)
          continue
       endif
       return date[1]
    endwhile
    return '(no date)'
endfun

autocmd BufNewFile,Bufread */.irssi/logs/* call <SID>IrcLogSettings()
function s:IrcLogSettings()
    set laststatus=2
    set statusline=%{FindPriorDayInIrcLog()}
endfunction

autocmd BufNewFile,Bufread *akefile call <SID>MakefileSettings()
function s:MakefileSettings()
    set noexpandtab " don't use spaces to indent
    set nosmarttab  " don't ever use spaces, not even at line beginnings
endfunction

autocmd FileType spec call <SID>SpecfileSettings()
function s:SpecfileSettings()
    let g:packager = 'Adam Monsen <haircut@gmail.com>'
    let g:spec_chglog_format = '%a %b %d %Y Adam Monsen <haircut@gmail.com>'
    let g:spec_chglog_release_info = 1
endfunction

" special journal settings
autocmd BufNewFile,Bufread journal*.txt call <SID>JournalSettings()
function s:JournalSettings()
    setlocal spell spelllang=en_us
    set tw=72
endfunction

" Adapt to GRE word study lists
autocmd BufNewFile,Bufread */gre_prep/*word*.txt call <SID>QuizDBSettings()
function s:QuizDBSettings()
    set noexpandtab
    set spell spelllang=en_us
    set nowrap
    set textwidth=0
    " dict is provided by the dictd package
    set keywordprg=dict
    " before writing word lists, put them in order
    autocmd BufWritePre *word*.txt %sort
endfunction

" Some of the HTML-specific settings require the HTML/XHTML editing macros
" provided by http://vim.org/scripts/script.php?script_id=453
let g:html_tag_case = 'lowercase'

autocmd FileType javascript call <SID>JavaScriptSettings()
function s:JavaScriptSettings()
    set formatoptions=tcqln
endfunction

autocmd FileType tex call <SID>TeXfileSettings()
function s:TeXfileSettings()
    "set formatoptions+=a
    set makeprg=make
endfunction

" for files encrypted using ccrypt(1)
augroup CPT
    au!
    " decrypt before reading
    au BufReadPre *.cpt       set bin viminfo= noswapfile
    " decrypted; prepare for editing
    au BufReadPost *.cpt      let $VIMPASS = inputsecret("Password: ")
    au BufReadPost *.cpt      %!ccrypt -cb -E VIMPASS
    au BufReadPost *.cpt      set nobin

    " encrypt
    au BufWritePre *.cpt      set bin
    au BufWritePre *.cpt      %!ccrypt -e -E VIMPASS
    " encrypted; prepare for continuing to edit the file
    au BufWritePost *.cpt     silent undo | set nobin
augroup END

autocmd FileType chordpro call <SID>ChordFileSettings()
function s:ChordFileSettings()
    set virtualedit=all mouse=a
endfunction

autocmd BufNewFile,BufRead *.md,*.mkd set filetype=markdown
autocmd FileType markdown call <SID>MarkdownFileSettings()
function s:MarkdownFileSettings()
    set makeprg=beautify\ %\ >\ /tmp/out.html
    autocmd BufWritePost *.md silent make
    set conceallevel=0
endfunction

" Bind9 zone database files
autocmd FileType bindzone call <SID>BindZoneSettings()
function s:BindZoneSettings()
    function s:UpdateBindZoneSerial(date, num)
        if (strftime("%Y%m%d") == a:date)
            return a:date . a:num+1
        endif
        return strftime("%Y%m%d") . '01'
    endfunction

    function s:ReplaceBindZoneSerialLine()
        :%s/\(2[0-9]\{7}\)\([0-9]\{2}\)\(\s*;\s*Serial\)/\=<SID>UpdateBindZoneSerial(submatch(1), submatch(2)) . submatch(3)/g
    endfunction

    autocmd BufWritePre /etc/bind/db.* call <SID>ReplaceBindZoneSerialLine()
endfunction

" Addons installed elsewhere {{{1

" UltiSnips {{{2

" avoids conflict with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-j>"

" gnupg.vim {{{2
let g:GPGPreferSign=1
let g:GPGDefaultRecipients=["haircut@gmail.com"]

" matchit {{{2
" Load matchit.vim, but only if the user hasn't installed a newer version.
" taken from https://github.com/tpope/vim-sensible
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

" Command-T {{{2
let g:CommandTNeverShowDotFiles=1
noremap <silent> <leader>b :CommandTMRU<CR>
noremap <silent> <leader>j :CommandTJump<CR>

" Airline {{{2
let g:airline_powerline_fonts=1
set t_Co=256
set laststatus=2

" Syntastic {{{2
let g:syntastic_javascript_checkers = ['jshint']
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" CSV {{{2

" The CSV plugin (chrisbra/csv.vim) spits out a warning if I don't set
" b:delimiter and b:col here manually. Warning is:
"
"   CSV Syntax:Invalid column pattern, using default pattern \%([^,]*,\|$\)
"
" This warning comes from the file ~/.vim/bundle/csv.vim/syntax/csv.vim . The
" problem may have something to do with the timing of when/how CSV plugin is
" loaded.
let b:delimiter=','
let b:col='\%(\%([^' . b:delimiter . ']*"[^"]*"[^' . b:delimiter . ']*' . b:delimiter . '\)\|\%([^' . b:delimiter . ']*\%(' . b:delimiter . '\|$\)\)\)'

" Fugitive {{{2
" see https://github.com/shumphrey/fugitive-gitlab.vim
let g:fugitive_gitlab_domains=['gitlab.com']
nmap [g :GitGutterPrevHunk<CR>
nmap ]g :GitGutterNextHunk<CR>
" customize gutter for my white-background color scheme
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=LightGray
highlight SignColumn guibg=LightGray

" Slava/vim-spacebars {{{2
let g:mustache_abbreviations=1

" Miscellaneous {{{1

" see ':he last-position-jump'
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" EXPORTING TO HTML... (see ':he 2html')

"   Edit another file in the same directory as the current file
"   uses expression to extract path from current file's path
"  (thanks Douglas Potts)
if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" Shell Script Goodies {{{2

" see ':he syntax' for more info

" Any shell scripts I edit will most likely be Bash
let g:is_bash = 1
" allow for heredocs, etc.
"let g:sh_fold_enabled = 1

" Final thoughts, modeline, etc. {{{1

set secure

" vim:foldmethod=marker
