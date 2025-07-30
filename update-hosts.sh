#!/bin/bash

# Path to your Ansible hosts file
HOSTS_FILE="inventory/playbook/hosts"

# Extract all existing IPs (lines that start with an IP and are followed by a key)
OLD_IPS=($(grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' "$HOSTS_FILE" | awk '{print $1}'))

# Count how many old IPs we found
NUM_OLD_IPS=${#OLD_IPS[@]}

# Prompt the user for the same number of new IPs
echo "Found $NUM_OLD_IPS host(s) in $HOSTS_FILE"
read -p "Enter $NUM_OLD_IPS new IP(s), separated by space: " -a NEW_IPS

# Check if number of new IPs matches
if [ "${#NEW_IPS[@]}" -ne "$NUM_OLD_IPS" ]; then
  echo "❌ Error: Expected $NUM_OLD_IPS IPs, but got ${#NEW_IPS[@]}"
  exit 1
fi

# Replace each old IP with the corresponding new IP
for ((i=0; i<$NUM_OLD_IPS; i++)); do
  OLD="${OLD_IPS[$i]}"
  NEW="${NEW_IPS[$i]}"
  
  # Validate new IP format
  if [[ ! $NEW =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Invalid IP format: $NEW"
    exit 1
  fi

  # Replace only the first occurrence of OLD with NEW (in order)
  sed -i "0,/$OLD/{s/$OLD/$NEW/}" "$HOSTS_FILE"
  echo "✅ Replaced $OLD ➜ $NEW"
done

echo "✅ All IPs updated successfully in $HOSTS_FILE"

