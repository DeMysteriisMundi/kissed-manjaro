#!/usr/bin/env bash


log() {
    # $@ - messages

    # \e[38;5;<NUM>m - set text foreground color
    # \e[m - reset text formatting and color
    printf "\e[38;5;32m=>\e[m %s\n" "$@"
}


terminate() {
    # $1 - error code

    log "failed!"
    exit "$1"
}


clone_repo() {
    # $1 - cloned repository
    # $2 - path to clone it

    git clone "$1" "$2"
}


make_symlink() {
    # $1 - path to file object
    # $2 - path to place the symlink

    # 'ln' must not create the symlink within
    # the same name file.
    ln -snfr "$1" "$2"
}


get_opt() {
    # $1 - just an option

    while [[ -n "$1" ]]
    do
        case "$1" in
          "-q") exec 1>/dev/null && exec 2>/dev/null;;
          "-v") exec 2>/dev/null ;;
        esac

        shift
    done
}


main() {
    local DIST_REPO="https://gitlab.manjaro.org/profiles-and-settings/iso-profiles.git"
   
    local PROF_ROOT="$HOME/iso-profiles"
    local KISSED_PROF="$PROF_ROOT/community/kissed"

    local CONF_DIR="$HOME/.config/manjaro-tools"

    local KISSED_ROOT="./kissed"
    local KISSED_CONF="./config/manjaro-tools"


    get_opt "$@"

    log "cloning repository..." && {
        clone_repo "$DIST_REPO" "$PROF_ROOT"
    } || terminate "$?"

    log "making project symlink..." && {
        make_symlink "$KISSED_ROOT" "$KISSED_PROF"
    } || terminate "$?"

    log "making configuration symlink..." && {
        make_symlink "$KISSED_CONF" "$CONF_DIR"
    } || terminate "$?"
}


main "$@"
