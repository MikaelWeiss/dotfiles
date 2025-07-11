# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias strive="cd ~/code/strive"
alias s="cd ~/code/strive"
alias gs="git status"
alias home="cd"
alias ops="open ~/code/strive/Strive.xcodeproj/"
alias opsh="open ~/code/work/sherpa/Sherpa.xcodeproj/"
alias gdf="git diff --name-only"
alias gstc=""
alias lg='lazygit'
alias gstash='git stash'
alias gsta='git stash apply'
alias gst="git stash"
alias gcm="git commit -m"
# alias gbc='git checkout -b $1 && git push -u origin $1'
unalias gcl 2>/dev/null
gcl() {
    git clone https://github.com/mikaelweiss/$1
}
gbc() {
    git checkout -b $1 && git push -u origin $1
}
alias minecraftskins='open Library/Application\ Support/minecraft/assets/skins'
alias minecraft='open Library/Application\ Support/minecraft'
# alias w='cd ~/code/work/lms'
alias opw='open ~/code/work/lms/lms.xcodeproj/'
alias work='cd ~/code/work'

# Alias for SSH
alias raspberrypi='ssh raspberrypi'
alias homepc='ssh homepc'

# Random
alias icloud='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs'
alias venv='source .venv/bin/activate'
alias xc='sh ~/code/dotfiles/resize-xcode.sh'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(/opt/homebrew/bin/brew shellenv)

# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x7000000e7,"HIDKeyboardModifierMappingDst":0x700000029}]}'
# launchctl load ~/Library/LaunchAgents/com.local.KeyRemapping.plist

# export PATH="$PATH:/Users/mikaelweiss/Library/Python/3.9/bin"

# Stuff for fly.io
export FLYCTL_INSTALL="/Users/mikaelweiss/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export PATH="$HOME/.cargo/env:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$PATH:/path/to/elixir/bin"
source $HOME/.local/bin/env
export PATH=$HOME/flutter-sdk/flutter/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
export CLAUDE_APP_PATH="/opt/homebrew/bin/claude"

. "$HOME/.local/bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/mikaelweiss/.lmstudio/bin"
# End of LM Studio CLI section


# pnpm
export PNPM_HOME="/Users/mikaelweiss/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
