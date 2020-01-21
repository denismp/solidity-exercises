pragma solidity >=0.4.22 <0.6.0;

contract SimpleStorageContract {
    uint private value;

    function set(uint amount) public {
        value = amount;
    }

    function get() public view returns(uint) {
        return value;
    }
}