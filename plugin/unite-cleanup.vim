
let g:cleanup_highlite_whitespaces = 1
let g:cleanup_highlite_tabs = 1

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

    syntax match ExtraWhitespace /\s\+$/ containedin=ALL
    syntax match ExtraTab /\t/ containedin=ALL
endfunction

call UpdateCleanupHighlite()

