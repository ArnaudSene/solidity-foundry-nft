// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdtoURI;

    constructor() ERC721("EthIcon", "EIC") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory _tokenURI) public {
        s_tokenIdtoURI[s_tokenCounter] = _tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 _tokenId) public view override returns(string memory) {
        return s_tokenIdtoURI[_tokenId];
    }
}