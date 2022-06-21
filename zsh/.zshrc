# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/newbee/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
		zdharma-continuum/fast-syntax-highlighting

### End of Zinit's installer chunk

zinit light olets/zsh-abbr

#########
### Theme
#########
# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-autosuggestions
zinit light unixorn/fzf-zsh-plugin
zinit light Aloxaf/fzf-tab

abbr add --force --quiet ll='exa -Fal'
abbr add --force --quiet ls='exa -Fa'

#########
### Less
#########
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;32m'

#########
### FZF
#########
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND="fd -H -t file -E '/Library/' -E 'go-workspace/' -E 'node_modules' -E 'Pictures/Photos' -E 'powercord' -E 'go/pkg' -E 'miniconda3'"
export SKIM_DEFAULT_COMMAND="fd -H -t file -E '/Library/' -E 'go-workspace/' -E 'node_modules' -E 'Pictures/Photos' -E 'powercord' -E 'go/pkg' -E 'miniconda3'"
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# export FZF_DEFAULT_OPTS="--no-mouse --height 50%"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% --border -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),?:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"
#TOKYONIGHT THEME FOR FZF

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark --color=fg:-1,bg:-1,hl:#458588,fg+:#83a598,bg+:#282828,hl+:#d65d0e
--color=info:#b16286,prompt:#689d6a,pointer:#076678,marker:#076678
'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FD_OPTIONS="--follow --exclude .git --exclude node_modules -E Library -E go/"

#########
### Zlua
#########
eval "$(luajit /shared/github.com/skywind3000/z.lua/z.lua --init zsh enhanced once fzf)"
source /shared/github.com/skywind3000/czmod/czmod.zsh
