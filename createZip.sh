zipBasePath="{TARGET_BUILD_DIR}/${ZipName}"
git=$(sh /etc/profile; which git)

echo "Removing zip file ${zipBasePath}.zip"
rm -f "${zipBasePath}.zip"
if [ x${ACTION} = xclean ]; then
	exit 0
fi

echo "Setting ownership..."
chgrp -R admin "${BUILT_PRODUCTS_DIR}/${ZipProduct}"
echo "...done"

echo "Setting permissions..."
chmod -R g+w "${BUILT_PRODUCTS_DIR}/${ZipProduct}"
echo "...done"

echo "Creating Zip file ${zipBasePath}.zip ..."
cd "${BUILT_PRODUCTS_DIR}"
zip -9 -r -y "${ZipName}.zip" "${ZipProduct}"
echo "...done"

echo "Adding Revision Number to Zip file ${zipBasePath}.zip ..."
cd "${SRCROOT}"
REV=$("$git" rev-list --first-parent --count HEAD)
# REV=$("$git" describe --tag --always)
cd "${BUILT_PRODUCTS_DIR}"
cp "${ZipName}.zip" "${ZipName}-${REV}.zip"
echo "...done"
