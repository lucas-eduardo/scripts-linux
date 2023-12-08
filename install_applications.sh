#!/bin/bash

# Atualiza os pacotes existentes
sudo apt-get update

# Remove o Firefox e o LibreOffice
sudo apt-get remove --purge -y firefox libreoffice*
sudo apt-get autoremove -y

# Instala dependências necessárias
sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common git

# Verifica e instala o VSCode
if ! command -v code &> /dev/null
then
    curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get update
    sudo apt-get install -y code
else
    echo "VSCode já está instalado."
fi

# Verifica e instala o Docker
if ! command -v docker &> /dev/null
then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
else
    echo "Docker já está instalado."
fi

# Verifica e instala o Microsoft Edge
if ! command -v microsoft-edge &> /dev/null
then
    curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /usr/share/keyrings/microsoft-edge.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
    sudo apt update
    sudo apt install -y microsoft-edge-stable
else
    echo "Microsoft Edge já está instalado."
fi

# Verifica e instala o Google Chrome
if ! command -v google-chrome &> /dev/null
then
    sudo wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome já está instalado."
fi

echo "Instalação concluída!"

