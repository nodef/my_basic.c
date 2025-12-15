#!/usr/bin/env bash
URL="https://excellmedia.dl.sourceforge.net/project/asio/asio/1.36.0%20%28Stable%29/boost_asio_1_36_0.zip?viasf=1"
ZIP="${URL##*/}"
ZIP="${ZIP%%\?*}"
DIR="${ZIP%.zip}"
mkdir -p .build
cd .build

# Download the release
if [ ! -f "$ZIP" ]; then
  echo "Downloading $ZIP from $URL ..."
  curl -L "$URL" -o "$ZIP"
  echo ""
fi

# Unzip the release
if [ ! -d "$DIR" ]; then
  echo "Unzipping $ZIP to .build/$DIR ..."
  cp "$ZIP" "$ZIP.bak"
  unzip -q "$ZIP"
  rm "$ZIP"
  mv "$ZIP.bak" "$ZIP"
  echo ""
fi

# Copy the libs to the package directory
echo "Copying libs to boost/ ..."
rm -rf ../boost
mkdir -p ../boost
cp -rf "$DIR/boost"/* ../boost/
echo ""
