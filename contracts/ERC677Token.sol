pragma solidity ^0.5.0;


import "./token/ERC677.sol";
import "./token/ERC677Receiver.sol";


contract ERC677Token is ERC677 {

  /**
  * @dev transfer token to a contract address with additional data if the recipient is a contact.
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  * @param _data The extra data to be passed to the receiving contract.
  */
  function transferAndCall(address _to, uint _value, bytes memory _data)
    public
    returns (bool success)
  {
    // This fails to compile due a Solidity compiler bug:
    //   https://github.com/ethereum/solidity/issues/7558
    // But it as actually what we need ... So restoring it for now.
    //
    // TODO: remove comment here and below once the compiler bug is fixed.
    linkERC20Basic(super).transfer(_to, _value);

    // Replacing the line above with the following line will make the
    // contract compile however this is not what we want as it creates a
    // fresh call and crucially sets msg.sender to the LinkToken address.
    // Thus the transfer will not be from the caller of transferAndCall but
    // from the LinkToken contract itself ...

    // linkERC20Basic(this).transfer(_to, _value);

    emit Transfer(msg.sender, _to, _value, _data);
    if (isContract(_to)) {
      contractFallback(_to, _value, _data);
    }
    return true;
  }


  // PRIVATE

  function contractFallback(address _to, uint _value, bytes memory _data)
    private
  {
    ERC677Receiver receiver = ERC677Receiver(_to);
    receiver.onTokenTransfer(msg.sender, _value, _data);
  }

  function isContract(address _addr)
    private
    view
    returns (bool hasCode)
  {
    uint length;
    // solium-disable-next-line security/no-inline-assembly
    assembly { length := extcodesize(_addr) }
    return length > 0;
  }

}
