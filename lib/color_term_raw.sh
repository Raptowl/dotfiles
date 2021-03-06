. "$DOTFILES_DIR/lib/put_background_color.sh"
. "$DOTFILES_DIR/lib/put_bold_color.sh"
. "$DOTFILES_DIR/lib/put_foreground_color.sh"
. "$DOTFILES_DIR/lib/put_reset_color.sh"
color_term_raw() {
  # Print color text to console by raw code
  # Globals:
  #   None
  # Arguments:
  #   [-b], bold color switch
  #   foreground color
  #   background color
  #   body text
  # Outputs:
  #  string with raw color code
  # Returns:
  #   success, 0
  #   invalid specifier, 1
  l_prefix=''
  while :; do
    case "$1" in
      -b) l_prefix="${l_prefix}""$(put_bold_color)" ;;
      * ) break ;;
    esac
    shift 1
  done
  if [ $# -ne 3 ]; then
    unset l_prefix
    return 1
  fi

  l_fore_color=$(put_foreground_color "$1")
  l_back_color=$(put_background_color "$2")
  l_body_text=$(printf '%s' "$3")
  printf '%s' \
         "${l_prefix}${l_fore_color}${l_back_color}${l_body_text}"\
         "$(put_reset_color)"

  unset l_prefix l_fore_color l_back_color l_body_text
  return 0
}
