
import { compile, acir_from_bytes } from '@noir-lang/noir_wasm';
import { setup_generic_prover_and_verifier, create_proof, verify_proof, create_proof_with_witness } from '@noir-lang/barretenberg/dest/client_proofs';
import path from 'path';
import { readFileSync } from 'fs';

function path_to_uint8array(path: string) {
    let buffer = readFileSync(path);
    return new Uint8Array(buffer);
}

async function generateProof() {
    let acirByteArray = path_to_uint8array(path.resolve(__dirname, `../circuits/build/${process.argv[2]}.acir`));
    let acir = acir_from_bytes(acirByteArray);

    let abi = {
        x : 1,
        y : 2,
        return : 3
    }

    console.log("Setting up generic prover and verifier...");
    let [prover, verifier] = await setup_generic_prover_and_verifier(acir);
    console.log("Creating proof...");
    const proof = await create_proof(prover, acir, abi);
    console.log("Verifying proof...");
    const verified = await verify_proof(verifier, proof);

    console.log("Proof : ", proof.toString('hex'));
    console.log("Is the proof valid : ", verified);
}

generateProof().then(() => process.exit(0)).catch(console.log);