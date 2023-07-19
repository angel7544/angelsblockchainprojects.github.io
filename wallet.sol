// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {}

    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "Only the owner can call this method");
        require(_amount <= address(this).balance, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
