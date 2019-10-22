pragma solidity ^0.5.0;


import '../token/linkERC20.sol';


contract LinkReceiver {

  bool public fallbackCalled;
  bool public callDataCalled;
  uint public tokensReceived;


  function onTokenTransfer(address _from, uint _amount, bytes memory _data)
    public
    returns (bool success)
  {
    fallbackCalled = true;
    if (_data.length > 0) {
        (success,) = address(this).delegatecall(
          abi.encode(_data, msg.sender, _from, _amount)
        );
      require(
        success == true,
        "onTokenTransfer delegatecall failed"
      );
    }
    return true;
  }

  function callbackWithoutWithdrawl () public {
    callDataCalled = true;
  }

  function callbackWithWithdrawl(uint _value, address _from, address _token) public {
    callDataCalled = true;
    linkERC20 token = linkERC20(_token);
    token.transferFrom(_from, address(this), _value);
    tokensReceived = _value;
  }

}
