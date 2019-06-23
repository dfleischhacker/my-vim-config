#!/bin/bash

# defines utility functions to manage vim plugins downloaded from
# github without using the git command line

#set -xv
activeGroup="default"
installDir="${HOME}/.vim"

function setInstallDir {
  installDir="$1"
}

# sets the group to install packages to
function setGroup {
  activeGroup=$1
}

function ensureDir {
  dir="$1"
  if [[ ! -d $dir ]]; then
    mkdir -p $dir
  fi
}

function ensureActiveGroup {
  ensureDir "${installDir}/pack/$activeGroup"
}

function installInto {
  packageType="$1"
  packageName="$2"
  packageLocation="$3"

  ensureActiveGroup
  oldPwd=$(pwd)

  ensureDir "${installDir}/pack/${activeGroup}/${packageType}"
  cd "${installDir}/pack/${activeGroup}/${packageType}"

  printf "# Installing plugin '$packageName'\n"

  if [[ $packageLocation != https://* ]]; then
    packageLocation="https://github.com/$packageLocation/tarball/master"
  fi

  if [[ -d $packageName ]]; then
    printf "  -> Destination directory already exists, skipping\n"
    return
  fi

  printf "  -> Downloading from '$packageLocation'\n"
  mkdir "$packageName"
  curl -# -L "$packageLocation" | tar x -C $packageName --strip-components=1

  cd "$oldPwd"
}

# install a new package into the start directory of the currently active group
function installStart {
  packageName="$1"
  packageLocation="$2"
  installInto "start" "$packageName" "$packageLocation"
}

# install a new package into the opt directory of the currently active group
function installOpt {
  packageName="$1"
  packageLocation="$2"
  installInto "opt" "$packageName" "$packageLocation"
}

