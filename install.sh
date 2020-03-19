#!/usr/bin/env bash


log() {
    # $@ - messages

    # \e[38;5;<NUM>m - set text foreground color
    # \e[m - reset text formatting and color
    printf "\e[38;5;32m=>\e[m %s\n" "$@"
}


clone_repo() {
    # $1 - cloned repository
    # $2 - path to clone it

    git clone "$1" "$2"
}


make_symlink() {
    # $1 - path to file object
    # $2 - path to place the symlink
 
    ln -sr "$1" "$2"
}


get_opt() {
    VERBOSE=0
    QUITE=0

    (:;:)
}


main() {
    local DIST_REPO="https://gitlab.manjaro.org/profiles-and-settings/iso-profiles.git"
   
    local PROF_ROOT="$HOME/iso-profiles"
    local KISSED_PROF="$PROF_ROOT/community/kissed"

    local KISSED_ROOT="kissed"


    get_opt "$@"


    log "cloning repository..." && {
        clone_repo "$DIST_REPO" "$PROF_ROOT"
    } || log "failed!"

    log "making symlink..." && {
        make_symlink "$KISSED_ROOT" "$KISSED_PROF"
    } || log "failed!"
}


main "$@"
