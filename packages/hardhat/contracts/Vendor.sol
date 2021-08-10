pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";
import "hardhat/console.sol";

contract Vendor is Ownable {

  YourToken yourToken;
  uint256 public constant tokensPerEth = 100;
  uint256 public pricePerToken = 0.001 ether;

  event BuyTokens(address _buyer, uint256 _amountOfETH, uint256 _amountOfTokens);
  event SellTokens(address _seller, uint256 _amountOfETH, uint256 _amountOfTokens);

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  //ToDo: create a payable buyTokens() function:

  function buyTokens(uint256 _amountOfTokens) public payable {
    require(msg.value > 0, "No ETH in transaction");

  
    uint256 amountOfTokens = _amountOfTokens * 10**18;
    uint256 checkedValue = msg.value / pricePerToken;

    require(checkedValue == _amountOfTokens, "Must send the exact amount of ETH for amount of tokens");

    require(yourToken.transfer(msg.sender, amountOfTokens));

    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  //ToDo: create a sellTokens() function:

  function sellTokens(uint256 _amountOfTokens) public {
    require(_amountOfTokens > 0, "You need to sell at least some tokens");

    uint256 amountOfTokensWei = _amountOfTokens * 10**18;
    uint256 _amountToSend = _amountOfTokens * pricePerToken;
    uint256 allowance = yourToken.allowance(msg.sender, address(this));

    require(allowance >= amountOfTokensWei, "Check the token allowance");

    require(yourToken.transferFrom(msg.sender, address(this), amountOfTokensWei), "Failed to send tokens");

    (bool sent) = (payable(msg.sender)).call{value: _amountToSend}("");
    require(sent, "Failed to send Ether");
    
    // require(payable(msg.sender).transfer(_amountToSend), "Failed to send ETH");
    
    emit SellTokens(msg.sender, _amountToSend, _amountOfTokens);
  }

  //ToDo: create a withdraw() function that lets the owner, you can 
  //use the Ownable.sol import above:

  function withdraw(uint256 _amountToWithdrawWei) public onlyOwner {
    require(_amountToWithdrawWei > 0, "You need to withdraw at least some tokens");
    require(address(this).balance >= _amountToWithdrawWei, "The vendor contract does not hold enough ETH to fill your request");

    (bool sent) = (payable(msg.sender)).call{value: _amountToWithdrawWei}("");
    require(sent, "Failed to send Ether");
  }
}