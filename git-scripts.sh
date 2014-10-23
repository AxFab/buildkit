#!/bin/bash

# =======================================================
# GitHooks
#     Fabien B. <fabien.bavent@gmail.com>
#
# This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# =======================================================

script_sh=`readlink -f $BASH_SOURCE`
script_dir=`dirname $script_sh`


if [ ! -d $PWD/.git ]; then
  echo "The directory is not a git repository" 2>&1; exit -1;
fi

cp -rva  $script_dir/git-hooks/* $PWD/.git/hooks


# -------------------------------------------------------
# -------------------------------------------------------
