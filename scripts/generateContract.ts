import { resolve, join } from 'path';
import { compile, acir_from_bytes } from '@noir-lang/noir_wasm';
import { setup_generic_prover_and_verifier } from '@noir-lang/barretenberg/dest/client_proofs';
import { writeFileSync, readFileSync } from 'fs';
import path from 'path';

function path_to_uint8array(path: string) {
    let buffer = readFileSync(path);
    return new Uint8Array(buffer);
}

async function generateSolidityVerifier() {
    let acir;
    try {
        let compiled_program = compile(resolve(__dirname, '../circuits/src/main.nr'));
        acir = compiled_program.circuit;
    } catch (e : any ) {
        let acirByteArray = path_to_uint8array(path.resolve(__dirname, `../circuits/build/${process.argv[2]}.acir`));
        acir = acir_from_bytes(acirByteArray);
    }
    console.log("Setting up generic verifier...");
    let [_, verifier] = await setup_generic_prover_and_verifier(acir);

    const sc = verifier.SmartContract();
    syncWriteFile("../contracts/Verifier.sol", sc);

    console.log('Done writing Verifier contract.');
}

function syncWriteFile(filename: string, data: any) {
    writeFileSync(join(__dirname, filename), data, {
      flag: 'w',
    });
}

generateSolidityVerifier().then(() => process.exit(0)).catch(console.log);
