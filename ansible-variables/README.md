## Run playbook
ansible-playbook --inventory inventory/playbook/hosts ansible-variables-playbook.yml

## Run playbook with RUNTIME variables
ansible-playbook --inventory inventory/playbook/hosts ansible-variables-playbook.yml --extra-vars '{"version":"1.0.1"}'

## Run playbook with variables from YAML file
ansible-playbook --inventory inventory/playbook/hosts ansible-variables-playbook.yml --extra-vars "@my-vars.yml"
