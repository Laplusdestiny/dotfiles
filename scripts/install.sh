#! /bin/bash

# Install dotfiles
echo "Installing dotfiles..."
DOTFILES_DIR="$(cd "$(dirname "$0")/../dotfiles" && pwd)"
TARGET_DIR="$HOME"
DRYRUN=false

if [ "$1" == "--dryrun" ]; then
    DRYRUN=true
    echo "Dry run mode: No changes will be made."
fi

dotfiles_list=$(find "$DOTFILES_DIR" -maxdepth 1 -type f)

for file in $dotfiles_list; do
    target="$TARGET_DIR/$(basename "$file")"
    if [ "$DRYRUN" == true ]; then
        echo "Would link: $file -> $target"
    else
        ln -sf "$file" "$target"
    fi
done

if [ "$DRYRUN" == false ]; then
    echo "Dotfiles have been symlinked to your home directory."
fi
