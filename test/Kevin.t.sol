pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

import {Kevin} from "contracts/mocks/Kevin.sol";

contract KevinTest is Test {

    Kevin kevin;

    function setUp() external {
        kevin = new Kevin();
    }

    function getBasicProofRequest() public pure returns (string[] memory) {
        string[] memory inputs = new string[](7);
        inputs[0] = "npx";
        inputs[1] = "ts-node";
        inputs[2] = "test/utils/ffiProof.ts";
        return inputs;
    }

    function testLabouji() external {
        string[] memory inputs = getBasicProofRequest();
        inputs[3] = "p";
        inputs[4] = "1";
        inputs[5] = "2";
        inputs[6] = "3";
        bytes memory proof = vm.ffi(inputs);
        console2.logBytes(proof);
        kevin.set(proof);
        assertEq(kevin.last(), 3);
    }
}