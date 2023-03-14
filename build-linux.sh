#!/usr/bin/env bash

build() {
  cross build --target x86_64-unknown-linux-gnu --release
  cross build --target aarch64-unknown-linux-gnu --release

  # Build universal binary
  mkdir -p target/universal-unknown-linux-gnu/release/
  mkdir -p target/universal-unknown-linux-gnu/release/x86_64/
  mkdir -p target/universal-unknown-linux-gnu/release/aarch64/
  mkdir -p target/universal-unknown-linux-gnu/release/icons/
  mkdir -p target/universal-unknown-linux-gnu/release/icons/16x16
  mkdir -p target/universal-unknown-linux-gnu/release/icons/32x32
  mkdir -p target/universal-unknown-linux-gnu/release/icons/64x64
  mkdir -p target/universal-unknown-linux-gnu/release/icons/128x128
  mkdir -p target/universal-unknown-linux-gnu/release/icons/256x256
  mkdir -p target/universal-unknown-linux-gnu/release/icons/512x512
  mkdir -p target/universal-unknown-linux-gnu/release/i18n
  mkdir -p target/universal-unknown-linux-gnu/release/i18n/en-US

  cp "target/x86_64-unknown-linux-gnu/release/browsers" "target/universal-unknown-linux-gnu/release/x86_64/browsers"
  cp "target/aarch64-unknown-linux-gnu/release/browsers" "target/universal-unknown-linux-gnu/release/aarch64/browsers"

  cp "extra/linux/dist/install.sh" "target/universal-unknown-linux-gnu/release/install.sh"
  cp "extra/linux/dist/software.Browsers.desktop" "target/universal-unknown-linux-gnu/release/software.Browsers.desktop"

  cp "resources/icons/16x16/software.Browsers.png" "target/universal-unknown-linux-gnu/release/icons/16x16/software.Browsers.png"
  cp "resources/icons/32x32/software.Browsers.png" "target/universal-unknown-linux-gnu/release/icons/32x32/software.Browsers.png"
  cp "resources/icons/64x64/software.Browsers.png" "target/universal-unknown-linux-gnu/release/icons/64x64/software.Browsers.png"
  cp "resources/icons/128x128/software.Browsers.png" "target/universal-unknown-linux-gnu/release/icons/128x128/software.Browsers.png"
  cp "resources/icons/256x256/software.Browsers.png" "target/universal-unknown-linux-gnu/release/icons/256x256/software.Browsers.png"
  cp "resources/icons/512x512/software.Browsers.png" "target/universal-unknown-linux-gnu/release/icons/512x512/software.Browsers.png"

  cp "resources/i18n/en-US/builtin.ftl" "target/universal-unknown-linux-gnu/release/i18n/en-US/builtin.ftl"
}

make_tar_gz() {
  rm -f ./target/universal-unknown-linux-gnu/release/browsers_linux.tar.gz

  tar -zcf ./target/universal-unknown-linux-gnu/release/browsers_linux.tar.gz \
    -C ./target/universal-unknown-linux-gnu/release \
    ./x86_64/browsers \
    ./aarch64/browsers \
    ./icons/16x16/software.Browsers.png \
    ./icons/32x32/software.Browsers.png \
    ./icons/64x64/software.Browsers.png \
    ./icons/128x128/software.Browsers.png \
    ./icons/256x256/software.Browsers.png \
    ./icons/512x512/software.Browsers.png \
    ./software.Browsers.desktop \
    ./install.sh
}

build
make_tar_gz