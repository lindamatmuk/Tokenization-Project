// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract Tokenize is ERC721URIStorage, Ownable {
    uint256 public tokenCounter; //counts every token minted

    constructor() ERC721("Token", "ITM") Ownable(msg.sender)  { //initializes the ERC721 token with symbol ITM (item)
        tokenCounter = 0;
    }

    function convertToString(uint _num) public pure returns (string memory) {
        string memory strNum;
        strNum = Strings.toString(_num);
        return strNum;
    }

    function mintToken(address to, uint256 serialNumber) public onlyOwner {
        _safeMint(to, tokenCounter);
        _setTokenURI(tokenCounter, string(abi.encodePacked("https://api.example.com/metadata/", convertToString(serialNumber))));
        tokenCounter++;
    }

}
