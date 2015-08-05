# vim-tbro
Easily send commands to a pane in the same tmux window.

There's a lot of vim plugins out there that interact with tmux but all of them
seem to do a lot more than what I wanted to do. All tbro does is send your
command to the pane specified by `g:tbro_pane`. That's it.

## Usage

In vim you can call `Tbro command` to send "command" to the pane specified by
`g:tbro_pane`. Use `ctrl+a q` (or whatever your tmux prefix is) to display your
panes id's. The default pane is pane 1. If you want to target a different pane,
just set `let g:tbro_pane = 2` or call `:TbroPane` (be sure to use tab complete
with `:TbroPane`!).

Tbro provides a way to send raw keys to a pane using the `TbroKeys`. For
example, you can send control+c by calling `TbroKeys C-c`.

You can also run the last command with `TbroRedo`.

tbro was designed to be very minimal. Its original purpose was to be
used with [vim-rspec](vim-rspec) and to have custom maps calling `Tbro` with
predefined commands or to be used with other plugins. To use Tbro with
vim-rspec, you can call `let g:rspec_command="Tbro rspec {spec}"` and
vim-rspec will use Tbro to call run spec.

For more specific usage, run `:help tbro` in vim.

## Mapping

This plugin is designed to work with tmux by setting a target pane and
repeatedly sending text to it in whatever way fits your workflow.

Instead of providing default mappings, here's some ideas on how you can use tbro
to build your own mappings.

```
" Send current line, or selection to target pane
vmap <silent> <Leader>t :call tbro#run_selection()<cr>
nmap <silent> <Leader>t :call tbro#run_line()<cr>

" Send arbitrary commands to tbro quickly
nnoremap ! :Tbro 

" Resend the last command
nnoremap !! :TbroRedo<cr>

" Use tbro with vim-rspec
let g:rspec_command = "Tbro rspec {spec}"
```

## Installation

You should probably be using [vim-plug](https://github.com/junegunn/vim-plug).
Add the following to your `~/.vimrc` file, or wherever you keep your bundles.

```vim
Plugin 'BlakeWilliams/vim-tbro'
```
