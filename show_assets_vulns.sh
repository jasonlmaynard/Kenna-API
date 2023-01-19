#!/bin/bash
#
echo "############################################################################"
echo "Created by Jason Maynard"
echo "Youtube Channel: https://www.youtube.com/channel/UCwnm1oSSz8pPwDyfzFS5k3w"
echo "Github: https://github.com/jasonlmaynard"
echo "###########################################################################"
echo ""
echo ""
api_key=$(cat kenna_api)
#echo $api_key
echo "###########################################################################"
read -p "Enter the asset_id: " assetid
echo "###########################################################################"
echo "Displaying vulns for $assetid"
echo "###########################################################################"
curl --request GET --url https://api.labs.us.kennasecurity.com/assets/$assetid/vulnerabilities --header 'X-Risk-Token: '$api_key'' --header 'accept: application/json' | jq .

