#!/bin/sh

DSTROOT=/tmp/rbt-squares-logo-screensaver.dst
SRCROOT=/tmp/rbt-squares-logo-screensaver.src

PROJECT_DIR="RBT Squares Logo"
PROJECT_NAME="RBT Squares Logo.xcodeproj"
TARGETNAME="RBT Squares Logo Screen Saver"
BUNDLE_ID="rs.rbt.rbt-squares-logo-screensaver"
CERT_NAME="Developer ID Installer: Red Black Tree d.o.o. (SJ4RVBA27V)"

INSTALLER_DIR=/tmp/rbt-squares-logo-screensaver
INSTALLER_PKG="$TARGETNAME.pkg"
INSTALLER_PATH="$INSTALLER_DIR/$INSTALLER_PKG"

echo --------------------------
echo Cleaning build directories
echo --------------------------
rm -rf build $DSTROOT $SRCROOT $INSTALLER_DIR 

echo ------------------
echo Installing Sources
echo ------------------
pushd "$PROJECT_DIR"
xcodebuild -project "$PROJECT_NAME" installsrc SRCROOT=$SRCROOT || exit 1
popd

echo ----------------
echo Building Project
echo ----------------
pushd $SRCROOT
xcodebuild -project "$PROJECT_NAME" -target "$TARGETNAME" -configuration Release install DSTROOT=$DSTROOT || exit 1
popd

echo ------------------
echo Building Installer
echo ------------------
mkdir -p "$INSTALLER_DIR" || exit 1

echo ---------------
echo Runing pkgbuild
echo ---------------
echo "Note: you must be connected to Internet for this to work as it has to contact a time server in order to generate a trusted timestamp. See man pkgbuild for more info under SIGNED PACKAGES."
pkgbuild --identifier "$BUNDLE_ID" --sign "$CERT_NAME" --root "$DSTROOT" "$INSTALLER_PATH" || exit 1

echo ----------------------------------------
echo Successfully built the installer package
echo ----------------------------------------
open "$INSTALLER_DIR"

exit 0
