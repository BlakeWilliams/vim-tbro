if exists("g:loaded_tbro") || &cp || v:version < 700
  finish
endif

let g:loaded_tbro = 1

" Default pane to send commands to
if !exists("g:tbro_pane")
  let g:tbro_pane = 1
endif

function! tbro#send_command(command) abort
  let command = a:command."\r"
  let g:tbro_last_command = command
  let pane_id = g:tbro_pane

  silent call system('tmux send-keys -t'.pane_id.' ""'.shellescape(command))
endfunction

function! tbro#send_last_command()
  call tbro#send_command(g:tbro_last_command)
endfunction

command! -nargs=1 Tbro call tbro#send_command('<args>')
command! TbroRedo call tbro#send_last_command()
