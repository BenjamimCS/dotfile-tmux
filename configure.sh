#! /bin/bash
# TODO:
#  * option: symbolic link the tmux.conf

# newer the file, higher the right mose number
# i.g.: there's .tmux.conf and .tmux.conf.1,
# .tmux.conf becomes .tmux.conf.2
function no_override {
  if ! [ -e ~/.tmux.conf.old ]; then
    cp ~/.tmux.conf ~/.tmux.conf.old
    exit
  fi

  if ! ls ~/.tmux.conf.old.* > /dev/null 2>&1; then
    cp ~/.tmux.conf ~/.tmux.conf.old.1
    exit
  fi

  greater="`ls -1 ~/.tmux.conf.old.* |\
                 xargs -n1 basename |\
                 grep -o '[0-9]\+' |\
                 sort -r  |\
                 head -n1`"
  number=$(($greater + 1))
  cp ./tmux.conf ~/.tmux.conf.old.${number}
}

if ! [ -e "${HOME}/.tmux/plugins/tpm" ]; then
  echo -e "\e[32m=> Install \e[34m\e]8;;https://github.com/tmux-plugins/tpm\atpm\e]8;;\a\e[0m"
  git clone --depth 1 --no-single-branch https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo -e "\e[32m=> \e[34m\e]8;;https://github.com/tmux-plugins/tpm\atpm\e]8;;\a\e[0m already installed"
fi

if [ -e "${HOME}/.tmux.conf" ]; then
  echo -e  "Override \e[37;4m.tmux.conf\e[0m? "
  echo -e  "\e[32mTIP:\e[0m Case doesn't matter"
  echo -en "\e[30m[ \e[33mY \e[30mor \e[33myes \e[30m | \e[33mN \e[30mor \e[33mNo \e[30m]\e[33m "
  read confirm
  confirm=`echo $confirm | tr [:upper:] [:lower:]`
fi

echo -e '\e[32m=> Add \e[37;4m.tmux.conf\e[0m\e[32m file in \e[33m$HOME\e[30m'
case $confirm in
  y | yes)
    cat tmux.conf > ~/.tmux.conf;;
  n | no)
    no_override;;
  *)
    cat tmux.conf > ~/.tmux.conf;;
esac
