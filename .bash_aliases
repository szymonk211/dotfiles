shopt -s expand_aliases
brc() {
    vim ~/Dropbox/.bashrc_aliases
    source ~/.bashrc
}
alias vrc="vim ~/Dropbox/.vimrc"
alias setclip="xargs echo -n | xclip -selection c"
alias setclipa="xclip -selection c"
alias getclip="xclip -selection c -o"
alias findssh="sudo nmap -sS -p 22 192.168.8.0/24"

alias sshgcomp="ssh -xC greensort@34.122.99.65"

alias untar="tar -xvf "
alias untargz="tar -xzvf "
alias untarbz="tar -xjvf "
alias tarr="tar -cvf"

gaddco() {
    git add --all && git commit -m "$1"
}
alias gpot="git push origin test"
alias gpom="git push origin master"
alias gpow="git push origin work"

alias gpob4="git push origin borowka4.0"

alias sheetwork="chromium-browser --app https://docs.google.com/spreadsheets/d/1EYUg8JqnZ3moIvPONKPV4eSEDtfFNGPa/edit#gid=1358441422 &"
alias sheetpersonal="chromium-browser --app  https://docs.google.com/spreadsheets/d/1GYWCxWrGVAgpdzKmpE5Jn5UWhfFyURlI/edit#gid=1180772077 &"

alias sshpi="ssh pi@192.168.8.202 -X"

export PATH=~/Pobrane/pycharm-2021.1.2/bin/:$PATH

stty -ixon
