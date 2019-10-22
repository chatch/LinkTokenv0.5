pragma solidity ^0.5.0;


import '../token/linkStandardToken.sol';


contract StandardTokenMock is linkStandardToken {

  constructor (address initialAccount, uint initialBalance) public
  {
    balances[initialAccount] = initialBalance;
    totalSupply = initialBalance;
  }

}
