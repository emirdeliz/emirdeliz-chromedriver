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

	# # if [ "$OSTYPE" != "msys" ]; then
	# FILENAME_ZIP="${CHROMEDRIVER_FILENAME}.zip"
	# # fi

	DONWLOAD_URL="https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_RELEASE/$FILENAME_ZIP"
	curl "$DONWLOAD_URL" -L -o "$FILENAME_ZIP"
}

unzipFiles() {
	CHROMEDRIVER_FILENAME="$1"
	DOWNLOAD_PATH="$2"
	# FILENAME_ZIP="$CHROMEDRIVER_FILENAME"

	echo "---" && ls && echo "---"

	# if [ "$OSTYPE" != "msys" ]; then
	# 	FILENAME_ZIP="${CHROMEDRIVER_FILENAME}.zip"
	# fi
	7z e "*.zip" && ls
}

main() {
	CHROMEDRIVER_FILENAME="chromedriver_$2"
	CHROMEDRIVER_RELEASE="$(getDriverVersion "$1")"
	DOWNLOAD_PATH="$3"

	setDownloadDir "$DOWNLOAD_PATH" &&
		removeObsoleteFiles &&
		downloadDriver "$CHROMEDRIVER_RELEASE" "$CHROMEDRIVER_FILENAME" &&
		unzipFiles "$CHROMEDRIVER_FILENAME" "$DOWNLOAD_PATH" &&
		./chromedriver --version
}

main "$1" "$2" "$3"
