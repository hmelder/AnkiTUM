#!/usr/bin/env bash

DIRS="IN0009_GBS example"

function build() {
	mkdir -p build
	for dir in $DIRS; do
		mkdir -p build/$dir
		cd $dir
		echo "Building $dir"

		shopt -s nullglob
		for deck in *.yaml; do
			if [ -f "$deck" ]; then
				echo "Building Deck $deck"
				ankitum $deck -l ../resources -o ../build/$dir/${deck%.yaml}.apkg
			fi
		done
		shopt -u nullglob

		# Zip the generated decks
		zip ../build/$dir.zip ../build/$dir/*.apkg
		cd ..
	done
}

build