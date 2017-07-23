pragma solidity ^0.4.8;

import "./Token.sol";

contract StandardToken is Token {

    mapping (address => uint256) balances;

    function transfer(address _to, uint256 _value) returns (bool success) {
        if(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function balanceOf(address _owner) constant returns (uint256 _value) {
        return balances[_owner];
    }

}
