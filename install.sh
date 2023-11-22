#!/bin/bash

check_installed() {
  type $1 &> /dev/null
  if [ $? -eq 0 ]; then
     echo "You have already installed $1"
  fi
  return $?
}

confirm_install() {
  read -p "Installing $1? (y/n): " choice
  if [[ "$choice" == "y" ]]; then
     return 0
  else
     return 1
  fi
}

install_miniconda() {
    if check_installed "conda"; then
	return 0
    fi
    echo "Installing Miniconda..."
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh

    ~/miniconda3/bin/conda init bash

    return 0
}

install_openssh-server() {
   if check_installed "openssh-server"; then
       return 0
   fi
   echo "Installing openssh-server..."
   sudo apt-get update
   sudo apt-get install openssh-server
   echo "Starting ssh service..."
   sudo systemctl enable ssh --now
   sudo systemctl start ssh
   
   return 0
}

install_tmux() {
    if check_installed "tmux"; then
	return 0
    fi
    echo "Installing tmux..."
    sudo apt-get install tmux

    return 0
}

if confirm_install "Miniconda"; then
    install_miniconda
elif confirm_install "openssh-server"; then
    install_openssh-server
elif confirm_install "tmux"; then
    install_tmux
fi
