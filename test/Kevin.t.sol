pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

import { Kevin } from "contracts/Kevin.sol";

import { NoirHelper } from "test/utils/NoirHelper.sol";

contract KevinTest is Test, NoirHelper {

    Kevin kevin;

    function setUp() external {
        kevin = new Kevin();
    }

    function _sheesh(string memory name) internal {
        this.withInput("x", 1).withInput("y", 2).withInput("return", 3);
        bytes memory proof = this.generateProofAndClean(name);
        bytes32[] memory inputs = new bytes32[](3);
        inputs[0] = bytes32(uint256(1));
        inputs[1] = bytes32(uint256(2));
        inputs[2] = bytes32(uint256(3));
        kevin.set(proof, inputs);
        assertEq(kevin.last(), 3);
    }

    function testLabouji() external {
        _sheesh("test_0");
    }

    function testKingBob() external {
        _sheesh("test_1");
    }
}