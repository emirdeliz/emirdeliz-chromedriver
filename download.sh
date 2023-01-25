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
	FILENAME_ZIP="$CHROMEDRIVER_FILENAME"

	if ! [ "$OSTYPE" == "msys" ]; then
		FILENAME_ZIP="${CHROMEDRIVER_FILENAME}.zip"
	fi

	DONWLOAD_URL="https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_RELEASE/$CHROMEDRIVER_FILENAME"
	curl --show-error --retry 10 --output "$FILENAME_ZIP" "$DONWLOAD_URL"
}

unzipFiles() {
	CHROMEDRIVER_FILENAME="$1"
	DOWNLOAD_PATH="$2"
	FILENAME_ZIP="$CHROMEDRIVER_FILENAME"
	CURRENT_DIR="C:\\d\\a\\emirdeliz-chromedriver\\emirdeliz-chromedriver\\$DOWNLOAD_PATH"

	echo $(pwd)
	echo "$CURRENT_DIR"
	echo "OSTYPE: $OSTYPE"

	echo ""
	echo ""
	echo ""
	ls
	echo ""
	echo ""
	echo ""

	7z && jar

	if [ "$OSTYPE" == "msys" ]; then
		# powershell -command "Expand-Archive -Force $CHROMEDRIVER_FILENAME -DestinationPath $CURRENT_DIR" && ls
		powershell -command "Expand-Archive -Force '%~dp0$CHROMEDRIVER_FILENAME' '%~dp0'"
	else
		FILENAME_ZIP="${CHROMEDRIVER_FILENAME}.zip"
		unzip "$FILENAME_ZIP"
	fi
}

main() {
	CHROMEDRIVER_FILENAME="chromedriver_$2"
	CHROMEDRIVER_RELEASE="$(getDriverVersion "$1")"
	DOWNLOAD_PATH="$3"

	setDownloadDir "$DOWNLOAD_PATH" &&
		removeObsoleteFiles &&
		downloadDriver "$CHROMEDRIVER_RELEASE" "${CHROMEDRIVER_FILENAME}.zip" &&
		unzipFiles "$CHROMEDRIVER_FILENAME" "$DOWNLOAD_PATH" &&
		./chromedriver --version
}

main "$1" "$2" "$3"
