#!/bin/bash

echo "Checking if node is already installed"
node -v 2> /dev/null
if [[ $? == 0 ]]; then
    echo "node is already installed, exiting the script"
    exit 1
fi

echo "Node is not installed, Continuing Installation....."
echo ""
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash  1>  /dev/null 2>  /dev/null
echo ""
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "Select version to install from the list"
echo -e "v16.10.0 \nv17.9.1 \nv18.14.0 \nv20.4.0 \nv19.5.0"
echo ""
read -p "Enter Number Corresponding to the node version: " version
echo ""
echo "Installing node version $version.."

nvm install $version
if [[ $? != 0 ]]; then
    echo "Incorrect version, please re-run the script"
    exit 1
fi
echo ""

echo "Node version: $(node -v)"
echo ""
echo "nvm version: $(nvm -v)"

node -v