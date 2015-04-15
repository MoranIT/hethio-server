#! /bin/bash
# see http://www.wefearchange.org/2010/05/from-python-package-to-ubuntu-package.html



#====================================
# PRE-COMPILE
python setup.py \
--command-packages=stdeb.command debianize \
--suite `lsb_release -sc`


# ===================================
# ADD COMMIT MESSAGES TO CHANGELOG
VERSION=`git tag | tail -n 1`

TOPLINE=`head -n 1 debian/changelog`
BOTTOMLINE=`tail -n 1 debian/changelog`

echo $TOPLINE > debian/changelog
echo "" >> debian/changelog
git shortlog $VERSION..HEAD | tail -n+2 | while read line
do
  if [ -n "$line" ]; then
    echo "  * $line" >> debian/changelog
  fi
done
echo "" >> debian/changelog
echo "$BOTTOMLINE" >> debian/changelog


VERSION=`cat VERSION.txt`
cp debian/changelog ./hethio-server_$VERSION.changes



#====================================
# PREPARE AND COMPILE MAN PAGES
find ./man -type f -exec sed -i "s/{VERSION}/$VERSION/g" {} +

DATESTAMP=`date +"%d %b %Y"`
find ./man -type f -exec sed -i "s/{DATESTAMP}/$DATESTAMP/g" {} +

# Zip up man page for installation
gzip man/hethio-server.8




# ===================================
# RUN SETUP
echo '3.0 (native)' > debian/source/format
python setup.py sdist
cp dist/hethio-server-$VERSION.tar.gz ../hethio-server_$VERSION.orig.tar.gz


# ===================================
# BUILD DEB PACKAGE FOR TESTING
dpkg-buildpackage -rfakeroot -uc -us


# ===================================
# SIGN AND PACKAGE
debuild -S -sa


# ===================================
# OUTPUT BUILD SCRIPT TO CONSOLE
echo '------------------' | cat - ../hethio-server*.build > temp && mv temp ../hethio-server*.build && echo '------------------' >> ../hethio-server*.build
cat ../hethio-server*.build


# ===================================
# SCAN BUILD LOG FOR ERRORS
#  By convention, an 'exit 0' indicates success,
#+ while a non-zero exit value means an error or anomalous condition.
#  See the "Exit Codes With Special Meanings" appendix.
BUILD=`cat ../hethio-server*.build`
if [[ $BUILD == *"error"* ]]; then
	exit 1
fi






