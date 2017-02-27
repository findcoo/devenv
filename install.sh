#!/bin/bash

# zsh install procedure
sudo apt-get -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# neobundle install procedure
function neobundle_install {
    if [ ! -d "$HOME/.vim/bundle/neobundle.vim" ]; then
        echo "neobundle install start"
        curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > neobundle_install.sh
        sh ./neobundle_install.sh
        rm ./neobundle_install.sh
    fi
}
    
# nvim install procedure
function nvim_install {
    if [ ! -f "/usr/bin/nvim" ]; then
        echo "neovim install start"
        sudo add-apt-repository ppa:neovim-ppa/unstable
        sudo apt-get update
        sudo apt-get install software-properties-common python-software-properties
        sudo apt-get build-dep python-dev python3-dev
        sudo apt-get install python-dev python3-dev neovim

        sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
        sudo update-alternatives --config vi
        sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
        sudo update-alternatives --config vim 
        sudo update-alternatives --install /usr/bin/editor editro /usr/bin/nvim 60
        sudo update-alternatives --config editor
    fi
}

# file environment setup
function file_setup {
    if [ ! -d "$HOME/.config/nvim" ]; then
        echo "config file setup"
        mkdir -p ~/.config/nvim
    fi
    cp -p custom_profile.sh $HOME/.custom_profile.sh
    echo ". $HOME/.custom_profile.sh" >> ~/.zshrc
}

# pyenv install procedure
function pyenv_install {
    if [ ! -d "$HOME/.pyenv" ]; then
        echo "pyenv install start"
        curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
        pyenv update
    fi
}

# docker install procedure
function docker_install {
    if [ ! -f "/usr/bin/docker" ]; then
        echo "docker install start"
	sudo apt-get install -y --no-install-recommends \
	    apt-transport-https \
	    ca-certificates \
	    curl \
	    software-properties-common	
	curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
	apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D
	sudo add-apt-repository \
		"deb https://apt.dockerproject.org/repo/ubuntu-$(lsb_release -cs) main"
        sudo apt-get update
        sudo apt-get install docker-engine
	apt-cache madison docker-engine
        sudo groupadd docker
        sudo usermod -aG docker $(whoami)
    fi
}

function findcoo_setup {
    echo "setup utility on the desktop"
    neobundle_install
    nvim_install
    file_setup
    pyenv_install
    docker_install
}

