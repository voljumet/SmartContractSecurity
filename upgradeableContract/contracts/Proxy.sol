pragma solidity 0.5.2;

import "./Storage.sol";

contract Proxy is Storage {
    address currentAddress;

    constructor(address _currentAddress) public {
        currentAddress = _currentAddress;
    }

    function upgrade(address _newAddress) public {
        currentAddress = _newAddress;
    }

// Fallback function, last call..
    function () payable external {
        address implementation = currentAddress;
        require(currentAddress != address(0));
        bytes memory data = msg.data;

        assembly {
            let result := delegatecall(gas, implementation, add(data, 0x20), mload(data), 0, 0)
            let size := returndatasize
            let ptr := mload(0x40)
            returndatacopy(ptr, 0, size)
            switch result
            case 0 {revert(ptr, size)}
            default {return(ptr, size)}
        }
    }
}