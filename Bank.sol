pragma solidity 0.5.2;

import "./Ownable.sol"

contract Bank is Ownable {
        
    mapping(address => uint) balance;
    bool private _paused;
    
    constructor () internal {
        _paused = false;
    }
    
    // allow to execute when not paused
    modifier whenNotPaused() {
        require(!_paused);
        _;
    }
    modifier whenPaused() {
        require(!_paused);
        _;
    }
    
    function pause() public onlyOwner whenNotPaused {
        _paused = true;
    }
    
    function unPause() public onlyOwner whenPaused{
        _paused = false;
    }
    
    function withdrawAll() public {
        uint amountToWithdraw = balances[msg.sender];
        balances[msg.sender] = 0;
        require(smg.sender.call.valu(amountToWithdraw));
    }
    
    function emergncywithdrawl() public onlyOwner whenPaused{
        //withdrawl to owner
    }
    
}