pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

import { Kevin } from "contracts/Kevin.sol";

contract KevinTest is Test {

    Kevin kevin;

    function setUp() external {
        kevin = new Kevin();
    }

    function _readProof(string memory fileName) internal returns (bytes memory) {
        string memory file = vm.readFile(string.concat("circuits/proofs/", fileName, ".proof"));
        return vm.parseBytes(file);
    }

    function testLabouji() external {
        bytes memory proof = _readProof("a");
        bytes32[] memory inputs = new bytes32[](3);
        inputs[0] = bytes32(uint256(1));
        inputs[1] = bytes32(uint256(2));
        inputs[2] = bytes32(uint256(3));
        kevin.set(proof, inputs);
        assertEq(kevin.last(), 3);
    }
}