# Automation
## This Playbook install Kubernetes using kubeadm in Ubuntu 20.04

### Prerequisite
1. Create and edit file in /etc/sudoers.d/<your-user>
```bash
<your-user> ALL=(ALL) NOPASSWD:ALL
```

2. Executre ansible playbook to install kubeadm
```bash
ansible-playbook playbook.yaml
```
