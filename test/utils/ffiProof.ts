import { compile, acir_from_bytes } from '@noir-lang/noir_wasm';
import { setup_generic_prover_and_verifier, create_proof, verify_proof, create_proof_with_witness } from '@noir-lang/barretenberg/dest/client_proofs';
import path from 'path';
import { readFileSync } from 'fs';

function path_to_uint8array(path: string) {
    let buffer = readFileSync(path);
    return new Uint8Array(buffer);
}

async function generateProof() {
    let acirByteArray = path_to_uint8array(path.resolve(__dirname, `../../circuits/build/${process.argv[2]}.acir`));
    let acir = acir_from_bytes(acirByteArray);

    let abi = {
        x : parseInt(process.argv[3]),
        y : parseInt(process.argv[4]),
        return : parseInt(process.argv[5])
    }

    let [prover, verifier] = await setup_generic_prover_and_verifier(acir);
    const proof = await create_proof(prover, acir, abi);
    console.log(proof.toString('hex'));
}

generateProof().then(() => process.exit(0)).catch(console.log);