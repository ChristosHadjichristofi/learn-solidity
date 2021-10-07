pragma solidity ^0.8.7;

contract MappingStructExample {
    
    // like an array but with all possible keys already init with their default value
    // is like an array which keeps the balance of every address
    mapping(address => uint) public balanceReceived;
    
    // function to return the balance of this address
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }
    
    // withdraw all the money from this address and send them to _to address
    function withdrawAllMoney(address payable _to) public {
        
        // the code below follows the checks effects interactions pattern
        
        // this is the amount that this person has in his balance
        uint balanceToSend = balanceReceived[msg.sender];
        // set this person's balance to zero
        balanceReceived[msg.sender] = 0;
        // transfer it to the account that was specified by the person who owns this balance
        _to.transfer(balanceToSend);
    }
}