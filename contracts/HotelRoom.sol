//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom{
    enum Statuses{
        VACANT,
        OCCUPIED
    }

    event Occupy(address _occupant,uint _value);

    address payable public owner;
    Statuses public currentStatus;

    constructor(){
        owner = payable(msg.sender);
        currentStatus = Statuses.VACANT;
    }

    modifier onlyWhileVacant{
        require(currentStatus == Statuses.VACANT,"Currently Occupied");
        _;
    }

    modifier costs(uint _amount){
        require(msg.value >= _amount,"Not enough ether provided");
        _;
    }

    function book() payable public onlyWhileVacant costs(2 ether){

        currentStatus = Statuses.OCCUPIED;
        
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);

        emit Occupy(msg.sender, msg.value);
    }
}