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
    [[ ! -d "$2" ]] && ln -sr "$1" "$2" || {
        printf "'%s' already exists\n" "$2" >&2
        return 1
    }
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

    local KISSED_ROOT="./kissed"


    get_opt "$@"

    log "cloning repository..." && {
        clone_repo "$DIST_REPO" "$PROF_ROOT"
    } || terminate "$?"

    log "making symlink..." && {
        make_symlink "$KISSED_ROOT" "$KISSED_PROF"
    } || terminate "$?"
}


main "$@"