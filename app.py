from flask import Flask, request, jsonify, send_from_directory
from web3 import Web3
import json

app = Flask(__name__)

ganache_url = "http://127.0.0.1:7545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

contract_address = "ContractAddress-to-replace-later"
with open("compiled_code.json", "r") as file:
    compiled_sol = json.load(file)
abi = compiled_sol['contracts']['Tokenize.sol']['Tokenize']['abi']

contract = web3.eth.contract(address=contract_address, abi=abi)

@app.route('/') #route for root url
def serve_frontend():
    return send_from_directory('', 'front.html')

@app.route('/mint', methods=['POST'])
def mint():
    data = request.get_json()
    serial_numbers = data['serialNumbers']
    for i in serial_numbers:
        tx_hash = contract.functions.mintToken(
            web3.eth.accounts[0], i
        ).transact({'from': web3.eth.accounts[0]})
        web3.eth.wait_for_transaction_receipt(tx_hash)
    return jsonify({"status": "success"})

if __name__ == '__main__':
    app.run(port=5000, debug=True)
