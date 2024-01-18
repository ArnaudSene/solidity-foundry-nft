// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DevOpsTools} from "@foundry-devops/src/DevOpsTools.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";


contract MintBasicToken is Script {
    uint256 tokenId = 0;
    uint256 amountFiles = 8;
    string public constant METADATA_URI = "ipfs://QmNecu75FZa1xMZNt6LhcB1WDWH4dvgi6bLBpPVUPfLiPW/";
    string public constant METADATA_FILE_NAME = "-eic.json";
    
    function mintNFTOnContract(address _mostRecentlyDeployed) public {
        for (tokenId; tokenId < amountFiles; tokenId++) {
            string memory tokenURI = string(abi.encodePacked(
                METADATA_URI, 
                Strings.toString(tokenId),
                METADATA_FILE_NAME
            ));
            console.log(tokenURI);
            
            vm.startBroadcast();
            BasicNFT(_mostRecentlyDeployed).mintNFT(tokenURI);
            vm.stopBroadcast();
        }
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        console.log("mostRecentlyDeployed: ", mostRecentlyDeployed);
        mintNFTOnContract(mostRecentlyDeployed);
    }
}
