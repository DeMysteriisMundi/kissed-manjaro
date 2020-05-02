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

    [[ -d "$2" ]] && {
	log "deleting previously pulled profiles..." && {
	    rm -rf "$2"
	}
    }

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
	  "-b") BUILD=1 ;;
        esac

        shift
    done
}


main() {
    local PROF_DIR="$HOME/iso-profiles"
    local PROF_REPO="https://gitlab.manjaro.org/profiles-and-settings/iso-profiles.git"
    local PROF_CONF="$HOME/.config/manjaro-tools"
    local PROF_BUILD="$PROF_DIR/community/$PROJ_PROF"

    local PROJ_PROF="kissed"
    local PROJ_CONF="./config/manjaro-tools"
    local PROJ_BUILD="./$PROJ_PROF"


    get_opt "$@"


    log "installing..." && {
        log "cloning repository..." && {
            clone_repo "$PROF_REPO" "$PROF_DIR"
        } || terminate "$?"

        log "creating symlinks..." && {
            make_symlink "$PROJ_BUILD" "$PROF_BUILD"

	    mkdir -p "$PROF_CONF"
            make_symlink "$PROJ_CONF" "$PROF_CONF"
        } || terminate "$?"
    }

    [[ "$BUILD" -eq "1" ]] && {
        log "building profile..." && {
	    buildiso -p "$PROJ_PROF"
        } || terminate "$?"
    }

}


main "$@"

