#!/usr/bin/env bash

DIRS="IN0009_GBS"

function build() {
	mkdir -p build
	for dir in $DIRS; do
		mkdir -p build/$dir
		cd $dir
		echo "Building $dir"

		for deck in *.yaml; do
			echo "Building Deck $deck"
			ankitum $deck -o ../build/$dir/${deck%.yaml}.apkg
		done
		cd ..
	done
}

build