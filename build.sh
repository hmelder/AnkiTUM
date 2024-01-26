#!/bin/bash

dirs=("IN0009_GBS" "IN0008_GDB" "EI00330_Signaltheorie" "IN0042_ITSEC" "MA0902_Analysis_Informatik" "IN0019_Numprog")

mkdir -p build

for dir in "${dirs[@]}"; do
    mkdir -p build/"$dir"
    echo "Building $dir"

    # make deck
    ankitum "./$dir" -o ./build/"$dir"/"${dir%.yaml}".apkg --debug
    zip ./build/"$dir".zip ./build/"$dir"/*.apkg

done
