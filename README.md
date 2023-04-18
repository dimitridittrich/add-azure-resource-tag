# add-azure-resource-tag

The bash script "az-resource-tags-update.sh" uses the Azure CLI (Azure Command Line Interface) to update resource tags in Azure.

The script starts by reading the contents of a JSON file named az-tags-update-baseline.json into the VM_LIST variable. It then uses the jq tool to iterate through each line of the JSON file and extract specific information.

For each line of the JSON file, the script extracts information about the ResourceID, SubscriptionName, SubscriptionID and ResourceGroup.

Then the script adds a tag called puppet.node_match with the value equal to the SubscriptionName extracted from the JSON file. Additionally, it adds a second tag called business.environment with a value determined by the if/else condition that checks the name of the extracted resource group. If the resource group name contains the word "dev", the tag value will be "dev". If the resource group name contains the word "stg", the tag value will be "stg". If the resource group name contains the word "prd", the tag value will be "prd".

Finally, the script uses the az tool to update the resource's tags in Azure, using the --operation Merge option to merge the existing tags with the new tags added by the script. The script also uses the --subscription option to define the Azure subscription that will be used to update the tags.

In summary, this script is used to update resource tags in Azure with specific information and can be adapted for different usage scenarios.


The bash script "get-azure-vm-list.sh" in this use case was used to generate a list of all VMs for a given Azure subscription.
