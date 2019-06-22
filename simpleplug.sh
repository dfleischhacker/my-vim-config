#!/bin/bash

# defines utility functions to manage vim plugins downloaded from
# github without using the git command line

log=true
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

  if [[ $packageLocation != https://* ]]; then
    $log && echo "Detected location without protocol, expanding into github URL"
    packageLocation="https://github.com/$packageLocation/tarball/master"
  fi

  if [[ -d $packageName ]]; then
    $log && echo "Directory $packageName already exists, skipping"
    return
  fi

  echo "Downloading plugin $packageName from '$packageLocation'"
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


function dummy {
old_wd=$(pwd)
cd ~/.vim/pack/daniel/start/
cat ~/.vim/plugins.txt | grep -v '^#' | while read line; do
  # extract plugin name and URL from line
  command=${line%% }
  parameters=
  pluginName="${line%%:*}"
  url=$(echo "${line#*:}" | xargs)
  if [[ $url != https://* ]]; then
    echo "Detected location without protocol, expanding into github URL"
    url="https://github.com/$url/tarball/master"
  fi

  if [[ -d $pluginName ]]; then
    echo "Directory $pluginName already exists, skipping"
    continue
  fi

  echo "Downloading plugin $pluginName from '$url'"
  mkdir "$pluginName"
  curl -L "$url" | tar x -C $pluginName --strip-components=1
done
}
