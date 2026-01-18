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

# Starship
read -p "Do you want to install Starship? (y/n): " install_starship
if [[ "$install_starship" == "y" ]]; then
    echo "Installing Starship"
    curl -sS https://starship.rs/install.sh | sh
    echo "Finished installing Starship"
fi

# locale, language-pack-ja
read -p "Do you want to install locale and language-pack-ja? (y/n): " install_locale
if [[ "$install_locale" == "y" ]]; then
    echo "Installing locale and language-pack-ja"
    sudo apt-get update
    sudo apt-get install -y locales language-pack-ja
    sudo locale-gen ja_JP.UTF-8
    echo "Finished installing locale and language-pack-ja"
fi
