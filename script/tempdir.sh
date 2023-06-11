#!/bin/bash
#   vim: colorcolumn=80

HOME_CACHE=${HOME}/.cache/cmake.build

function mkdir_local_cache() {
    dir_name=$1
    set -e
    if [ ! -d ${HOME_CACHE} ];then
        mkdir -p ${HOME_CACHE}
    fi

    if [ ! -e $dir_name ];then
        cache_dir=$(mktemp -d -p ${HOME_CACHE})
        ln -sf ${cache_dir} $(dir_name)
    fi
}
