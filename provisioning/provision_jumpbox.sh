#!/bin/bash -e

systemctl daemon-reload
systemctl enable redis
systemctl start redis
systemctl enable squid
systemctl start squid
systemctl enable nginx
systemctl start nginx
# Update six for newer ansible-runner
pip install --upgrade six
pip install --upgrade avisdk 
pip install --upgrade pip
pip install --upgrade setuptools
pip uninstall -y ansible
pip install ansible-base
pip install ansible
ansible-galaxy install avinetworks.avisdk avinetworks.aviconfig --force
git clone git://github.com/ansible/ansible-runner /tmp/ansible-runner
yum install -y bind-utils vim tmux jq
pip install /tmp/ansible-runner/
chmod +x /usr/local/bin/handle_bootstrap.py
chmod +x /usr/local/bin/handle_register.py
chmod +x /usr/local/bin/cleanup_controllers.py
systemctl enable handle_bootstrap
systemctl enable handle_register
systemctl start handle_bootstrap
systemctl start handle_register
chmod +x /etc/ansible/hosts
cp /usr/local/bin/register.py /usr/share/nginx/html/
cp /etc/ansible/hosts /opt/bootstrap/inventory
#Nasty, nasty, very very nasty...
sleep 5
/usr/local/bin/register.py localhost
