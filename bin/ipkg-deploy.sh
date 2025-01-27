#!/bin/sh
find ./ipk/ -name "*~" -exec sudo rm {} \;
find ./ipk/ -type f -exec sudo chmod ug+rw {} \;
find ./ipk/ -type f -exec sudo chmod o+r {} \;
find ./ipk/ -type d -exec sudo chmod 775 {} \;
find ./ipk/ -exec sudo chown root {} \;
./ipk-mine.sh
find ./ipk/ -exec sudo chgrp root {} \;
rm *.ipk

#
# generate website from help
#
cd website
cp index.template index.html
replacestring2 {dir} /opt/QtPalmtop/help/.tinyscheme index.html
mv index.html ../ipk/opt/QtPalmtop/help/.tinyscheme/
cd ..

~/bin/ipkg-build.sh ./ipk
scp *.ipk root@zaurus:/mnt/cf/Documents
echo ""
echo -n "Update tinyscheme on web? (y/n) "
read updweb
if [ "$updweb" = "y" ]; then
  tsocks scp *.ipk you@example.com:~/tinyscheme
  cd website
  cp index.template index.html
  replacestring2 {dir} . index.html
  tsocks scp index.html you@example.com:~/public_html/tinyscheme/doc/
  rm index.html
fi
