#!/bin/bash

setDownloadDir() {
	DOWNLOAD_PATH="$1"
	if [ "$DOWNLOAD_PATH" != "" ]; then
		mkdir -p "$DOWNLOAD_PATH" && cd "$DOWNLOAD_PATH" || exit
	fi
}

removeObsoleteFiles() {
	rm -rf chromedriver LICENSE.chromedriver
}

getDriverVersion() {
	VERSION="$1"
	CHROMEDRIVER_RELEASE="$VERSION"
	if [ "$VERSION" == "latest" ]; then
		VERSION="LATEST_RELEASE"
		CHROMEDRIVER_RELEASE="$(curl --show-error --retry 10 "http://chromedriver.storage.googleapis.com/$VERSION")"
	fi
	echo "$CHROMEDRIVER_RELEASE"
}

downloadDriver() {
	CHROMEDRIVER_RELEASE="$1"
	CHROMEDRIVER_FILENAME="$2"
	FILENAME_ZIP="${CHROMEDRIVER_FILENAME}.zip"
	DONWLOAD_URL="https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_RELEASE/$FILENAME_ZIP"
	curl -L -o "$FILENAME_ZIP" "$DONWLOAD_URL"
}

unzipFiles() {
	CHROMEDRIVER_FILENAME="$1"
	ls && unzip "${CHROMEDRIVER_FILENAME}.zip" && ls
}

installDependencies() {
	apt update && sudo apt install -y libnss3 libglib-2.0.so.0
}

main() {
	CHROMEDRIVER_FILENAME="chromedriver_$2"
	CHROMEDRIVER_RELEASE="$(getDriverVersion "$1")"
	DOWNLOAD_PATH="$3"

	setDownloadDir "$DOWNLOAD_PATH" &&
		removeObsoleteFiles &&
		downloadDriver "$CHROMEDRIVER_RELEASE" "$CHROMEDRIVER_FILENAME" &&
		unzipFiles "$CHROMEDRIVER_FILENAME"
		

		if [[ "$OSTYPE" == "linux-gnu"* ]]; then
			installDependencies
		fi
		./chromedriver --version
}

main "$1" "$2" "$3"
