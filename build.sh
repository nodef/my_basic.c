#!/usr/bin/env bash
# Fetch the latest version of the library
fetch() {
if [ -d "my_basic" ]; then return; fi
URL="https://github.com/paladin-t/my_basic/archive/refs/heads/master.zip"
ZIP="${URL##*/}"
DIR="my_basic-master"
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
cd ..

# Copy the libs to the package directory
echo "Copying libs to my_basic/ ..."
rm -rf my_basic
mkdir -p my_basic
cp -rf ".build/$DIR/core/"* my_basic/
echo ""
}


# Test the project
test() {
echo "Running aa-hello-world.bas using 01-hello-world.c ..."
gcc -I. -o 01.exe examples/01-hello-world.c
./01.exe "examples/aa-hello-world.bas"    && echo -e "\n"
echo "Running ab-primes-in-50.bas using 01-hello-world.c ..."
./01.exe "examples/ab-primes-in-50.bas"   && echo -e "\n"
echo "Running ac-approx-pi.bas using 01-hello-world.c ..."
./01.exe "examples/ac-approx-pi.bas"      && echo -e "\n"
echo "Running ad-fibonacci.bas using 01-hello-world.c ..."
./01.exe "examples/ad-fibonacci.bas"      && echo -e "\n"
echo "Running ae-function-call.bas using 01-hello-world.c ..."
./01.exe "examples/ae-function-call.bas"  && echo -e "\n"
echo "Running af-classes.bas using 01-hello-world.c ..."
./01.exe "examples/af-classes.bas"        && echo -e "\n"
echo "Running ag-brainfuck.bas using 01-hello-world.c ..."
./01.exe "examples/ag-brainfuck.bas"      && echo -e "\n"
echo "Running 02-file-operations.c ..."
gcc -I. -o 02.exe examples/02-file-operations.c
./02.exe && echo -e "\n"
echo "Running 03-custom-function.c ..."
gcc -I. -o 03.exe examples/03-custom-function.c
./03.exe && echo -e "\n"
}


# Main script
if [[ "$1" == "test" ]]; then test
elif [[ "$1" == "fetch" ]]; then fetch
else echo "Usage: $0 {fetch|test}"; fi
