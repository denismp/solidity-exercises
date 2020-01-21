pragma solidity >=0.4.22 <0.6.0;

contract PreviousInvoker {
    address private lastInvoker;
    event Invoked(
        bool flag,
        address lastInvoker
    );

    function getLastInvoker() public returns(bool, address) {
        address previousInvoker = lastInvoker;
        lastInvoker = msg.sender;
        bool flag = false;
        if( previousInvoker != address(0x0)) {
            flag = true;
        }
        emit Invoked(flag, previousInvoker);
        return (flag, previousInvoker);
    }
}