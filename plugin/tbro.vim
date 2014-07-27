if exists("g:loaded_tbro") || &cp || v:version < 700
  finish
endif

let g:loaded_tbro = 1

" Default pane to send commands to
if !exists("g:tbro_pane")
  let g:tbro_pane = 1
endif

function! tbro#send_command(command) abort
  let g:tbro_last_command = a:command
  let command = a:command."\r"
  let pane_id = g:tbro_pane

  let output = system('tmux send-keys -t'.pane_id.' ""'.shellescape(command))

  if v:shell_error
    echohl WarningMsg | echo output[0:-2]
  endif
endfunction

function! tbro#send_last_command()
  call tbro#send_command(g:tbro_last_command)
endfunction

function! tbro#set_pane(pane_id)
  let pane_string = split(a:pane_id, ':')
  let g:tbro_pane = pane_string[0]
endfunction

function! tbro#pane_complete(...)
  return system('tmux list-panes -F "#P:#{pane_current_command}"')
endfunction

command! -nargs=1 Tbro call tbro#send_command('<args>')
command! TbroRedo call tbro#send_last_command()
command! -nargs=1 -complete=custom,tbro#pane_complete TbroPane
      \ call tbro#set_pane('<args>')
