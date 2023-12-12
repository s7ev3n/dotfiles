#!/bin/bash

check_installed() {
  type $1 &> /dev/null
  if [ $? -eq 0 ]; then
     echo "You have already installed $1"
     return 0
  else
    return 1
  fi
}

confirm_install() {
  read -p "Installing $1? (y/n): " choice
  if [[ "$choice" == "y" ]]; then
     return 0
  else
     return 1
  fi
}

install_cuda() {
    distro=ubuntu2004
    arch=x86_64
    cuda_ver=11-7
    sudo apt-get install linux-headers-$(uname -r)
    sudo apt-key del 7fa2af80
    wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.1-1_all.deb
    sudo dpkg -i cuda-keyring_1.1-1_all.deb && rm cuda-keyring_1.1-1_all.deb
    sudo apt-get update
    sudo apt-get install cuda-toolkit-$cuda_ver
    sudo apt-get install nvidia-gds
    echo 'Success! You should reboot now !'
    echo 'Check https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu'
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

install_ghq() {
   if check_installed "go-ghq"; then
       if ! check_installed "conda"; then
	   echo "Please install conda first"
	   if confirm_install "Miniconda"; then
		install_miniconda
	   fi
       fi	
   fi
   echo "Installing ghq..."
   conda install -c conda-forge go-ghq
   sudo ln -s /home/wst4sgh/miniconda3/bin/ghq  /usr/bin/ghq
   return 0
}

install_zoxide() {
    if check_installed "zoxide"; then
	echo "installed debug"
	return 0
    fi
    echo "Installing zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
    echo "Successfully installed!"	
    return 0
}

install_poetry() {
    if check_installed "poetry"; then
	echo "installed poetry"
	return 0
    fi
    echo "Installing poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
    echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc
    echo "Successfully installed!"
    return 
}

if confirm_install "Miniconda"; then
    install_miniconda
elif confirm_install "openssh-server"; then
    install_openssh-server
elif confirm_install "tmux"; then
    install_tmux
elif confirm_install "ghq"; then
    install_ghq
elif confirm_install "zoxide"; then
    install_zoxide
fi
