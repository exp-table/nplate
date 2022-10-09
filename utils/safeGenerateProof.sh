#!/usr/bin/env bash

#
# Runs nargo build and compile before generating a proof.
# If Prover.toml is malformed, it will still generate the proof using the last valid build.
#

printf "Name of your build : "
read name_build

cd circuits/
printf "\n#################\n\n"
nargo build
printf "\n#################\n\n"
nargo compile ${name_build}
printf "\n#################\n\n"

cd ..
npx ts-node scripts/generateProof.ts ${name_build}