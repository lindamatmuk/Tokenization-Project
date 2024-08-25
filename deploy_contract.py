from web3 import Web3
import json

#ganache
web3 = Web3(Web3.HTTPProvider("http://127.0.0.1:7545"))

#open COMPILED contract fo rread
with open("compiled_code.json", "r") as file:
    compiled_sol = json.load(file)
bytecode = compiled_sol['contract']['tokenize.sol']['Tokenize']['evm']['bytecode']['object']
abi = compiled_sol['contract']['tokenize.sol']['Tokenize']['abi']

#set up contract instance
Tokenize = web3.eth.contract(abi=abi, bytecode=bytecode)

##nonce = web3.eth._get_transaction_count(address)


deployer_account = web3.eth.accounts[0] #first account on ganache

#deploy contract
txHash = Tokenize.constructor().transact({'from': deployer_account}) #identifier
txReceipt = web3.eth.wait_for_transaction_receipt(txHash) #waiting to be mined
contractAddr = txReceipt.contractAddress

print("deploying contract...")

