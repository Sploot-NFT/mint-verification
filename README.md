# mint-verification
**System for safely injecting data into the smart contract on mint, without any chance of it being fake or tampered with.**

## signing.py
This code is meant to be used on the backend in combination with the metadata generator to sign the metadata (represented as a large integer, WIP) and return the signature.
A private key has to be defined, and this key has to match the public key defined as signatureAddress in contract.sol

The balance of the minter as well as the minters address is used as a nonce for the hash to ensure the same data can't be used twice.

## contract.sol
This code is meant to be used to verify the metadata that will be insterted on the mint of a sploot. The **verifyMinter** function takes in a uint for the data and a signature in the form of bytes. It then verifies that the signature in fact used that data and the private key that matched the backend.

