pragma solidity ^0.4.8;

contract Token {
    uint256 public totalSupply;

    function balanceOf(address _owner) constant returns (uint256 balance);
    function transfer(address _to, uint256 _amount) returns (bool success);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
