pragma solidity >=0.4.22 <0.6.2;

contract RegistryOfCertificates {
    mapping(string => bool) certificates;
    address private owner;
    event CertificateEvent(
        address owner,
        string hash,
        bool flag
    );

    constructor() public {
        owner = msg.sender;
    }

    function add(string memory hash) public {
        require(msg.sender == owner, "You must be the owner to add a certificate.");
        certificates[hash] = true;
        emit CertificateEvent(owner, hash, true);
    }

    function verify(string memory hash) public view returns(string memory, bool) {
        return(hash, certificates[hash]);
    }
}