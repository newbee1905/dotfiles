if status is-interactive
	abbr yeet paru --cleanafter --skipreview --pacman powerpill
	abbr ll exa -Fal
	abbr ls exa -Fa
	abbr icat kitty +kitten icat
	abbr d kitty +kitten diff
	if test $TERM = "xterm-kitty"
		abbr ssh kitty +kitten ssh
  end	

	lua ~/Documents/Packages/z.lua/z.lua --init fish enhanced once fzf | source
	source ~/Documents/Packages/czmod/czmod.fish
	source (phpenv init -|psub)

	set -gx ATUIN_SESSION (atuin uuid)

	if test -z $ATUIN_NOBIND
			bind \cr _atuin_search

			if bind -M insert > /dev/null 2>&1
					bind -M insert \cr _atuin_search
			end
	end
end

function _atuin_preexec --on-event fish_preexec
	set -gx ATUIN_HISTORY_ID (atuin history start "$argv[1]")
end

function _atuin_postexec --on-event fish_postexec
	set s $status
	if test -n "$ATUIN_HISTORY_ID"
		RUST_LOG=error atuin history end $ATUIN_HISTORY_ID --exit $s &
		disown
	end
end

function _atuin_search
	set h (RUST_LOG=error atuin search -i (commandline -b) 3>&1 1>&2 2>&3)
	commandline -f repaint
	if test -n "$h"
		commandline -r $h
	end
end

function fish_greeting
end

function tb -d "cat a file and send them to termbin"
	cat $argv | nc termbin.com 9999 | xclip -selection c
end

function hg --wraps rg; kitty +kitten hyperlinked_grep $argv; end

set SUDO_ASKPASS /home/newbee/Documents/Scripts/askpass
set ANDROID_HOME /opt/android-sdk
set ANDROID_SDK /opt/android-sdk

set ORACLE_BASE /oracle
set ORACLE_HOME /oracle/product/db
set ORACLE_SID xdb
set ORACLE_INVENTORY /oracle/inventory
set LD_LIBRARY_PATH $ORACLE_HOME/lib:$LD_LIBRARY_PATH
set EDITOR nvim
set VISUAL nvim
fish_add_path ~/.splashkit/skm
fish_add_path $ORACLE_HOME/bin
fish_add_path $ANDROID_HOME/tools
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path ~/.local/bin
fish_add_path /usr/bin
fish_add_path /usr/share/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin
fish_add_path ~/Documents/Scripts
for d in ~/Documents/Scripts/*
	fish_add_path $d
end
fish_add_path ~/.dwm
fish_add_path ~/.phpenv/bin
fish_add_path ~/.gem/ruby/3.0.0/bin
fish_add_path /usr/lib/ruby/gems/3.0.0/bin
fish_add_path ~/.emacs.d/bin

set EDITOR nvim

# configure z.lua
set _ZL_MAXAGE 100000

# Setup fzf
set FZF_DEFAULT_OPTS = "--no-mouse --height 50% --border -1 --reverse --multi --inline-info --preview='[[ \(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),?:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
