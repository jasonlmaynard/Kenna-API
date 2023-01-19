#!/bin/bash
#
echo "############################################################################"
echo "Created by Jason Maynard"
echo "Youtube Channel: https://www.youtube.com/channel/UCwnm1oSSz8pPwDyfzFS5k3w"
echo "Github: https://github.com/jasonlmaynard"
echo "###########################################################################"
echo ""
echo ""
echo "###########################################################################"
echo "Capture the details to add the asset"
echo "###########################################################################"
read -p "Enter Hostname: " hostname
read -p "Enter IP adderess ex: 1.1.1.1: " ipaddress
read -p "Enter OS: " os 
read -p "Enter Owner EX: BU Owners: " owner
echo "###########################################################################"
#get api key in secured location 
api_key=$(cat kenna_api)
#echo $api_key

echo "###########################################################################"
read -p "Press ENTER to add asset: $hostname, $ipaddress, $os, $owner"
echo "###########################################################################"
curl --request POST --url https://api.labs.us.kennasecurity.com/assets --header 'X-Risk-Token: '$api_key'' --header 'accept: application/json' --header 'content-type: application/json' --data ' 
{
     "asset": {
          "hostname": "'$hostname'",
          "ip_address": "'$ipaddress'",
          "operating_system": "'$os'",
	  "owner": "'$owner'"
     }
}
' > output.log  
#
echo "###########################################################################"
echo "Reading output.log to capture asset_id and then delete output.log"
echo "###########################################################################"
assetid=$(cat output.log | awk -F: '{print $3}' | awk -F, '{print $1}')
rm output.log
echo $assetid
echo 
echo "###########################################################################"
echo " Waiting 30 seconds to display asset $assetid output: "
echo "###########################################################################"
sleep 30
curl --request GET --url https://api.labs.us.kennasecurity.com/assets/$assetid --header 'X-Risk-Token: '$api_key'' --header 'accept: application/json' | jq .
echo 
echo "###########################################################################"
read -p "Enter any key to add vulnerabilty to asset $assetid: "
echo "###########################################################################"
echo ""
echo "###########################################################################"
read -p "Adding a CVE to asset $assetid. EX:CVE 2021-44228 = ID 78. Enter ID: " vulnid
echo "###########################################################################"
curl --request PUT --url https://api.labs.us.kennasecurity.com/vulnerabilities/$vulnid --header 'X-Risk-Token: '$api_key'' --header 'accept: application/json' --header 'content-type: application/json' --data '
{
     "vulnerability": {
          "asset_id": "'$assetid'",
          "status": "open"
     }
}
'
echo "###########################################################################"
read -p "Validate assigned vulns to $assetid. Enter to Continue : " 
echo "###########################################################################"
echo " Waiting 30 seconds to display output: "
sleep 30
curl --request GET --url https://api.labs.us.kennasecurity.com/assets/$assetid/vulnerabilities --header 'X-Risk-Token: '$api_key'' --header 'accept: application/json' | jq .

