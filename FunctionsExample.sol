pragma solidity ^0.8.7;

contract FunctionsExample {

    mapping(address => uint) public balanceReceived;

    // smart contract owner
    address payable owner;

    // when the smart contract is deployed, the constructor is called
    // and the owner is set 
    constructor() {
        owner = payable(msg.sender);
    }

    // reading the state (view function), can not change the state, but only show sth
    // can return something, like the owner
    function getOwner() public view returns(address) {
        return owner;
    }

    // a pure function is a function that does not interract with any storage variables
    // storage variables are for example the mapping, or the owner variable - they store a specific state of the smart contract
    // in case that any store variable is used in the body of a pure function -> ERROR
    // a pure function can call another pure function, but not a view or any other function
    function convertWeiToEther(uint _weiAmount) public pure returns(uint) {
        return _weiAmount / 1 ether;
    }

    // only the owner should be able to destroy the smart contract
    function destroySmartContract() public {
        require(msg.sender == owner, "Only the owner of the smart contract can destroy the contract");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + uint(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "You don't have enough ether!");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    // fallback function, a function that will run when someone tries to interract
    // with the smart contract but non of the functions are matched
    // the fallback function can either be receive or fallback
    receive() external payable {
        receiveMoney();
    }
}