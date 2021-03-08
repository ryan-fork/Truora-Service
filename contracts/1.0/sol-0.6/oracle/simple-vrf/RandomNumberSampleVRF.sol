pragma solidity ^0.6.6;

import "./VRFClient.sol";

contract RandomNumberSampleVRF is VRFClient {

    bytes32 internal keyHash;
    uint256 public randomResult;

    constructor(address _vrfcore, bytes32 _keyHash)
        VRFClient(
            _vrfcore // VRF Coordinator
        ) public
    {
          keyHash = _keyHash;
    }

    /**
     * Requests randomness from a user-provided seed
     */
    function getRandomNumber(uint256 userProvidedSeed) public returns (bytes32 requestId) {
        return vrfQuery(keyHash, userProvidedSeed);
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function __callbackRandomness(bytes32 requestId, uint256 randomness) public override onlyVRFCoreInvoke(requestId) {
        randomResult = randomness;
    }
}