#!/usr/bin/bash

# get password
read -s -p "Enter Password for sudo: " sudoPW
# install update
echo $sudoPW | sudo -S apt update
echo $sudoPW | sudo -S apt upgrade -y
# install snap
echo $sudoPW | sudo -S apt install snapd
echo $sudoPW | sudo -S systemctl enable --now snapd apparmor
# install vscode
echo $sudoPW | sudo -S snap install code --classic
echo "# vscode alias" >> ~/.zshrc
echo "alias code='snap run code'" >> ~/.zshrc
# install obsidian
wget "https://github.com/obsidianmd/obsidian-releases/releases/download/v0.12.3/obsidian_0.12.3_amd64.snap" -O /tmp/obsidian.snap
echo $sudoPW | sudo -S snap install --dangerous /tmp/obsidian.snap
echo "# obsidian alias" >> ~/.zshrc
echo "alias obsidian='snap run obsidian'" >> ~/.zshrc
# install pyenv
echo $sudoPW | sudo -S apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl https://pyenv.run | bash
echo '# pyenv config' >> ~/.zshrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
# change default shell
# run these commands manually
# chsh -s $(which $SHELL)
# logout and in
# open code: `code`
# open obsidian: `obsidian`
# test pyenv: `pyenv`
# install bpython for interactive development
pyenv install 3.9.5
pyenv virtualenv 3.9.5 interactive
pyenv activate interactive
pip install bpython

# activate night light for the GNOME GUI
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
# create ssh key
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y 2>&1 >/dev/null
