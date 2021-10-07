pragma solidity ^0.8.7;

contract StartStopUpdateExample {
    
    // owner of the smart contract
    address owner;
    
    // global var to determine if your smart contract is paused or not
    bool public paused = false;
    
    // called once when the smart contract is been deployed and 
    // sets the owner of this smart contract
    constructor() {
        owner = msg.sender;
    }
    
    // setter for paused var
    function setPaused(bool _paused) public {
        // only the owner of the smart contract should be able to pause the contract
        require(msg.sender == owner, "You are not the owner, hence you can not pause the contract!");
        paused = _paused;
    }
    
    // function to destroy the smart contract, only the owner should be able to destroy the contract
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner, hence you can not destroy the contract!");
        selfdestruct(_to);
    }
    
    // receiving the ether
    function sendMoney() public payable {
        
    }
    
    // withdraw all ether and transfers all the funds of this smart contract 
    // to address _to
    function withdrawAllMoney(address payable _to) public {
        
        // only the owner of the smart contract should be able to withdrawAllMoney
        // this can be done with require statement (like if in any other lang)
        // if the requirement is not met, all previous actions wont be reflected on the blockchain
        // it kinda 'rolls back'
        require(msg.sender == owner, "You are not the owner, hence you can not withdraw!");
        // the contract should not be paused in order to withdraw money
        require(!paused, "Contract is already paused!");
        _to.transfer(address(this).balance);
    }
}