#!/bin/bash

VM_LIST=$(cat az-resource-tags-update.json)

for row in $(echo "${VM_LIST}" | jq -r '.[] | @base64'); do
    _jq() {
     echo "${row}" | base64 --decode | jq -r "${1}"
    }

    RESOURCE_ID=$(_jq '.ResourceID')
    TAG_NAME1="puppet.node_match"
    SUBSCRIPTION_NAME=$(_jq '.SubscriptionName')
    TAG_VALUE1="$SUBSCRIPTION_NAME"
    SUBSCRIPTION_ID=$(_jq '.SubscriptionID')

    # Add tag business.environment
    RESOURCE_GROUP=$(_jq '.ResourceGroup')
    if echo "$RESOURCE_GROUP" | grep -qi "dev"; then
        TAG_NAME2="business.environment"
        TAG_VALUE2="dev"
    elif echo "$RESOURCE_GROUP" | grep -qi "stg"; then
        TAG_NAME2="business.environment"
        TAG_VALUE2="stg"
    elif echo "$RESOURCE_GROUP" | grep -qi "prd"; then
        TAG_NAME2="business.environment"
        TAG_VALUE2="prd"
    fi


    az account set --subscription $SUBSCRIPTION_ID
    az tag update --resource-id $RESOURCE_ID --operation Merge --tags "$TAG_NAME1=$TAG_VALUE1" "$TAG_NAME2=$TAG_VALUE2"
done
