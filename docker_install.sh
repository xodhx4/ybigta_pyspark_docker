# install dependency
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

# Add docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install docker-ce
sudo apt-get update
sudo apt-get install docker-ce -y

sudo usermod -aG docker $USER
