#!/bin/bash

# オプション解析
VERBOSE=0
DRY_RUN=0

while [ $# -gt 0 ]; do
    case "$1" in
        -v|--verbose)
            VERBOSE=1
            DRY_RUN=1
            shift
            ;;
        --check)
            VERBOSE=1
            DRY_RUN=1
            shift
            ;;
        *)
            echo "Usage: $0 [-v|--verbose|--check]"
            echo "  -v, --verbose, --check: Show what would be linked without creating actual links"
            exit 1
            ;;
    esac
done

dotfiles_root=$(cd $(dirname $0)/.. && pwd)
config_file="${dotfiles_root}/dotfiles/link.conf"

# マッピングファイルの存在確認
if [ ! -f "${config_file}" ]; then
    echo "Error: ${config_file} not found"
    exit 1
fi

if [ $VERBOSE -eq 1 ]; then
    echo "=== Checking symlink mappings ==="
    echo "Config file: ${config_file}"
    echo ""
fi

# マッピングファイルを読み込んでシンボリックリンクを作成
while IFS=$'\t' read -r file dest; do
    # コメント行とブラブ行をスキップ
    case "$file" in
        ''|'#'*) continue ;;
    esac

    src="${dotfiles_root}/dotfiles/${file}"

    # 環境変数を展開
    dest_expanded=$(eval echo "${dest}")

    if [ $VERBOSE -eq 1 ]; then
        echo "---"
        echo "Source file: ${file}"
        echo "Source path: ${src}"
        echo "Destination: ${dest_expanded}"

        # ソースファイルの存在確認
        if [ ! -e "${src}" ]; then
            echo "Status: ⚠️  Source file NOT found"
        else
            echo "Status: ✓ Source file exists"
        fi

        # リンク先の状態確認
        if [ -L "${dest_expanded}" ]; then
            current_link=$(readlink "${dest_expanded}")
            echo "Current: → Symlink exists (points to: ${current_link})"
            if [ "${current_link}" = "${src}" ]; then
                echo "         (Already linked correctly)"
            else
                echo "         (Points to different location)"
            fi
        elif [ -e "${dest_expanded}" ]; then
            echo "Current: Regular file/directory exists (will be backed up)"
        else
            echo "Current: Does not exist (will be created)"
        fi
        echo ""
        continue
    fi

    # ソースファイルの存在確認
    if [ ! -e "${src}" ]; then
        echo "Warning: source file not found: ${src}"
        continue
    fi

    # リンク先のディレクトリを作成
    dest_dir=$(dirname "${dest_expanded}")
    mkdir -p "${dest_dir}"

    # 既存のファイル/リンク処理
    if [ -e "${dest_expanded}" ] || [ -L "${dest_expanded}" ]; then
        echo "Backing up: ${dest_expanded} -> ${dest_expanded}.bak"
        mv "${dest_expanded}" "${dest_expanded}.bak"
    fi

    # シンボリックリンク作成
    ln -sv "${src}" "${dest_expanded}"
done < "${config_file}"

if [ $VERBOSE -eq 1 ]; then
    echo "=== Check complete! ==="
    echo "Run without --verbose to create the actual symlinks."
else
    echo "Done!"
fi
