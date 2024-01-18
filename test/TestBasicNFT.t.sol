// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../script/0-DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {console} from "forge-std/Script.sol";

contract TestBasicNFT is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public user = makeAddr("user");
    string public constant TOKEN_URI = "ipfs://bafybeidpx36xgmlcnuh3mhf2nofnwug7wiwdwbuq4xpvf5mgzxxqocqf5q/?filename=0-eic.json";
    
    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    /**
     * Test summary
     * 
     * 1. The name of otken is valid
     * 2. User mint token and have a balance
     */

    function testTokenNameIsValid() public {
        string memory expectedName = "EthIcon";
        assertEq(basicNFT.name(), expectedName);
        assert(keccak256(abi.encodePacked(basicNFT.name())) == keccak256(abi.encodePacked(expectedName)));
    }

    function testUserMintTokenAndHasBalance() public {
        vm.prank(user);
        basicNFT.mintNFT(TOKEN_URI);
        // Assert
        // console.log("token URI: ", basicNFT.tokenURI(0) );
        assert(basicNFT.balanceOf(user) == 1);
        assert(keccak256(abi.encodePacked(basicNFT.tokenURI(0))) == keccak256(abi.encodePacked(TOKEN_URI)));
    }
}