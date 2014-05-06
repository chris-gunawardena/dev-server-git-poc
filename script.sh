#sudo apt-get update

echo "Create git user"
sudo useradd -m git
echo "git:abcd1234" | sudo chpasswd

echo "Install git"
sudo apt-get install git -y

echo "Install apache"
sudo apt-get install apache2 -y

echo "Clean up apache www folder"
sudo rm -Rf  /var/www/*

echo "Give git group access to apache www folder"
sudo chgrp -R git /var/www
sudo chmod -R g+w /var/www

echo "Create  git repo in git user home"
sudo -u git -i git init --bare /home/git/rmit-public.git

echo "Setup git hook to checkout on commit"
echo "GIT_WORK_TREE=/var/www git checkout -f" | sudo tee -a /home/git/rmit-public.git/hooks/post-update
sudo chmod +x /home/git/rmit-public.git/hooks/post-update


echo "Add chris Public key to /home/git/.ssh/authorized_keys"
sudo -u git -i mkdir /home/git/.ssh
sudo -u git -i touch /home/git/.ssh/authorized_keys
echo "ssh-rsa KEY" | sudo tee -a /home/git/.ssh/authorized_keys

####LOCALLY######
#git remote add dev_server_git ssh://git@127.0.0.1:2222/home/git/rmit-public.git
#git push dev_server_git master
