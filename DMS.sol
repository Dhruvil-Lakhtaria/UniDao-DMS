// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract WalletWithDeadManSwitch {
    address public owner = msg.sender;
    address payable public preSetAddress;
    uint256 public lastActivity = block.number;

    constructor(address payable _preSetAddress) {
        preSetAddress = _preSetAddress;
    }

    function stillActive() public {
        lastActivity = block.number;
    }

    function triggerSwitch() payable public {
        require(msg.sender == owner, "Only the owner can call this function");
        require(block.number >= lastActivity + 10, "The owner has called still_alive in the last 10 blocks");
        uint balance = address(this).balance;
        preSetAddress.transfer(balance);
    }
}
