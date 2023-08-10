
VPN=$(ps -ef | grep 'openvpn [eu|au|us|sg]'|tail -1| rev| awk '{print $1}'|rev |sed 's/\..*$//g')

OS_NAME=$(uname -a | awk '{print $1}')

if [ $OS_NAME=="Darwin" ]; then
    DEFAULT_INTERFACE=$(route get 0.0.0.0 | grep 'interface' | awk '{print $2}')
    IP=$(ifconfig | grep -A 1 $DEFAULT_INTERFACE | grep 'inet ' | tr -s ' ' | cut -d ' ' -f 2)
elif [ $OS_NAME=="Linux" ]; then
    DEFAULT_INTERFACE=$(route | grep '^default' | grep -o '[^ ]*$')
    IP=$(ifconfig | grep -A 1 $DEFAULT_INTERFACE | grep 'inet ' | tr -s ' ' | cut -d ' ' -f 3)
else 
    DEFAULT_INTERFACE=$(echo "check-the-code")
    IP=$(echo "check-the-code")
fi

if [ ! -z "$VPN" ]; then
    IP=$(ifconfig | grep -A 1 tun0 | grep 'inet ' | tr -s ' ' | cut -d ' ' -f 2)
fi

NEWLINE=$'\n'

#PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT="${NEWLINE}%F{%(#.blue.green)}┌──%F{magenta}[$IP] %F{green}- (%B%F{%(#.red.blue)}%n@%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]${NEWLINE}└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} "
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
