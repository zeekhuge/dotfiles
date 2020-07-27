#!/usr/bin/env bash
# Extension to ~/.bashrc file for user=zeekhuge

## Aliases
#beaglebone helpers
alias bbbfs='sshfs root@192.168.7.2:/root/ ~/Desktop/BBBfs'
alias enterB='ssh root@192.168.7.2'

#sudo helpers
alias suod='sudo'
alias soud='sudo'
alias sduo='sudo'

#network helpers
alias pingg='ping 8.8.8.8'
alias pingme='echo "ping www.zeekhuge.me" && ping www.zeekhuge.me'

#vim obsession
alias :q!='exit'
alias vim='nvim'

#misc
alias tellme='tellme $(fc -ln -1)'
alias snck='cd $SNCK && vim'
alias lastCommand='echo "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias showMindList='cat /home/zeekhuge/.mindList/theList'
alias xo='xdg-open'
alias mtail='multitail'
alias ranger='TERM=xterm-256color ranger'
alias cdmz='cd ~/Projects/mz-application/'
alias cdop='cd ~/Projects/OpenSource/'
alias cdpr='cd ~/Projects/'
alias activate_venv='source ./.env/bin/activate'
alias rm='echo "Use trash instead ?"; false'



#Experimentation docker container
alias exContainer='docker run -it -v ~:/root/ project/experiment_container:latest'

# ParseDashboard
alias pDashContainer='docker run -d -v ~/Projects/Dashboard:/etc/parse -p 127.0.0.1:4040:4040 --name parse-dashboard --rm project/dashboard:latest'

#############################################################################################################

## Vars
export SNCK=/home/zeekhuge/Desktop/snck/
export PROJ="/home/zeekhuge/Projects"
export OP="$PROJ/OpenSource"
export ZG="$OP/ZeekHuge"
export MZ="$PROJ/Mouzike"
export AL="$OP/Alfred"
export PRU_CGT="/home/zeekhuge/ti-cgt-pru_2.1.2"
export PRU_EX="/home/zeekhuge/Projects/OpenSource/pru-software-support-package/examples/am335x"
export BFS="/home/zeekhuge/Desktop/BBBfs"
export JAVA_HOME=/usr/lib/jvm/java-9-oracle/
export JRE_HOME=$JAVA_HOME/jre
export ANDROID_HOME=/home/zeekhuge/Android/Sdk
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/Sdk/platform-tools/
export EDITOR=vim

#############################################################################################################

## PATH
PATH="${PATH}:/home/zeekhuge/toolchain/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf/bin"
PATH="${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin"
PATH="${PATH}:/home/zeekhuge/bin"
PATH=$ANDROID_PLATFORM_TOOLS:$PATH
PATH="/home/zeekhuge/.npm-global/bin":$PATH
export PATH

#############################################################################################################

## Bindings
bind 'RETURN: "\n"'

#############################################################################################################

## Custom Functions
# function to set terminal title
function set-title(){
    if [[ -z "$ORG" ]]; then
        ORG=$PS1
    fi
    echo -ne "\033]0;$*\007"
}

function cdiff () {
    diff -u $@ | colordiff | less -R
}

gen_z_prompt () {

    readonly Z_RED_COLOR="\[$(tput setaf 1)\]"
    readonly Z_GREEN_COLOR="\[$(tput setaf 2)\]"
    readonly Z_YELLOW_COLOR="\[$(tput setaf 3)\]"
    readonly Z_BLUE_COLOR="\[$(tput setaf 4)\]"
    readonly Z_RESET_COLOR="\[$(tput sgr0)\]"

    function zbar_gen_dir () {
        local DIR=${Z_RED_COLOR}
        DIR+=$(pwd | sed 's/\/.*\///')
        DIR+=${Z_RESET_COLOR}
        echo ${DIR}
    }

    function zbar_is_git () {
        git log -1 2>/dev/null 1>&2
    }

    function zbar_gen_git () {
        zbar_is_git \
        && (\
        echo "${Z_YELLOW_COLOR}$(\
            basename `git rev-parse --show-toplevel`\
            )${Z_BLUE_COLOR}:${Z_GREEN_COLOR}$(\
            git branch | grep "*" | sed 's/\*\s\+//'\
            )${Z_RESET_COLOR}") \
        || echo ""
    }

    function zbar_gen_dot () {
        local lastExitStatus=$1
        $(exit ${lastExitStatus}) && local SYMBOL=${Z_GREEN_COLOR} || local SYMBOL=${Z_RED_COLOR}
        SYMBOL+=$'\u25cf'
        SYMBOL+=${Z_RESET_COLOR}
        echo ${SYMBOL}
    }

    function zbar_ranger_shell () {
        if [[ ! -z $RANGER_LEVEL ]]; then
            echo "${Z_YELLOW_COLOR}(ranger)${Z_RESET_COLOR} "
        fi
    }

    function zbar_python_venv () {
        if [[ ! -z $VIRTUAL_ENV ]] ; then
            echo "${Z_YELLOW_COLOR}(venv)${Z_RESET_COLOR} "
        fi
    }

    function zbar-dir-git-gen () {
        local lastExitStatus=$?
        PS1="$(zbar_ranger_shell)$(zbar_python_venv)$(zbar_gen_dir) $(zbar_gen_dot ${lastExitStatus}) "
        $(zbar_is_git) && PS1+="$(zbar_gen_git) $(zbar_gen_dot ${lastExitStatus}) "
    }

    zbar-gen () {
        local lastExitStatus=$?
        PS1="$(zbar_python_venv)$(zbar_gen_dot ${lastExitStatus}) "
    }

    function zbar() {
        if [ "$1" == "0" ]; then
            PROMPT_COMMAND=zbar-gen
        else
            PROMPT_COMMAND=zbar-dir-git-gen
        fi
    }
}
gen_z_prompt
unset gen_z_prompt

function complex-bar() {
    PROMPT_COMMAND=ps1
}

zbar
