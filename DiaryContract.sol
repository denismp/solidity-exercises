pragma solidity >=0.4.22 <0.6.2;
pragma experimental ABIEncoderV2; // This is experimental.  don't use in main net.
// https://blog.ethereum.org/2019/03/26/solidity-optimizer-and-abiencoderv2-bug/

contract DiaryContract {
    string[] private facts;
    address private owner;
    string[] private users;

    event AddReaderEvent(
        address owner,
        string name,
        uint count
    );
    event AddFactEvent(
        address owner,
        string fact,
        uint count
    );

    constructor() public {
        owner = msg.sender;
    }

    function addReader(string memory name) public {
        require(msg.sender == owner, "You must be the owner to add readers");
        bool found = false;
        for(uint i = 0; i < users.length; i++) {
            if(hashCompareWithLengthCheck(users[i],name) == true) {
            //if(equal(users[i],name) == true) {
                found = true;
                break;
            }
        }
        require(!found, "name already exists.");
        users.push(name);
        emit AddReaderEvent(owner,name,users.length);
    }

    function getReaders() public view returns(string[] memory) {
        return users;
    }

    function add(string memory fact) public {
        require(msg.sender == owner, "You must be the owner to add facts");
        facts.push(fact);
        emit AddFactEvent(owner,fact,facts.length);
    }

    function getFact(uint index, string memory name) public view returns(string memory) {
        bool found = false;
        for(uint i = 0; i < users.length; i++) {
            if(hashCompareWithLengthCheck(users[i],name) == true) {
            //if(equal(users[i],name) == true) {
                found = true;
                break;
            }
        }
        require(found, "name is not a valid user for this function.");
        require(index >= 0 && index < users.length, "index is out of bounds");

        return facts[index];
    }

    function count() public view returns(uint) {
        return facts.length;
    }

    // Stolen from https://fravoll.github.io/solidity-patterns/string_equality_comparison.html
    // This code has not been professionally audited, therefore I cannot make any promises about
    // safety or correctness. Use at own risk.
    function hashCompareWithLengthCheck(string memory a, string memory b) internal pure returns (bool) {
        if(bytes(a).length != bytes(b).length) {
            return false;
        } else {
            return keccak256(bytes(a)) == keccak256(bytes(b));
        }
    }


    // This code was stolen from https://github.com/ethereum/dapp-bin/blob/master/library/stringUtils.sol
    /// @dev Does a byte-by-byte lexicographical comparison of two strings.
    /// @return a negative number if `_a` is smaller, zero if they are equal
    /// and a positive numbe if `_b` is smaller.
    function compare(string memory _a, string memory _b) internal pure returns (int) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint minLength = a.length;
        if (b.length < minLength) minLength = b.length;
        //@todo unroll the loop into increments of 32 and do full 32 byte comparisons
        for (uint i = 0; i < minLength; i ++)
            if (a[i] < b[i])
                return -1;
            else if (a[i] > b[i])
                return 1;
        if (a.length < b.length)
            return -1;
        else if (a.length > b.length)
            return 1;
        else
            return 0;
    }
    // This code was stolen from https://github.com/ethereum/dapp-bin/blob/master/library/stringUtils.sol
    /// @dev Compares two strings and returns true iff they are equal.
    function equal(string memory _a, string memory _b) internal pure returns (bool) {
        return compare(_a, _b) == 0;
    }
}