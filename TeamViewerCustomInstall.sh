#!/bin/bash 
# This script downloads and installs custom TeamViewer host based on tjosey's post https://community.jamf.com/t5/jamf-pro/deploying-custom-teamviewer-host-silently-with-password/m-p/234164
# Author: Michael Van den Steen
# Date: 2024-12-20
echo "Downloading and Installing custom TeamViewer host"

# Change current working directory to /tmp
cd /tmp

# Create choices.xml
cat << EOF > choices.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
  <dict>
    <key>attributeSetting</key>
    <integer>1</integer>
    <key>choiceAttribute</key>
    <string>selected</string>
    <key>choiceIdentifier</key>
    <string>com.teamviewer.teamviewerhostSilentInstaller</string>
  </dict>
</array>
</plist>
EOF

#Download, save and install custom TeamViewer.pkg
curl -LO https://dl.teamviewer.com/download/version_15x/CustomDesign/Install%20TeamViewerHost-XXX.pkg --no-progress-meter
sudo installer -applyChoiceChangesXML choices.xml -pkg Install%20TeamViewerHost-XXX.pkg -target /

#Wait 10 seconds before applying account assignment
echo "Going to wait 10 seconds before finishing up"
sleep 10s

#Assignment 
echo "Running the account assignment"
computername=$(hostname -s)
sudo /Applications/TeamViewerHost.app/Contents/Helpers/TeamViewer_Assignment -assignment_id XXXX -device_alias $computername