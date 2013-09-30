
if exists('g:cleanup_loaded') || &compatible
    finish
endif

let g:cleanup_loaded = 1
let g:cleanup_highlite_whitespaces = 1
let g:cleanup_highlite_tabs = 1
let g:cleanup_highlite_commas = 1

function! UpdateCleanupHighlite()
    if g:cleanup_highlite_whitespaces
        highlight ExtraWhitespace ctermbg=red guibg=red
    else
        highlight ExtraWhitespace ctermbg=none guibg=none
    endif

    if g:cleanup_highlite_tabs
        highlight ExtraTab ctermbg=red guibg=red
    else
        highlight ExtraTab ctermbg=none guibg=none
    end

    if g:cleanup_highlite_commas
        highlight ExtraComma ctermbg=red guibg=red
    else
        highlight ExtraComma ctermbg=none guibg=none
    end

    syntax match ExtraWhitespace /\s\+$/ containedin=ALL
    syntax match ExtraTab /\t/ containedin=ALL
    syntax match ExtraComma /,\S/ containedin=ALL
    syntax match ExtraComma / ,/ containedin=ALL
endfunction

augroup UniteCleanup
    au!
    au VimEnter,WinEnter,BufWinEnter * call UpdateCleanupHighlite()
augroup END

