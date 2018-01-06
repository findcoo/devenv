#!/bin/bash

OSTYPE=$(uname)

case $OSTYPE in
    Linux)
        issue=$(cat /etc/issue | grep Ubuntu | awk '{print $1}')

        if [ ! -z $issue ]; then
            OSTYPE=Ubuntu
        else
            echo "don't support linux distribution"
            exit 0
        fi
        ;;
    Darwin)
        echo "install programs on OS X"
        ;;
    *)
        echo "don't support os"
        exit 0
        ;;
esac

# zsh
function install_zsh {
    echo "install zsh"
    case $OSTYPE in
        Darwin) brew install zsh
            ;;
        Ubuntu) apt-get -y install zsh
            ;;
    esac
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

# neobundle
function install_neobundle {
    echo "install neobundle"
    if [ ! -d "$HOME/.vim/bundle/neobundle.vim" ]; then
        curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > neobundle_install.sh
        sh ./neobundle_install.sh
        rm ./neobundle_install.sh
    else
        echo "neobundle already installed"
    fi
}
    
# nvim install procedure
function install_neovim {
    echo "install neovim"
    case $OSTYPE in
        Ubuntu)
            if [ ! -f "/usr/bin/nvim" ]; then
                apt-get install -y software-properties-common python-software-properties
                add-apt-repository ppa:neovim-ppa/stable
                apt-get update
                apt-get build-dep python-dev python3-dev
                apt-get install -y python-dev python3-dev neovim

                update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
                update-alternatives --config vi
                update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
                update-alternatives --config vim 
                update-alternatives --install /usr/bin/editor editro /usr/bin/nvim 60
                update-alternatives --config editor
            else
                echo "neovim already installed"
            fi
            ;;
        Darwin)
            brew install neovim/neovim/neovim 
            ;;
    esac
}

# vim configuration
function file_setup {
    if [ ! -d "$HOME/.config/nvim" ]; then
        echo "install vim configuration file"
        mkdir -p ~/.config/nvim
        cp init.vim ~/.config/nvim/
    else
        echo "vim configuration already installed"
    fi
    cp -p custom_profile.sh $HOME/.custom_profile.sh
    echo ". $HOME/.custom_profile.sh" >> ~/.zshrc
}

# install pyenv
function install_pyenv {
    echo "install pyenv"
    if [ ! -d "$HOME/.pyenv" ]; then
        curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
        pyenv update
    else
        echo "pyenv already installed"
    fi
}

# install docker
function install_docker {
    echo "install docker"
    if [ ! -f "/usr/bin/docker" ]; then
        apt-get install -y --no-install-recommends \
            apt-transport-https \
            ca-certificates \
            curl \
            software-properties-common	
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
        apt-key fingerprint 0EBFCD88
        add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable"
        apt-get update
        apt-get install -y docker-ce
        groupadd docker
        usermod -aG docker $(whoami)
    fi

    if [ $OSTYPE == "Darwin" ]; then
        echo "visit https://store.docker.com/editions/community/docker-ce-desktop-mac"    
    fi
}

# install fzf
function install_fzf {
    echo "install fzf"
    case $OSTYPE in
        Ubuntu)
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
	    apt-get install silversearcher-ag
            ;;
        Darwin)
            brew install fzf
            /usr/local/opt/fzf/install
            ;;
    esac
}

# install go
function install_go {
    echo "install go"
    case $OSTYPE in
        Ubuntu)
            wget "https://storage.googleapis.com/golang/go1.9.2.linux-amd64.tar.gz"
            tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz
            ;;
        Darwin)
            echo "visit https://golang.org/doc/install"
            ;;
    esac
    rm "go1.9.2.linux-amd64.tar.gz"
}

# install nvm
function install_nvm {
	echo "install nvm"
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
}

function setup {
    echo "start all installation progress"
    install_zsh
    install_neobundle
    install_neovim
    file_setup
    install_pyenv
    install_docker
    install_go
    install_fzf
    install_nvm
}

case $1 in
    docker) install_docker
        ;;
    pyenv) install_pyenv
        ;;
    go) install_go
        ;;
    fzf) install_fzf
        ;;
    nvm) install_nvm
        ;;
    all) setup
        ;;
esac 
