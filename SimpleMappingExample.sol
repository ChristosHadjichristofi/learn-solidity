pragma solidity ^0.8.7;

contract SimpleMappingExample {
    // map with key value pairs, [(uint, bool), (uint, bool), ..., (uint, bool)]
    // at first every value on the mapping (at every key/index) is set to false
    mapping(uint => bool) public myMapping;
    // mapping that keeps address,bool pairs
    mapping(address => bool) public myAddressMapping;
    
    // in order to set the value of the mapping, at any key/index 
    // a setter is needed
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }
    
    // function that sets the mapping at address position to true
    // gets the address position from the msg.sender, which is the account
    // that called this function
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
    
}