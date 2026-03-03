# How to install Ansible-Core with UV - Part 1

Latest version of `terraform` and `tofu` will be installed in $HOME/.local/bin.

```bash
bash ./setup.sh
source ~/.bashrc
cd "$HOME/Projects"
git clone https://github.com/learnf5/f5xc.git
cd f5xc/xc-waap-course/automation/terraform
```

Create empty *terraform.tfvars* file
```none
cat <<EOF >terraform.tfvars
domains                  = ""
name                     = ""
namespace                = ""
origin_pool_service_name = ""
origin_pool_virtual_site = ""
EOF
```

Creating a *Makefile*
```none
# Source - https://stackoverflow.com/a/3733987
# Posted by chuck
# Retrieved 2026-03-03, License - CC BY-SA 2.5
TAB="$(printf '\t')"
cat <<EOF >Makefile
.PHONY: clean
.PHONY: deep-clean

clean:
${TAB}rm -f *.tfstate
${TAB}rm -f *.tfstate.backup
${TAB}rm -f *.tfplan

deep-clean:
${TAB}make clean
${TAB}rm -rf .terraform
${TAB}rm -f .terraform.lock.hcl
EOF
```

Creating a *Justfile*
```none
cat <<EOF >Justfile
clean:
    rm -f *.tfstate
    rm -f *.tfstate.backup
    rm -f *.tfplan

deep-clean:
    just clean
    rm -rf .terraform
    rm -f .terraform.lock.hcl
EOF
```

Creating a *Taskfile*
```none
cat <<EOF >Taskfile.yaml
version: '3'

tasks:
  clean:
    desc: Remove Terraform state and plan files
    cmds:
    - rm -f *.tfstate
    - rm -f *.tfstate.backup
    - rm -f *.tfplan

  deep-clean:
    desc: Remove Terraform plugin/state directory
    cmds:
    - task clean
    - rm -rf .terraform
    - rm -f .terraform.lock.hcl
EOF
```

## Uploading Files to Google Cloud Shell

### Methods to Upload Files

You can upload files to Google Cloud Shell using methods below:

| Method | Description |
| --- | --- |
| **Cloud Shell Menu** | Click the 3-dot icon in the menu bar and select "Upload". Choose the file you want to upload. |
| **Cloud Shell Editor** | In the Cloud Shell Editor, right-click in the Explorer pane and select "Upload...". |

