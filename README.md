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

You can also run the last command with `TbroRedo`.

This plugin is designed to be very minimal and comes with no mappings. Its
original purpose was to be used with [vim-rspec](vim-rspec) and to have custom 
maps calling `Tbro` with predefined commands. To use Tbro with vim-rspec, you
can call `let g:rspec_command="Tbro rspec {spec}"` and vim-rspec will use Tbro
to call run specs.

## Mapping

This plugin is designed to call common shell commands from vim via custom maps.
Tbro has the `tbro#send` function which takes a command and an optional pane
string.

The pane string can be an index in the current window, or even a full
string matching the `tmux send-keys` format of `session:1.2`. `session` is the
target session, 1 is the target window, and 2 is the target pane. You can also
omit session and specify just the pane and window, or omit session and window and
specify only the pane.

Tbro comes with 1 default map, `<Leader>t` which sends the current line, or
currently selected lines to the target pane. You can opt out of these by setting
`let g:tbro_skip_maps = 1`.

## Installation

You really should be using [Vundle](https://github.com/gmarik/Vundle.vim). Add
the following to your `~/.vimrc` file, or wherever you keep your bundles.

```vim
Plugin 'BlakeWilliams/vim-tbro'
```
