pragma solidity ^0.8.15;

import "../Verifier.sol";

contract Kevin is TurboVerifier {

    event Banana(uint256 x, uint256 y, uint256 result);

    uint256 public last;

    function set(bytes memory proof) public {
        uint256[3] memory inputs = abi.decode(proof, (uint256[3]));
        require(this.verify(proof));
        last = inputs[2];
        emit Banana(inputs[0], inputs[1], inputs[2]);
    }

}