pragma solidity ^0.5.0;


import '../token/linkBasicToken.sol';


// mock class using BasicToken
contract BasicTokenMock is linkBasicToken {

  constructor (address initialAccount, uint initialBalance) public
  {
    balances[initialAccount] = initialBalance;
    totalSupply = initialBalance;
  }

}
