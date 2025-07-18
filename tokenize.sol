// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; // Still useful for convertToString

contract Tokenize is ERC721URIStorage, Ownable {
    // tokenCounter is removed as serialNumber will be the tokenId
    // uint256 public tokenCounter;

    constructor() ERC721("Token", "ITM") Ownable(msg.sender) {
        // tokenCounter initialization removed
        // tokenCounter = 0;
    }

    // This function remains useful for converting uint256 to string for URI
    function convertToString(uint256 _num) public pure returns (string memory) {
        string memory strNum;
        strNum = Strings.toString(_num);
        return strNum;
    }

    // mintToken now uses serialNumber directly as the tokenId
    function mintToken(address to, uint256 serialNumber) public onlyOwner {
        // Check if the token already exists to prevent re-minting the same serialNumber
        require(!_exists(serialNumber), "ERC721: token already minted with this serial number");

        // Mint the token with the serialNumber as its unique ID
        _safeMint(to, serialNumber);

        // Set the token URI using the serialNumber as the ID
        // IMPORTANT: "https://api.example.com/metadata/" should ideally be an IPFS gateway URL
        // pointing to decentralized metadata for true NFT immutability.
        _setTokenURI(serialNumber, string(abi.encodePacked("https://api.example.com/metadata/", convertToString(serialNumber))));

        // tokenCounter increment removed as it's no longer used for IDs
        // tokenCounter++;
    }

    // Optional: Add a function to check if a serial number has already been minted
    function isSerialNumberMinted(uint256 serialNumber) public view returns (bool) {
        return _exists(serialNumber);
    }
}
