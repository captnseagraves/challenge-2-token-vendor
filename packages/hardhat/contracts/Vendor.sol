pragma solidity >=0.6.0 <0.7.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  YourToken yourToken;
  uint256 public constant tokensPerEth = 100;

  event BuyTokens(address _buyer, uint256 _amountOfETH, uint256 _amountOfTokens);

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  //ToDo: create a payable buyTokens() function:

  function buyTokens(uint256 amountOfTokens) public payable {
    

    transfer(msg.sender, amount of tokens)

    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  //ToDo: create a sellTokens() function:

  //ToDo: create a withdraw() function that lets the owner, you can 
  //use the Ownable.sol import above:
}
