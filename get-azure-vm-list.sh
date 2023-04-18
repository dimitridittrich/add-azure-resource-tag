#!/bin/bash
SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
SUBSCRIPTION_NAME="subscriptions-name-corp-example"

az vm list --subscription $SUBSCRIPTION_ID --query "[].{VMName:name, ResourceID:id, ResourceGroup:resourceGroup, SubscriptionName:'$SUBSCRIPTION_NAME', SubscriptionID:'$SUBSCRIPTION_ID', Tags:tags}" -o json > "${SUBSCRIPTION_NAME}.json"
