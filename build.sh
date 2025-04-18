#!/bin/bash

dirs=(
    "IN0009_GBS"
    "IN0008_GDB"
    "EI00330_Signaltheorie"
    "IN0042_ITSEC"
    "MA0902_Analysis_Informatik"
    "WI00729_BWL2"
    "IN0010_GRNVS"
    "IN0018_DWT"
    "NUS/EE4218_EHSD"
    "NUS/CS4277_3CV"
)

mkdir -p build

for dir in "${dirs[@]}"; do
    mkdir -p build/"$dir"
    echo "Building $dir"

    # make deck
    ankitum "./$dir" -o ./build/"${dir%.yaml}".apkg --debug
    if [ $? -ne 0 ]; then
        echo "Ankitum returned non zero exit code. Aborting..."
        exit 1
    fi
done
