cd $HOME
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

service ssh start
ssh -T -oStrictHostKeyChecking=no localhost
exit
