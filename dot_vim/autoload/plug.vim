" vim-plug: Vim plugin manager
" ============================
"
" Download plug.vim and put it in ~/.vim/autoload
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Edit your .vimrc
"
"   call plug#begin('~/.vim/plugged')
"
"   " Make sure you use single quotes
"
"   " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"   Plug 'junegunn/vim-easy-align'
"
"   " Any valid git URL is allowed
"   Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"   " Multiple Plug commands can be written in a single line using | separators
"   Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"   " On-demand loading
"   Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
"   Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"   " Using a non-default branch
"   Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"   " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"   Plug 'fatih/vim-go', { 'tag': '*' }
"
"   " Plugin options
"   Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"   " Plugin outside ~/.vim/plugged with post-update hook
"   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"   " Unmanaged plugin (manually installed and updated)
"   Plug '~/my-prototype-plugin'
"
"   " Initialize plugin system
"   call plug#end()
"
" Then reload .vimrc and :PlugInstall to install plugins.
"
" Plug options:
"
"| Option                  | Description                                      |
"| ----------------------- | ------------------------------------------------ |
"| `branch`/`tag`/`commit` | Branch/tag/commit of the repository to use       |
"| `rtp`                   | Subdirectory that contains Vim plugin            |
"| `dir`                   | Custom directory for the plugin                  |
"| `as`                    | Use different name for the plugin                |
"| `do`                    | Post-update hook (string or funcref)             |
"| `on`                    | On-demand loading: Commands or `<Plug>`-mappings |
"| `for`                   | On-demand loading: File types                    |
"| `frozen`                | Do not update unless explicitly specified        |
"
" More information: https://github.com/junegunn/vim-plug
"
"
" Copyright (c) 2017 Junegunn Choi
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if exists('g:loaded_plug')
  finish
endif
let g:loaded_plug = 1

let s:cpo_save = &cpo
set cpo&vim

let s:plug_src = 'https://github.com/junegunn/vim-plug.git'
let s:plug_tab = get(s:, 'plug_tab', -1)
let s:plug_buf = get(s:, 'plug_buf', -1)
let s:mac_gui = has('gui_macvim') && has('gui_running')
let s:is_win = has('win32')
let s:nvim = has('nvim-0.2') || (has('nvim') && exists('*jobwait') && !s:is_win)
let s:vim8 = has('patch-8.0.0039') && exists('*job_start')
if s:is_win && &shellslash
  set noshellslash
  let s:me = resolve(expand('<sfile>:p'))
  set shellslash
else
  let s:me = resolve(expand('<sfile>:p'))
endif
let s:base_spec = { 'branch': '', 'frozen': 0 }
let s:TYPE = {
\   'string':  type(''),
\   'list':    type([]),
\   'dict':    type({}),
\   'funcref': type(function('call'))
\ }
let s:loaded = get(s:, 'loaded', {})
let s:triggers = get(s:, 'triggers', {})

function! s:is_powershell(shell)
  return a:shell =~# 'powershell\(\.exe\)\?$' || a:shell =~# 'pwsh\(\.exe\)\?$'
endfunction

function! s:isabsolute(dir) abort
  return a:dir =~# '^/' || (has('win32') && a:dir =~? '^\%(\\\|[A-Z]:\)')
endfunction

function! s:git_dir(dir) abort
  let gitdir = s:trim(a:dir) . '/.git'
  if isdirectory(gitdir)
    return gitdir
  endif
  if !filereadable(gitdir)
    return ''
  endif
  let gitdir = matchstr(get(readfile(gitdir), 0, ''), '^gitdir: \zs.*')
  if len(gitdir) && !s:isabsolute(gitdir)
    let gitdir = a:dir . '/' . gitdir
  endif
  return isdirectory(gitdir) ? gitdir : ''
endfunction

function! s:git_origin_url(dir) abort
  let gitdir = s:git_dir(a:dir)
  let config = gitdir . '/config'
  if empty(gitdir) || !filereadable(config)
    return ''
  endif
  return matchstr(join(readfile(config)), '\[remote "origin"\].\{-}url\s*=\s*\zs\S*\ze')
endfunction

function! s:git_revision(dir) abort
  let gitdir = s:git_dir(a:dir)
  let head = gitdir . '/HEAD'
  if empty(gitdir) || !filereadable(head)
    return ''
  endif

  let line = get(readfile(head), 0, '')
  let ref = matchstr(line, '^ref: \zs.*')
  if empty(ref)
    return line
  endif

  if filereadable(gitdir . '/' . ref)
    return get(readfile(gitdir . '/' . ref), 0, '')
  endif

  if filereadable(gitdir . '/packed-refs')
    for line in readfile(gitdir . '/packed-refs')
      if line =~# ' ' . ref
        return matchstr(line, '^[0-9a-f]*')
      endif
    endfor
  endif

  return ''
endfunction

function! s:git_local_branch(dir) abort
  let gitdir = s:git_dir(a:dir)
  let head = gitdir . '/HEAD'
  if empty(gitdir) || !filereadable(head)
    return ''
  endif
  let branch = matchstr(get(readfile(head), 0, ''), '^ref: refs/heads/\zs.*')
  return len(branch) ? branch : 'HEAD'
endfunction

function! s:git_origin_branch(spec)
  if len(a:spec.branch)
    return a:spec.branch
  endif

  " The file may not be present if this is a local repository
  let gitdir = s:git_dir(a:spec.dir)
  let origin_head = gitdir.'/refs/remotes/origin/HEAD'
  if len(gitdir) && filereadable(origin_head)
    return matchstr(get(readfile(origin_head), 0, ''),
                  \ '^ref: refs/remotes/origin/\zs.*')
  endif

  " The command may not return the name of a branch in detached HEAD state
  let result = s:lines(s:system('git symbolic-ref --short HEAD', a:spec.dir))
  return v:shell_error ? '' : result[-1]
endfunction

if s:is_win
  function! s:plug_call(fn, ...)
    let shellslash = &shellslash
    try
      set noshellslash
      return call(a:fn, a:000)
    finally
      let &shellslash = shellslash
    endtry
  endfunction
else
  function! s:plug_call(fn, ...)
    return call(a:fn, a:000)
  endfunction
endif

function! s:plug_getcwd()
  return s:plug_call('getcwd')
endfunction

function! s:plug_fnamemodify(fname, mods)
  return s:plug_call('fnamemodify', a:fname, a:mods)
endfunction

function! s:plug_expand(fmt)
  return s:plug_call('expand', a:fmt, 1)
endfunction

function! s:plug_tempname()
  return s:plug_call('tempname')
endfunction

function! plug#begin(...)
  if a:0 > 0
    let s:plug_home_org = a:1
    let home = s:path(s:plug_fnamemodify(s:plug_expand(a:1), ':p'))
  elseif exists('g:plug_home')
    let home = s:path(g:plug_home)
  elseif has('nvim')
    let home = stdpath('data') . '/plugged'
  elseif !empty(&rtp)
    let home = s:path(split(&rtp, ',')[0]) . '/plugged'
  else
    return s:err('Unable to determine plug home. Try calling plug#begin() with a path argument.')
  endif
  if s:plug_fnamemodify(home, ':t') ==# 'plugin' && s:plug_fnamemodify(home, ':h') ==# s:first_rtp
    return s:err('Invalid plug home. '.home.' is a standard Vim runtime path and is not allowed.')
  endif

  let g:plug_home = home
  let g:plugs = {}
  let g:plugs_order = []
  let s:triggers = {}

  call s:define_commands()
  