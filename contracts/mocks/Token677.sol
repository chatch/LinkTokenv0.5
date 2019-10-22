pragma solidity ^0.5.0;


import "../ERC677Token.sol";
import "../token/linkStandardToken.sol";


contract Token677 is linkStandardToken, ERC677Token {
    string public constant name = "Example ERC677 Token";
    string public constant symbol = "ERC677";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;

    constructor (uint _initialBalance) public {
        balances[msg.sender] = _initialBalance;
        totalSupply = _initialBalance;
    }
}
