# How to install Ansible-Core with UV - Part 1

Latest version of `terraform` and `tofu` will be installed in $HOME/.local/bin.

```bash
bash ./setup.sh
source ~/.bashrc
cd "$HOME"
mkdir Projects
cd Projects
git clone https://github.com/learnf5/f5xc.git
cd f5xc
```

## Uploading Files to Google Cloud Shell

### Methods to Upload Files

You can upload files to Google Cloud Shell using several methods:

| Method | Description |
| --- | --- |
| **Cloud Shell Menu** | Click the Cloud icon in the menu bar and select "Upload." Choose the file you want to upload. |
| **Cloud Shell Command** | Use the command: `cloudshell upload <file_name>` to upload files directly from your local machine. |
| **Cloud Shell Editor** | In the Cloud Shell Editor, right-click in the Explorer pane and select "Upload Files." |

### Important Notes

*   Files are uploaded to the `$HOME` directory of your Cloud Shell instance.
*   You can only download files from the `$HOME` directory as well.
*   Ensure you have a Google account and access to the Google Cloud Console to use Cloud Shell.

### Steps to Upload Files

1.  **Open Google Cloud Console**: Go to [Google Cloud Console](https://console.cloud.google.com).
2.  **Launch Cloud Shell**: Click the Cloud Shell icon (terminal symbol) in the top-right corner.
3.  **Choose Upload Method**: Select one of the methods listed above to upload your files.

