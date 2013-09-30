
let s:unite_source = {
    \ 'name': 'cleanup',
\ }

let s:exec_strings = {
    \ 'vim': 'execute ',
    \ 'function': 'call ',
    \ 'replace': 'execute ',
    \ 'vimshell': '',
    \ 'shell': '',
\ }

let s:entry_format = {
    \ 'disabled': 'disabled',
    \ 'enabled': 'enabled',
    \ 'warning': 'WARNING',
    \ 'error': 'ERROR',
\ }

" todo: use kind from unite
" todo: use action from unite
" todo: fix regex for insert mode
" todo: comma highliting only if not in string
" todo: deactivate for scrap/unite/... buffer 

function! s:unite_source.gather_candidates(args, context)
    let updateHl = ' | call UpdateCleanupHighlite()'
    let g:unite_cleanup_apps = [
        \ {
            \ 'name': 'Remove Whitespaces',
            \ 'description': 'bla bla bla',
            \ 'default_kind': 'command',
            \ 'cmd': string('%s/\ *$//g'),
            \ 'type': 'replace'
        \ }, {
            \ 'name': 'Convert Tabs to Spaces',
            \ 'description': 'bla bla bla',
            \ 'cmd': string('%s/\t/\ \ \ \ /g'),
            \ 'cmd_safe': string('%s/\t/\ \ \ \ /gc'),
            \ 'type': 'replace'
        \ }, {
            \ 'name': 'Fix Commas',
            \ 'description': 'bla bla bla',
            \ 'cmd': string('%s/ ,/,/g | %s/,\(\S\)/, \1/g'),
            \ 'cmd_safe': string('%s/ ,/,/gc | %s/,\(\S\)/, \1/gc'),
            \ 'type': 'replace'
        \ }, {
            \ 'name': '[' . ( &ff != 'unix' ? s:entry_format['warning'] : '' ) . &ff . '] Convert to UNIX Linebreaks',
            \ 'description': 'bla bla bla',
            \ 'cmd': string('set ff=unix'),
            \ 'type': 'vim'
        \ }, {
            \ 'name': '[' . ( g:cleanup_highlite_whitespaces ? s:entry_format['enabled'] : s:entry_format['disabled'] ) . '] Toggle Warning: Whitespace',
            \ 'description': 'bla bla bla',
            \ 'cmd': ( g:cleanup_highlite_whitespaces ? string('let g:cleanup_highlite_whitespaces=0' . updateHl) : string('let g:cleanup_highlite_whitespaces=1' . updateHl)),
            \ 'type': 'vim'
        \ }, {
            \ 'name': '[' . ( g:cleanup_highlite_tabs ? s:entry_format['enabled'] : s:entry_format['disabled'] ) . '] Toggle Warning: Hard Tabs',
            \ 'description': 'bla bla bla',
            \ 'cmd': ( g:cleanup_highlite_tabs ? string('let g:cleanup_highlite_tabs=0' . updateHl) : string('let g:cleanup_highlite_tabs=1' . updateHl)),
            \ 'type': 'vim'
        \ }, {
            \ 'name': '[' . ( g:cleanup_highlite_commas ? s:entry_format['enabled'] : s:entry_format['disabled'] ) . '] Toggle Warning: Bad Commas',
            \ 'description': 'bla bla bla',
            \ 'cmd': ( g:cleanup_highlite_commas ? string('let g:cleanup_highlite_commas=0' . updateHl) : string('let g:cleanup_highlite_commas=1' . updateHl)),
            \ 'type': 'vim'
        \ }
    \ ]

    return map(g:unite_cleanup_apps, '{
            \ "word": v:key . " " . v:val.name,
            \ "source": "cleanup",
            \ "kind": "command",
            \ "action__command": s:exec_strings[v:val.type] . v:val.cmd,
        \ }')

endfunction

function! unite#sources#cleanup#define()
    return s:unite_source
endfunction

