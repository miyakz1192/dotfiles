echo "install java"
sudo yum install java-1.8.0-openjdk wget -y

echo "install rsense"
wget http://cx4a.org/pub/rsense/rsense-0.3.tar.bz2
bzip2 -dc rsense-0.3.tar.bz2 | tar xvf -
sudo cp -r rsense-0.3 /usr/local/lib
sudo chmod +x /usr/local/lib/rsense-0.3/bin/rsense

echo "install rubocop ref2"
sudo gem install rubocop refe2

echo "build reference"
bitclust setup

echo "check pip"
python -m pip -V 2>&1 1> /dev/null | grep "No module named pip" > /dev/null
if [ $? -eq 0 ]; then
  echo "installing pip"
  curl -kL https://bootstrap.pypa.io/get-pip.py | python
fi

