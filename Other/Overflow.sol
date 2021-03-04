pragma solidity ^0.4.10;

import "./SafeMath.sol";

contract Overflow {
    mapping (address =>uint) balances;
    
    function contribute() payable public {
        // 1 wei = 1 token
        balances[msg.sender] = msg.value;
    }
    
    function getBalances() public view returns (uint){
        return balances[msg.sender];
    }
    
    function batchSend(address[] _recievers, uint _value) public returns (uint){
        //this line overflows
        uint total = SafeMath.mul(_recievers.length,_value);
        require(balances[msg.sender] >=total);
        
        // subtract from sender
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], total);
        
        for(uint i = 0; i < _recievers.length; i++){
            balances[_recievers[i]] = SafeMath.add(balances[_recievers[i]], _value);
        }
        return balances[_recievers[0]];
    }
    
}