#!/usr/bin/env bash

#
# Runs nargo build and compile before generating the Verifier contract.
# If Prover.toml is malformed, it will still generate the proof using the last valid build.
#

printf "Name of your build : "
read name_build
printf "\n#################\n\n"

cd circuits/

nargo build
printf "\n#################\n\n"

nargo compile ${name_build}
printf "\n#################\n\n"
cd ..

npx ts-node scripts/generateContract.ts ${name_build}