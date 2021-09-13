pragma solidity ^0.5.1;
contract mycontract{
    mapping(address=>uint) public token;
    address payable wallet;
    constructor() public{
        wallet=msg.sender;
        
    }
    function buytoken() public payable{
        if(msg.value==10)
        token[msg.sender]++;
        wallet.transfer(msg.value);
    }
}
