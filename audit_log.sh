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
echo "Capture start and end dates"
echo "###########################################################################"
read -p "Start date format 2023-01-01: " startdate 
read -p "End Date Forma 2023-01-09: " enddate
echo "###########################################################################"
filename=$startdate-$enddate.gzip
echo $filename
#get api key in secured location 
api_key=$(cat kenna_api)

#echo $api_key
echo "###########################################################################"
echo "Pulling audit logs for $startdate-$enddate and display output and format"
echo "###########################################################################" 
curl --request GET --url 'https://api.labs.us.kennasecurity.com/audit_logs/?start_date='$startdate'&end_date='$enddate --header 'X-Risk-Token: '$api_key'' --header 'accept: application/gzip' --output $filename

zcat $filename | jq .
