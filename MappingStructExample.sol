pragma solidity ^0.8.7;

contract MappingStructExample {
    
    // struct to keep payment info
    struct Payment {
        uint amount;
        uint timestamps;
    }

    // struct to keep balance info
    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    // like an array but with all possible keys already init with their default value
    // is like an array which keeps the balance of every address
    // deprecated
    // mapping(address => uint) public balanceReceived;
    // new version with a mapping of address => Balance
    mapping(address => Balance) public balanceReceived;
    
    // function to return the balance of this address
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function sendMoney() public payable {
        // update totalBalance of sender's balanceReceived
        balanceReceived[msg.sender].totalBalance += msg.value;

        // create a new payment with the value that was sent and with the current timestamp
        Payment memory payment = Payment(msg.value, block.timestamp);

        // add the payment to the balanceReceived value (to Balance.payments)
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        
        // increase the number of payments
        balanceReceived[msg.sender].numPayments++;
    }
    
    // partial withdraw, put money into the smart contract i.e five ether
    // and then start slowly withdrawing to other different addresses 
    function withdrawMoney(address payable _to, uint _amount) public {
        // first check if the person has enough money to send
        require(balanceReceived[msg.sender].totalBalance >= _amount, "Not enough funds");
        // deduct from sender's balance
        balanceReceived[msg.sender].totalBalance -= _amount;
        // send them to the recipient
        _to.transfer(_amount);

    }

    // withdraw all the money from this address and send them to _to address
    function withdrawAllMoney(address payable _to) public {
        
        // the code below follows the checks effects interactions pattern
        
        // this is the amount that this person has in his balance
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        // set this person's balance to zero
        balanceReceived[msg.sender].totalBalance = 0;
        // transfer it to the account that was specified by the person who owns this balance
        _to.transfer(balanceToSend);
    }
}