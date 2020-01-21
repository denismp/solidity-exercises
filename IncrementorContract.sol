pragma solidity >=0.4.22 <0.6.0;

contract IncrementorContract {
    uint private value;

    function increment(uint delta) public {
        value += delta;
    }

    function get() public view returns(uint) {
        return value;
    }
}