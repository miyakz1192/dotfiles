echo "building ctags env(TypeScript)"

ctags --version | grep -i universal > /dev/null
if [ $? -ne 0 ]; then
  echo "universal ctags is not found. install it?[y/n]"
  read input
  if [ "${input}" != "y" ]; then
    echo "cancel"
    exit 1
  fi
else
  echo "universal ctags is already installed in this environment."
  exit 0
fi

echo "install universal ctag"

git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make 
make install

git clone https://github.com/miyakz1192/typescript-ctags.git
mkdir -p ~/.ctags.d/
cp typescript-ctags/.ctags ~/.ctags.d/typescript.ctag



