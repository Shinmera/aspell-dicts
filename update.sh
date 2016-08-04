#!/bin/bash
readonly DICT_FTP="ftp://ftp.gnu.org/gnu/aspell/dict/"

##

readonly TARGET=${1:-run_all}
readonly SCRIPT_DIR=$(dirname $(readlink -f "$0"))
readonly DICT_DIR="$SCRIPT_DIR/ftp.gnu.org/gnu/aspell/dict/"

function eexit() {
    echo "! Error: $@"
    exit 1
}

function latest-file() {
    ls -tp "$1" | grep -v '/$' | head -n +1
}

function download() {
    cd "$SCRIPT_DIR"
    wget -r "$DICT_FTP" \
         || eexit "Failed to download dicts."
}

function remove-outdated-archives() {
    cd "$DICT_DIR"
    rm *.html *.sig */*.sig README
    ## Remove but the most recent file.
    for dict in */; do
        cd "$DICT_DIR/$dict"
        ls -tp | grep -v '/$' | tail -n +2 | xargs -I {} rm -- {}
    done
}

function extract() {
    cd "$DICT_DIR"
    for dict in */; do
        local target="$SCRIPT_DIR/$dict"
        local archive=$(latest-file "$DICT_DIR/$dict")
        echo "Extracting $dict/$archive ..."
        rm -rf "$target"
        mkdir -p "$target"
        tar jxf "$DICT_DIR/$dict/$archive" --strip 1 -C "$target" \
            || eexit "Failed to extract ${archives[1]} to $target."
    done
}

function clean() {
    rm -rf "$SCRIPT_DIR/ftp.gnu.org"
}

function run_all() {
    download
    #remove-outdated-archives
    extract
    clean
}

function main() {
    $TARGET
}

main
