pragma solidity >=0.4.22 <0.6.0;

contract SimpleTokenContract {
    mapping(address => uint) supply;
    address private owner;

    event CreateTokenEvent(
        address owner,
        uint supply
    );

    event SpendTokenEvent(
        address owner,
        address to,
        uint supply,
        uint spent
    );

    constructor(uint initialSupply) public {
        owner = msg.sender;
        supply[msg.sender] = initialSupply;
        emit CreateTokenEvent(owner,supply[owner]);
    }

    function transfer(address to, uint value) public {
        require(supply[owner] >= value, "The owner of this contract does not have enough supply.");
        require(supply[owner] + value > supply[owner], "The value requested will cause an overflow condition.");
        supply[owner] -= value;
        supply[to] += value;
        emit SpendTokenEvent(owner, to, supply[owner],value);
    }

    function get() public view returns(uint,address) {
        return(supply[owner],owner);
    }
}