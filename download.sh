#!/bin/bash
VERSION=$1
ARCH=$2
DOWNLOAD_PATH=$2
CHROMEDRIVER_FILENAME="chromedriver_$ARCH"

if ! [ "$VERSION" == "latest" ]; then
	VERSION="LATEST_RELEASE"
fi

if ! [ "$DOWNLOAD_PATH" == "" ]; then
	cd DOWNLOAD_PATH || exit
fi

CHROMEDRIVER_RELEASE=$(curl --location --fail --retry 3 http://chromedriver.storage.googleapis.com/"${LATEST_RELEASE}") &&
	curl --silent --show-error --location --fail --retry 3 --output /tmp/chromedriver_linux64.zip "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_RELEASE/$CHROMEDRIVER_FILENAME.zip" &&
	unzip "$CHROMEDRIVER_FILENAME.zip" &&
	rm -rf "$CHROMEDRIVER_FILENAME.zip" &&
	./chromedriver --version
