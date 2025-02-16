#! /bin/bash

# nvm
read -p "Do you want to install nvm? (y/n): " install_nvm
if [[ "$install_nvm" == "y" ]]; then
    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    nvm install --lts
    echo "Finished installing nvm"
fi

# rye
read -p "Do you want to install rye? (y/n): " install_rye
if [[ "$install_rye" == "y" ]]; then
    echo "Installing rye"
    curl -sSf https://rye.astral.sh/get | bash
    echo "Finished installing rye"
fi

# brew
read -p "Do you want to install linuxbrew? (y/n): " install_brew
if [[ "$install_brew" == "y" ]]; then
    echo "Installing linuxbrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Finished installing linuxbrew"
fi