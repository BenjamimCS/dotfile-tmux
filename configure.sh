#! /bin/bash
# TODO:
#  * feature: if there's already .tmux.conf.old, 
#    append .1 and forth to the actual .conf
#    e.g.: .tmux.conf.old already exists, so
#          append .1 to .tmux.conf .tmux.conf.1
#  * option: symbolic link the tmux.conf

if ! [ -e "${HOME}/.tmux/plugins/tpm" ]; then
  echo -e "\e[32m=> Install \e[34m\e]8;;https://github.com/tmux-plugins/tpm\atpm\e]8;;\a\e[0m"
  git clone --depth 1 --no-single-branch https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo -e "\e[32m=> \e[34m\e]8;;https://github.com/tmux-plugins/tpm\atpm\e]8;;\a\e[0m already installed"
fi

echo -e  "Override \e[37;4m.tmux.conf\e[0m? "
echo -e  "\e[32mTIP:\e[0m Case doesn't matter"
echo -en "\e[30m[ \e[33mY \e[30mor \e[33myes \e[30mor | \e[33mN \e[30mor \e[33mNo \e[30m]\e[33m "
read confirm
confirm=`echo $confirm | tr [:upper:] [:lower:]`

echo -e '\e[32m=> Add \e[37;4m.tmux.conf\e[0m\e[32m file in \e[33m$HOME\e[30m'
case $confirm in
  y | yes)
    cat tmux.conf > ~/.tmux.conf;;
  n | no)
    cp ~/.tmux.conf ~/.tmux.conf.old
    cat tmux.conf > ~/.tmux.conf
    ;;
  *)
    cat tmux.conf > ~/.tmux.conf;;
esac
