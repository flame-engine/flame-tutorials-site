#!/bin/bash -e

tmp_flame_src='_flame-src'
output_dir='docs'

function main {
  rm -rf $output_dir
  mkdir $output_dir
  touch $output_dir/.nojekyll
  echo 'tutorials.flame-engine.org' >> $output_dir/CNAME

  git clone https://github.com/flame-engine/flame.git $tmp_flame_src

  # TODO(luan) support multiple tutorials
  generate space_shooter
  git_push

  rm -rf $tmp_flame_src
}

function generate {
  tutorial=$1
  cd $tmp_flame_src/tutorials/$tutorial
  flutter pub get
  flutter build web
  cp -R build/web/* ../../../build/
  cd ../../..
}

function git_push {
  git config --global user.email "luanpotter27@gmail.com"
  git config --global user.name "Luan Nico"
  git add build
  git commit -m "Update & publish new tutorials versions"
  git push
}

main
