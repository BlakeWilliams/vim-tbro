if exists("g:loaded_tbro") || &cp || v:version < 700
  finish
endif

let g:loaded_tbro = 1

" Default pane to send commands to
if !exists("g:tbro_pane")
  let g:tbro_pane = 1
endif

function! tbro#send(command, ...) abort
  let g:tbro_last_command = a:command
  let command = shellescape(a:command)."\r"

  if a:0 == 1
    let pane_id = a:1
  else
    let pane_id = g:tbro_pane
  end

  let output = system('tmux send-keys -t '.pane_id.' ""'.command)

  if v:shell_error
    echohl WarningMsg | echo output[0:-2]
  endif
endfunction

function! tbro#redo()
  call tbro#send(g:tbro_last_command)
endfunction

function! tbro#set_pane(pane_id)
  let pane_string = split(a:pane_id, ':')
  let g:tbro_pane = pane_string[0]
endfunction

function! tbro#pane_complete(...)
  return system('tmux list-panes -F "#P:#{pane_current_command}"')
endfunction

command! -nargs=1 Tbro call tbro#send(<q-args>)
command! -nargs=1 -complete=custom,tbro#pane_complete TbroPane
      \ call tbro#set_pane('<args>')

command! TbroRedo call tbro#redo()
