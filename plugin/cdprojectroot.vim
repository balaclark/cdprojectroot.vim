function! GetProjectRoot(...) abort
    if a:0 == 0
        let l:dir_curr = getcwd()
    else
        let l:dir_curr = a:1
    endif

    let l:dir_last = ""

    while l:dir_last != l:dir_curr
        if isdirectory(l:dir_curr . '/.git') || filereadable(l:dir_curr . '/.git')
            return l:dir_curr
        else
            let l:dir_last = l:dir_curr
            let l:dir_curr = fnamemodify(l:dir_curr, ':h')
        endif
    endwhile

    " when we are here no vcs dir was found, so we assume we are not in
    " a version controlled directoriy
    return ""
endfunction

function! CdProjectRoot()
  let g:project_root = GetProjectRoot()
  if strlen(g:project_root)
    execute 'cd' fnameescape(g:project_root)
  endif
endfunction

command! -nargs=0 ProjectRoot echo GetProjectRoot()
command! -nargs=0 CdProjectRoot call CdProjectRoot()

