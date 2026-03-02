#!/usr/bin/env bash

download_file() {
    local url="$1"
    local output="$2"
    local max_retries="${3:-5}"
    local attempt=0
    local status=0

    while (( attempt < max_retries )); do
        ((attempt++))
        echo "Attempt $attempt of $max_retries..."

        curl -fL "$url" -o "$output"
        status=$?

        if (( status == 0 )); then
            echo "Download succeeded."
            return 0
        else
            echo "Download failed (curl exit code $status)."
            sleep 2   # optional pause before next try
        fi
    done

    echo "Error: file download failed after $max_retries attempts."
    return 1
}

mkdir -p "$HOME/.kube"
mkdir -p "$HOME/.config/eget"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/Projects"

cat <<'EOF' >>"$HOME/.bashrc"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

alias k=kubectl
alias e=exit
source <(k completion bash)
complete -o default -F __start_kubectl k
source <(yq shell-completion bash)
eval "$(direnv hook bash)"
# eval "$(starship init bash)"
eval "$(fzf --bash)"
EOF

source "$HOME/.bashrc"

URL="https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
OUTPUT="$HOME/.local/bin/kubectl"
download_file "$URL" "$OUTPUT"

chmod +x "$HOME/.local/bin/kubectl"

cp ./eget.toml ~/.config/eget
./eget.sh

eget -D

#
# Install Terraform
#
TERRAFORM_VER=$(curl -sSL https://api.github.com/repos/hashicorp/terraform/releases | jq -Mr '.[].tag_name' | egrep -v 'alpha|beta|rc' | head -1)
curl -sSLO "https://releases.hashicorp.com/terraform/${TERRAFORM_VER:1}/terraform_${TERRAFORM_VER:1}_linux_amd64.zip"
unzip "terraform_${TERRAFORM_VER:1}_linux_amd64.zip" terraform
mv terraform "$HOME/.local/bin/terraform"
"$HOME/.local/bin/terraform" version

#
# install OpenTofu
#
# Download the installer script:
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
# Alternatively: wget --secure-protocol=TLSv1_2 --https-only https://get.opentofu.org/install-opentofu.sh -O install-opentofu.sh

# Grant execution permissions:
chmod +x install-opentofu.sh

# Please inspect the downloaded script at this point.

# Run the installer:
./install-opentofu.sh --install-method standalone --install-path "$HOME/.local/bin"

# Remove the installer:
rm -f install-opentofu.sh
"$HOME/.local/bin/tofu" version

