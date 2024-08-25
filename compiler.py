#!/usr/bin/env python

from solcx import compile_standard, install_solc
import json

_solc_version = "0.8.0"
install_solc(_solc_version)

with open("tokenize.sol", "r") as file:
    token_sol = file.read()

compiled_sol = compile_standard({
    "language": "Solidity",
    "sources": {"tokenize.sol": {"content": token_sol}},
    "settings": {
        "outputSelection": {
            "*": {
                "*": ["abi", "metadata", "evm.bytecode", "evm.sourceMap"]
            }
        }
    }
}, solc_version="0.8.0", allow_paths="./node_modules")

with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)
