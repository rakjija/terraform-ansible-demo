#!/bin/bash
cd terraform || exit
terraform init
terraform apply -auto-approve

# Get Public IP
PUBLIC_IP=$(terraform output -raw public_ip)
echo "EC2 Public IP: $PUBLIC_IP"

# Check EC2 Instance Status
echo "Check EC2 Instance's Status..."
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=ip-address,Values=$PUBLIC_IP" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text)

for _ in {1..30}; do
  STATUS=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query "Reservations[*].Instances[*].State.Name" \
    --output text)

    echo "Instance Status: $STATUS"
    if [[ "$STATUS" == "running" ]]; then
      echo "Instance is Running!"
      break
    fi

    sleep 10
done

# Generate inventory
cd ../ansible || exit
echo "$PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa" > inventory.ini

# Run Ansible
ansible-playbook -i inventory.ini nginx.yml
