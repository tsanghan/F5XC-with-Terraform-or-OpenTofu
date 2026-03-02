#!/usr/bin/env bash

mkdir -p "$HOME/.local/bin"
cat <<'EOF' >>"$HOME/.bashrc"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
EOF

source "$HOME/.bashrc"
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
tofu version
