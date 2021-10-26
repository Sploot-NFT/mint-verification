from web3 import Web3
from eth_account.messages import encode_defunct
w3 = Web3(Web3.HTTPProvider('https://mainnet.infura.io/v3/b9edb05521d4494b97057621824a60fa'))

private_key = ""

def sign_data(data: int):
    base_message = Web3.soliditySha3( ['uint256' ], [ data ])
    message = encode_defunct(base_message)
    signed_message = w3.eth.account.sign_message(message, private_key=private_key)
    return signed_message['signature'].hex()
