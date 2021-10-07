pragma solidity ^0.8.7;

contract SendMoneyExample {
    
    // public variable to store the received money
    uint public balanceReceived;
    
    // function that received money 
    // The presence of the payable modifier means that the function can 
    // process transactions with non-zero Ether value. If a transaction 
    // that transfers Ether comes to the contract and calls some function X, 
    // then if this function X does not have the payable modifier, then the 
    // transaction will be rejected.
    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }
    
    // getter for balance - need to return the address of this object to get the balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    // withdraw all the money to the person who is sending a transaction to this function
    // can be done with the message sender property
    function withdrawMoney() public {
        // in order to send money to this address it needs to be payable
        // also msg.sender needs to be implicitly converted to payable
        address payable to = payable(msg.sender);
        
        // address has a transfer function that gets one argument, which is
        // the amount you want to transfer in wei
        to.transfer(this.getBalance());
    }
    
    // same as withdrawMoney, but here you can add to which account you want to
    // transfer the money. Gas fee is been paid from the person who initiated this action
    // so the received will get all the money without any deduction to his account
    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
    
}