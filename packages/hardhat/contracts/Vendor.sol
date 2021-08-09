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

  function sellTokens(uint256 _amountOfTokens) public payable {

    uint256 amountOfTokens = _amountOfTokens * 10**18;
    uint256 _amountToSend = _amountOfTokens * pricePerToken;

    console.log("address(this)", address(this));
    console.log("msg.sender", msg.sender);


    yourToken.transfer(msg.sender, amountOfTokens);
    // payable(msg.sender).transfer(amountOfTokens * pricePerToken);
    // emit SellTokens(msg.sender, _amountToSend, amountOfTokens);

  }

  //ToDo: create a withdraw() function that lets the owner, you can 
  //use the Ownable.sol import above:
}