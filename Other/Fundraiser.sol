pragma solidity ^0.4.8;

contract Fundraiser{
    
    mapping(address => uint) balances;
    
    function contribute() public payable{
        balances[msg.sender] += msg.value;
    }
    
    function withdraw() public{
        if(balances[msg.sender] == 0){
            revert();
        }
        
        // FIX
        //balances[msg.sender] = 0;
        //msg.sender.call.value(balances[msg.sender])();
        
        // Problem
        if(msg.sender.call.value(balances[msg.sender])()){
            balances[msg.sender] = 0;
        } else {
            revert();
        }
    }
    
    function getFunds() public view returns(uint){
        return address(this).balance;
    }
}

