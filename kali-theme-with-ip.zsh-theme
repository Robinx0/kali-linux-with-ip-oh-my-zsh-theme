
VPN=$(ps -ef | grep 'openvpn [eu|au|us|sg]'|tail -1| rev| awk '{print $1}'|rev |sed 's/\..*$//g')
IP=$(ifconfig | grep -A 1 en0 | grep 'inet ' | tr -s ' ' | cut -d ' ' -f 2)
if [ ! -z "$VPN" ]; then
    IP=$(ifconfig | grep -A 1 tun0 | grep 'inet ' | tr -s ' ' | cut -d ' ' -f 2)
fi

NEWLINE=$'\n'

PROMPT="${NEWLINE}%F{%(#.blue.green)}┌──%F{magenta}[$IP] %F{green}- (%B%F{%(#.red.blue)}%n@%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]${NEWLINE}└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} "
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
