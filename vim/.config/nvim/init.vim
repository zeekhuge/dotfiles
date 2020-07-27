" to start vim-plug plugin manager
call plug#begin('~/.config/nvim/bundle/')

Plug '~/.vim/bundle/ale'
Plug '~/.vim/bundle/asyncrun.vim'

" we probably do not want this, we already have YCM
Plug '~/.vim/bundle/AutoComplPop'

Plug '~/.vim/bundle/ctrlp.vim'

" we do not want to use this for now
" Plug '~/.vim/bundle/autocomplete-flow'

Plug '~/.vim/bundle/csv', {'for': 'csv'}

" The project below is old now and need to be updated
" Plug '~/.vim/bundle/nvim-completion-manager'

Plug '~/.vim/bundle/delimitMate'
Plug '~/.vim/bundle/indentLine'
Plug '~/.vim/bundle/jedi-vim', {'for': 'javascript'}
Plug '~/.vim/bundle/jshint.vim', {'for': 'javascript'}
Plug '~/.vim/bundle/neoformat'
Plug '~/.vim/bundle/nerdtree', {'on': ['NERDTreeToggle', 'NERDTree']}
Plug '~/.vim/bundle/riv.vim', {'for': 'rst'}
Plug '~/.vim/bundle/rust.vim', {'for': 'rust'}
Plug '~/.vim/bundle/split-term.vim'
Plug '~/.vim/bundle/taboo.vim'
Plug '~/.vim/bundle/tabular'
Plug '~/.vim/bundle/tagbar'
Plug '~/.vim/bundle/tern_for_vim', {'for': 'javascript'}
Plug '~/.vim/bundle/vim-airline'
Plug '~/.vim/bundle/vim-airline-themes'
Plug '~/.vim/bundle/vim-buffergator'
Plug '~/.vim/bundle/vim-colorschemes'
Plug '~/.vim/bundle/vim-easymotion'
Plug '~/.vim/bundle/vim-fugitive'
Plug '~/.vim/bundle/vim-indent-guides'
Plug '~/.vim/bundle/vim-javascript-syntax', {'for': 'javascript'}
Plug '~/.vim/bundle/vim-jsdoc', {'for': 'javascript'}
Plug '~/.vim/bundle/vim-lion'
Plug '~/.vim/bundle/vim-markdown-preview', {'for': 'markdown'}

" Instead of automatically loaded last sessio, we want startify to be the first screen.
" Plug '~/.vim/bundle/vim-plugin-autosess'

Plug '~/.vim/bundle/vim-signature'
Plug '~/.vim/bundle/vim-startify'
Plug '~/.vim/bundle/vim-tmux-navigator'
Plug '~/.vim/bundle/wiki.vim', {'for': 'markdown'}
Plug '~/.vim/bundle/YouCompleteMe', {'for': ['python', 'javascript', 'c', 'c++', 'dart']}

Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}

Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}

Plug 'keith/swift', {'for': 'swift'}

call plug#end()

syntax on
filetype plugin indent on

set background=dark
set t_Co=256

"wikivim plugin
let g:vimwiki_list = [{'path':'~/vimwiki', 'syntax':'markdown', 'ext':'.wiki'}]

"wiki.vim plugin
let g:wiki_root = '/home/zeekhuge/Journals/'

"NerdTree ignoring files
let NERDTreeIgnore = ['\.pyc$']

"ctrlp settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'

"easymotion settings. Set them only if this is not ideavim (Android studio vim
"plugin)
if !exists("g:ideaVim")
    map / <Plug>(easymotion-sn)
    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)
    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
endif

" Journaling helpers

" prospector setup
if (empty($VIRTUAL_ENV))
else
    let $PYTHONPATH=$PYTHONPATH.':'.$VIRTUAL_ENV.'/lib/python3.5/site-packages:'.$VIRTUAL_ENV.'/lib64/python3.5/site-packages'
endif


" YCM config
" the preview window is very annoying
:set completeopt-=preview
if (empty($VIRTUAL_ENV))
	let g:ycm_python_binary_path = 'python'
else
	let g:ycm_python_binary_path = $VIRTUAL_ENV . '/bin/python'
endif
let g:ycm_semantic_triggers = {'python' : [ 're!\w{2}' ]}

" Startify config
let g:startify_session_dir = '~/.vim/autosess/'
let g:startify_session_autoload = 1
let g:startify_session_persistence = 0

" bffergator settings
:set hidden
:nnoremap \q :BuffergatorOpen<CR>
:nnoremap [b :BuffergatorMruCyclePrev<CR>
:nnoremap ]b :BuffergatorMruCycleNext<CR>
let g:buffergator_viewport_split_policy = "T"
let g:buffergator_sort_regime = "mru"
let g:buffergator_show_full_directory_path = 0
let g:buffergator_tab_statusline = 0
let g:buffergator_window_statusline = 0
let g:buffergator_autodismiss_on_select = 1
let g:buffergator_autoupdate = 1
let g:buffergator_mru_cycle_loop = 1


" chosen colorscheme for vim and airline
:colorscheme CandyPaper
:let g:airline_theme='badwolf'


" settings for the vim-jsdoc plugins
let g:jsdoc_enable_es6 = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_return = 1
let g:jsdoc_return_type = 1
let g:jsdoc_return_description = 1


" setting ale plugin
let g:ale_linters = {'javascript':['flow', 'jshint'], 'python':['prospector --with-tool mypy']}
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>
let g:ale_sign_style_error = '-'
let g:ale_sign_style_warning = '--'
let g:ale_filetype_blacklist = ['qf', 'tags', 'unite', 'terminal', 'term']
let g:ale_sign_column_always = 1


" settings for the indentLine and indentGuide plugins
set ts=4 sw=4 et
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=grey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
let g:indentLine_char = '|'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" airline settings
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1


" autocomplpop settings
let g:acp_enableAtStartup = 1
let g:acp_ignorecaseOption = 0

" deoplete settings
let g:deoplete#enable_at_startup = 1


" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" mappings & settings for split-term plugin
set splitright
set splitbelow
nnoremap -D :call ToggleTerm()<CR>

" settings for taglist
nnoremap -L :call ToggleTagbar()<CR>
let g:tagbar_autoclose = 0
let g:tagbar_left = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 2
let g:tagbar_show_linenumber = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_sort = 0


" mappings & settins for tagbar
let Tlist_Auto_Highlight_Tag = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_Use_Right_Window = 1

" to fix Yanking and system clipboard problem
" basically a combination of two workarounds
" https://github.com/neovim/neovim/issues/583#issuecomment-40942281
" and
" https://github.com/neovim/neovim/issues/583#issuecomment-43196619
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p
onoremap <silent> y y:call ClipboardYank()<cr>
onoremap <silent> d d:call ClipboardYank()<cr>

"highlight `TODO`
:highlight Highlight_EXTREME ctermfg=Black ctermbg=Blue guifg=Black guibg=Red
:highlight Highlight_NEED_NOTICE ctermfg=Black ctermbg=Yellow guifg=Black guibg=Yellow
:highlight Highlight_DONE_NOTICE ctermfg=Black ctermbg=Green guifg=Black guibg=Green
:call matchadd("Highlight_EXTREME", "BUG")
:call matchadd("Highlight_EXTREME", "FIXME")
:call matchadd("Highlight_NEED_NOTICE", "TODO")
:call matchadd("Highlight_DONE_NOTICE", "DONE")

" Move lines easily
" Use shuft+up/down arrow to move lines
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

"To prevent vim_markdown_preview plugin from misbehaving
let vim_markdown_preview_toggle=1
let vim_markdown_preview_github=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""methods

" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:AddEffects(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:AddEffects(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:AddEffects(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:AddEffects(<line1>, <line2>, '0336')

command! -range -nargs=0 RStrikethrough   call s:RemoveEffects(<line1>, <line2>, '0336')

function! s:AddEffects(line1, line2, effectCode)
  execute 'let char = "\u'.a:effectCode.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

function! s:RemoveEffects(line1, line2, effectCode)
  execute 'let char = "\u'.a:effectCode.'"'
  execute a:line1.','.a:line2.'s/&'.char.'/\%V[^[:cntrl:]]/ge'
endfunction

map -st <ESC>I<ESC>v$:Strikethrough<CR>


function! LoopColorScheem(start_from)
    let path = split(globpath('~/.vim/bundle/vim-colorschemes/colors/','*'), "\n")
    for fl in path
            if "fl" == "start_from"
                continue
            endif
        if start_from != ""
        endif
        sleep 500m
        let fl = substitute(fl, "^\/.*\/", "", "g")
        let fl = substitute(fl, ".vim$", "", "g")
        execute ':colorscheme ' . fl . ' | :redraw!'
        execute ':echo ' . "fl"
        sleep 4000m
    endfor
endfunction


function! AddGitTemplateAddition()
    execute ':1'
    let cPut=search('^\# Please enter the.*') - 1
    let cStart=search('^\# Changes to be committed:$') + 1
    let cEnd=search('^\#$')
    execute ':1'
    if cPut >= 0 && cEnd >= cStart && cStart >= 0
        execute ':echo ' . cStart . " " . cEnd
        execute ':'. cStart . ',' . cEnd . 's/^\#\s//'
        execute ':' . cStart . ',' . cEnd . 'm ' . cPut
        let cPut = cPut-1
        execute ':' . cPut
        execute ':normal'
    endif
endfunction

function! ToggleTerm()
    if bufwinnr('term') > 0
        exe bufwinnr('term') . "windo -" . "exit"
    else
        exe "10Term"
    endif
endfunction

function! ToggleTagbar()
    if bufwinnr('Tagbar') > 0
        exe bufwinnr('Tagbar') . "windo -" . "exit"
    else
        exe "Tagbar"
    endif
endfunction

" To restore the split size and shape when moving between
" different (zoomed) split configurations and others
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>
function! MaximizeToggle()
    if exists("s:maximize_session")
        let s:maximize_current_buf_name=@%
        exec "source " . s:maximize_session
        if exists("s:maximize_nerd_exists")
            if bufwinnr('NERD') < 0
                exec "NERDTreeToggle"
            endif
            unlet s:maximize_nerd_exists
        endif
        if exists("s:maximize_tagbar_exists")
            if bufwinnr('Tagbar') < 0
                exec "Tagbar"
            endif
            unlet s:maximize_tagbar_exists
        endif
        if bufwinnr('term') > 0
            exe bufwinnr('term') . "resize 10"
            exe bufwinnr('term') . "windo setlocal number!"
            wincmd p
        endif
        exec bufwinnr(s:maximize_current_buf_name) . "windo -"
        call delete(s:maximize_session)
        unlet s:maximize_session
        let &hidden=s:maximize_hidden_save
        unlet s:maximize_hidden_save
    else
        let s:maximize_hidden_save = &hidden
        let s:maximize_session = tempname()
        set hidden
        if bufwinnr('NERD') > 0
            let s:maximize_nerd_exists=""
            exec "NERDTreeToggle"
        endif
        if bufwinnr('Tagbar') > 0
            let s:maximize_tagbar_exists=""
            exec "TagbarClose"
        endif
        set sessionoptions-=tabpages
        exec "mksession! " . s:maximize_session
        set sessionoptions+=tabpages
        only
    endif
endfunction


"" Helping with ctags very simple for now
function! GenCtags ()
    !ctags -R
    echo getcwd()
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""other config

"to make vim show current filename
set laststatus=2

:set wildmenu
"to enable auto sysntax highlighting by enabling auto detection of file type
filetype on

"to autoindent the next line
set autoindent

"to make the backspace key work
set backspace=indent,eol,start

"this line makes vim search for tag folder recursively till the /
set tags=./tags;/,tags;/


"To get the shell command output in a buffer
:command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

"Command to setup things while commenting code or commit messages
:command Comment :set spell! spelllang=en_us | :set cc=72
:command Commit :set spell! spelllang=en_us | :set cc=72 | silent :call AddGitTemplateAddition()
:command GC :R git diff --cached

"Compile the current cpp file
:command CC execute 'silent ! g++ -DDEBUG %:t -o %:t.out 2>output.txt 1>output.txt' | execute ':redraw!'
:command Run execute 'silent ! ./%:t.out 1>output.txt 2>output.txt < input.txt' | execute ':redraw!'

:command CachedDiff :Commit | :R 'git diff --cached' | :set cc=0 | :set spell! spelllang=en_us

"adding other options
set pastetoggle=<F5>
set number

map -S :set spell! spelllang=en_us<CR>
nnoremap -N : setlocal number!<CR>
nnoremap -CS :LinuxCodingStyle<CR>
nnoremap -CL :%s/\s\+$//<CR>
map -tb1 <C-W><T>:Tabmerge 1<CR>
nnoremap as i<Space><ESC>
nnoremap zx o<ESC>
nnoremap -tb2 <C-W><T>:Tabmerge 2<CR>
nnoremap -tb3 <C-W><T>:Tabmerge 3<CR>
set clipboard=unnamed
nnoremap Y "+y
nnoremap P "+p

"tabline.vim settings
" Newer schemes seem to be support tabling, hence comment out
" this overriding
"hi TabLine ctermfg=Black ctermbg=Grey cterm=NONE
"hi TabLineFill ctermfg=Black ctermbg=Grey cterm=NONE
"hi TabLineSel ctermfg=White ctermbg=DarkBlue cterm=NONE

highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline,bold cterm=underline,bold
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline,bold
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline,bold
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline,bold

"Highlight cursor line
"Do not set, as it slows vim down
"set cursorline

"mappings to make vim and tmux split navigation same"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"To map nerd tree toggle command
nnoremap -B :NERDTreeToggle<CR>
nnoremap -BC :NERDTreeMirror<CR>

"binding to input 'TIME TAKEN' and 'Relevant Issue' stamp
nnoremap -TT iTIME TAKEN :   hours<ESC>7h i
nnoremap -RI iRelevant Issue #
"Earlier -TD use to print TO-DO, so in older projects, search for TO-DO insted.
nnoremap -TD i#// TODO :
" To automatically add the modified file list when using 'git commit -v'
"nnoremap -MF iModified Files:<ESC>I<ESC>5j

autocmd BufNewFile *.cpp :r! sed -n 'p' < ~/Desktop/snck/.cpp.template
"Do not set, as it slows vim down
"autocmd InsertLeave * :set cul! | :redraw!
"autocmd InsertEnter * :set cul! | :redraw!
set smartindent

let g:new_buf_bash = 0
let g:buf_enter_bash = 0
let g:enter_cmd_win = 0


"Settings to make netrw more usable
"PS : Its a really good feature
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 15
let g:netrw_preview = 1

