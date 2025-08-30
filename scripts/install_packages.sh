#! /bin/bash

# nvm
read -p "Do you want to install nvm? (y/n): " install_nvm
if [[ "$install_nvm" == "y" ]]; then
    echo "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    nvm install --lts
    echo "Finished installing nvm"
fi

# uv
read -p "Do you want to install uv? (y/n): " install_uv
if [[ "$install_uv" == "y" ]]; then
    echo "Installing uv"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "Finished installing uv"
fi

# brew
read -p "Do you want to install linuxbrew? (y/n): " install_brew
if [[ "$install_brew" == "y" ]]; then
    echo "Installing linuxbrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Finished installing linuxbrew"
fi
