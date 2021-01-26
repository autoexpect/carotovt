
PROJECT_NAME    := carotovt
TARGET_DIR      := bin
BUILD_NAME      := CarotOVT
BUILD_VERSION   := $(shell date "+%Y%m%d.%H%M%S")
BUILD_TIME      := $(shell date "+%F %T")
COMMIT_SHA1     := $(shell git rev-parse HEAD )

all: release
	
release: linux_amd64 windows_amd64

linux_amd64:
	go build -ldflags \
	"-s -w  \
	-X '${PROJECT_NAME}/config.Version=${BUILD_VERSION}' \
	-X '${PROJECT_NAME}/config.BuildTime=${BUILD_TIME}' \
	-X '${PROJECT_NAME}/config.CommitID=${COMMIT_SHA1}' \
	" -o ${TARGET_DIR}/${BUILD_NAME}

windows_amd64:
	x86_64-w64-mingw32-windres ./CarotOVT.rc -O coff -o ./CarotOVT.syso
	GOOS=windows GOARCH=amd64 CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc CXX=x86_64-w64-mingw32-g++ HOST=x86_64-w64-mingw32 go build -ldflags \
	"-s -w -H=windowsgui -extldflags=-static \
	-X '${PROJECT_NAME}/config.Version=${BUILD_VERSION}' \
	-X '${PROJECT_NAME}/config.BuildTime=${BUILD_TIME}' \
	-X '${PROJECT_NAME}/config.CommitID=${COMMIT_SHA1}' \
	" -p 4 -v -o ${TARGET_DIR}/${BUILD_NAME}.exe

macos_amd64:
	CGO_ENABLED=1 go build -ldflags \
	"-s -w \
	-X '${PROJECT_NAME}/config.Version=${BUILD_VERSION}' \
	-X '${PROJECT_NAME}/config.BuildTime=${BUILD_TIME}' \
	-X '${PROJECT_NAME}/config.CommitID=${COMMIT_SHA1}' \
	" -o ${TARGET_DIR}/CarotOVT.app/Contents/MacOS/${BUILD_NAME}
	iconutil -c icns -o ${TARGET_DIR}/CarotOVT.app/Contents/Resources/icon.icns logo.iconset
	create-dmg --volname "CarotOVT Installer" \
	--volicon "${TARGET_DIR}/CarotOVT.app/Contents/Resources/icon.icns" \
	--window-pos 200 120 \
	--window-size 800 400 \
	--icon-size 100 \
	--app-drop-link 600 185 \
	--hide-extension "CarotOVT.app" \
	"${TARGET_DIR}/CarotOVT-Installer.dmg" \
	"${TARGET_DIR}/CarotOVT.app"
