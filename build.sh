#!/bin/bash

dirs=()

for subdir in ./*/; do

    # search all folders except "build"
    if [ -d "$subdir" ] && [ "$(basename "$subdir")" != "build" ]; then
        dirs+=("$subdir")
    fi
done

# create output folder
mkdir -p build

# loop over directories
for dir in "${dirs[@]}"; do
    mkdir -p build/$dir
    echo "Building $dir"
    (
        shopt -s nullglob
        for deck in "$dir"/*.yaml; do
            echo $deck
            if [ -f "./$deck" ]; then
                echo "Building Deck $dir/$deck"

                # make deck
                deckname=$(basename "$deck")
                ankitum "$deck" -l ./tum_logo.png -o ./build/$dir/"${deckname%.yaml}".apkg --debug
            fi
        done
        shopt -u nullglob

        zip ./build/$dir.zip ./build/$dir/*.apkg
    )
done
