#!/bin/bash
cd terraform || exit
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate* .terraform*

cd ../ansible || exit
rm -f inventory.ini
