//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Grant {
   

   struct Allocation {
    uint id;
    uint duration;
    uint amount;
    
   }
    uint  duration;

    mapping (address => uint) allocationCount;
  mapping  (address=> mapping (uint => Allocation)) allocationClaim;
    
    Allocation[] allocations;

   
    event allocationGranted(address indexed sender, uint256 indexed amount, address receiver);

    event allocationClaimed(address indexed claimer, uint256 indexed amount, uint allocationId);

    function allocateGrant(address _receiver, uint _duration) external payable {
        //sanity check
        require(msg.sender != address(0), "wrong EOA");
        require(msg.value > 0, "can't save zero value");

        allocationCount[_receiver] ++;

        uint _id = allocationCount[_receiver] ;

        duration = _duration + block.timestamp;

        uint _amount = msg.value;
       

        payable(address(this)).transfer(msg.value);

        Allocation memory newAllocation = Allocation(_id, duration, _amount );

        allocationClaim[_receiver][_id] = newAllocation;

        emit allocationGranted (msg.sender, _amount,  _receiver);
    }

    function claim( uint allocationNo) external {
        //sanity check. (checking for address 0)
        require(msg.sender != address(0), "wrong EOA");
    Allocation storage UserAllocation = allocationClaim[msg.sender][allocationNo] ;
        require(UserAllocation.id > 0, "invalid allocation id");

    require(UserAllocation.amount > 0, "You have no allocations to withdraw");


    require(UserAllocation.duration < block.timestamp, "not time yet");

        payable(msg.sender).transfer(UserAllocation.amount);

        emit allocationClaimed(msg.sender, UserAllocation.amount, UserAllocation.id);


    }

    function checkAllocations(address _user, uint allocationNo) external view returns (uint256) {
         Allocation storage UserAllocation = allocationClaim[_user][allocationNo] ;

        return (UserAllocation.amount);
    }

     function checkMaturityTimeLeft(address _user, uint allocationNo) external view returns (uint256, string memory) {
         Allocation storage UserAllocation = allocationClaim[_user][allocationNo] ;

         if(UserAllocation.duration >= block.timestamp){
         uint timeLeft =   UserAllocation.duration - block.timestamp;
        return ( timeLeft, " ");
         }
        else {
            return (0, "Allocation matured");
            }


    }

      receive() external payable {
        
    }
}