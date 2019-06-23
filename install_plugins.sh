printf "# Setting up plugins\n"
source simpleplug.sh

installStart "sensible" "tpope/vim-sensible"
#installStart "vim-gitgutter" "airblade/vim-gitgutter"
installStart "vim-airline" "vim-airline/vim-airline"
installStart "vim-airline-themes" "vim-airline/vim-airline-themes"
installStart "fugitive" "tpope/vim-fugitive"
installStart "vim-commentary" "tpope/vim-commentary"
installStart "vim-easymotion" "easymotion/vim-easymotion"
installStart "vim-ployglot" "sheerun/vim-polyglot"

# opt
#installOpt "onedark.vim" "joshdick/onedark.vim"
#installOpt "ayu-vim" "ayu-theme/ayu-vim"
installOpt "gruvbox" "morhetz/gruvbox"
#installOpt "vim-solarized" "altercation/vim-colors-solarized"
installOpt "papercolor" "NLKNguyen/papercolor-theme"

printf "# Done setting up plugins\n"
