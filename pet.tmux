#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"

if [ -n "$pet_new_pane_key" ]; then
    tmux bind-key "$pet_new_pane_key" run-shell "$CURRENT_DIR/scripts/new_window.sh #{pane_id} 0" # no copy
fi
if [ -n "$pet_new_pane_copy_key" ]; then
    tmux bind-key "$pet_new_pane_copy_key" run-shell "$CURRENT_DIR/scripts/new_window.sh #{pane_id} 1" # copy to clipboard instead
fi
