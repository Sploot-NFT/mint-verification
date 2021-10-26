// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Verify { 
    address signatureAddress;
    
    constructor(address sigAddress) public {
        signatureAddress = sigAddress;
    }
    
  function recoverSigner(bytes32 message, bytes memory sig) private pure returns (address) {
       uint8 v;
       bytes32 r;
       bytes32 s;
       (v, r, s) = splitSignature(sig);
       return ecrecover(message, v, r, s);
  }
  
  function splitSignature(bytes memory sig) private pure returns (uint8, bytes32, bytes32) {
       require(sig.length == 65);
       
       bytes32 r;
       bytes32 s;
       uint8 v;
       assembly {
           r := mload(add(sig, 32))
           s := mload(add(sig, 64))
           v := byte(0, mload(add(sig, 96)))
       }
       return (v, r, s);
   }
   
   function hash(uint256 numbers) private pure returns(bytes32) {
        bytes32 base_message =  keccak256(abi.encodePacked(numbers));
        return keccak256(abi.encodePacked( "\x19Ethereum Signed Message:\n32" , base_message ));
   }
   
   function verifyMinter(uint256 data, bytes memory signature) public view returns(bool) {
       bytes32 message = hash(data);
       return recoverSigner(message, signature) == signatureAddress;
   }
}

