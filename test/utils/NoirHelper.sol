pragma solidity 0.8.20;

import { TestBase } from "forge-std/Base.sol";
import { console2 as console } from "forge-std/console2.sol";

contract NoirHelper is TestBase {

    struct CircuitInput {
        string name;
        uint256 value;
    }

    CircuitInput[] public inputs;

    /// Adds an input.
    /// Can be chained.
    ///
    /// # Example
    ///
    /// ```
    /// withInput("x", 1).withInput("y", 2).withInput("return", 3);
    /// ```
    function withInput(string memory name, uint256 value) public returns (NoirHelper) {
        inputs.push(CircuitInput(name, value));
        return this;
    }

    /// "Empty" the inputs array.
    ///
    /// # Example
    ///
    /// ```
    /// clean();
    /// ```
    function clean() public {
        delete inputs;
    }

    /// Read a proof from a file located in circuits/proofs.
    ///
    /// # Example
    ///
    /// ```
    /// bytes memory proof = readProof("my_proof");
    /// ```
    function readProof(string memory fileName) public returns (bytes memory) {
        string memory file = vm.readFile(string.concat("circuits/proofs/", fileName, ".proof"));
        return vm.parseBytes(file);
    }

    /// Generates a proof based on inputs and returns it.
    ///
    /// # Arguments
    /// * `proverName` - The name of the prover file to be created in circuits/.
    ///                  Also servers as the name of the proof to be generated in circuits/proofs.
    ///
    /// # Example
    ///
    /// ```
    /// withInput("x", 1).withInput("y", 2).withInput("return", 3);
    /// bytes memory proof = generateProof();
    /// ```
    function _generateProof(string memory proverName, bool cleanup) internal returns (bytes memory) {
        // write prover file
        string memory proverTOML = string.concat("circuits/", proverName, ".toml");
        vm.writeFile(proverTOML, "");
        // write all inputs with their values
        for(uint i; i < inputs.length; i++) {
            vm.writeLine(proverTOML, string.concat(inputs[i].name, " = ", vm.toString(inputs[i].value)));
        }
        // generate proof
        string[] memory ffi_cmds = new string[](2);
        ffi_cmds[0] = "./prove.sh";
        ffi_cmds[1] = proverName;
        vm.ffi(ffi_cmds);
        // clean inputs
        clean();
        // read proof
        string memory proofLocation = string.concat("circuits/proofs/", proverName, ".proof");
        string memory proof = vm.readFile(proofLocation);

        if (cleanup) {
            // remove files
            vm.removeFile(proverTOML);
            vm.removeFile(proofLocation);
        }
        return vm.parseBytes(proof);
    }

    function generateProofAndClean(string calldata proverName) external returns (bytes memory) {
        return _generateProof(proverName, true);
    }

    function generateProof(string calldata proverName) external returns (bytes memory) {
        return _generateProof(proverName, false);
    }


}