pragma solidity 0.8.17;

import { UltraVerifier } from "circuits/contract/plonk_vk.sol";

contract Kevin is UltraVerifier {

    event Banana(uint256 x, uint256 y, uint256 result);

    uint256 public last;

    function set(bytes calldata proof, bytes32[] calldata inputs) public {
        require(this.verify(proof, inputs));
        last = uint256(inputs[2]);
        emit Banana(uint256(inputs[0]), uint256(inputs[1]), uint256(inputs[2]));
    }

}