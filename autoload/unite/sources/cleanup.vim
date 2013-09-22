
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

" call feedkeys('<Esc>')"
function! s:unite_source.gather_candidates(args, context)
    let updateHl = ' | call UpdateCleanupHighlite()' 
    let g:unite_cleanup_apps = [
        \ {
            \ 'name': 'Remove Whitespaces',
            \ 'cmd': string('%s/\ *$//g'),
            \ 'type': 'replace'
        \ },{
            \ 'name': 'Convert Tabs to Spaces',
            \ 'cmd': string('%s/\t/\ \ \ \ /g'),
            \ 'type': 'replace'
        \ },{
            \ 'name': '[' . ( &ff != 'unix' ? s:entry_format['warning'] : '' ) . &ff . '] Convert to UNIX Linebreaks',
            \ 'cmd': string('set ff=unix'),
            \ 'type': 'vim'
        \ },{
            \ 'name': '[' . ( g:cleanup_highlite_whitespaces ? s:entry_format['enabled'] : s:entry_format['disabled'] ) . '] Toggle Warning: Whitespace',
            \ 'cmd': ( g:cleanup_highlite_whitespaces ? string('let g:cleanup_highlite_whitespaces=0' . updateHl) : string('let g:cleanup_highlite_whitespaces=1' . updateHl)),
            \ 'type': 'vim'
        \ },{
            \ 'name': '[' . ( g:cleanup_highlite_tabs ? s:entry_format['enabled'] : s:entry_format['disabled'] ) . '] Toggle Warning: Hard Tabs',
            \ 'cmd': ( g:cleanup_highlite_tabs ? string('let g:cleanup_highlite_tabs=0' . updateHl) : string('let g:cleanup_highlite_tabs=1' . updateHl)),
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
call UpdateCleanupHighlite()

function! unite#sources#cleanup#define()
    return s:unite_source
endfunction

