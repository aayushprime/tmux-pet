#!/usr/bin/env bash

# $1 ... tmux pane ID

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/variables.sh"

if ! which $pet_path > /dev/null 2>&1; then
    tmux display-message "$pet_path is not found."
    return
fi

get_clip_cmd() {
  if command -v pbcopy &>/dev/null; then
    echo "pbcopy"
  elif command -v xclip &>/dev/null; then
    echo "xclip -selection clipboard"
  elif command -v xsel &>/dev/null; then
    echo "xsel --clipboard --input"
  elif grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    echo "clip.exe"
  else
    echo "cat"
  fi
}

if [[ "$2" == "0" ]]; then
    tmux new-window tmux\ send-keys\ \-t\ $1\ \"\$\($pet_path\ search\)\"
elif [[ "$2" == "1" ]]; then
  tmux new-window "$pet_path search | $(get_clip_cmd)"
else
  echo "Second argument is not 0 or 1"
fi
