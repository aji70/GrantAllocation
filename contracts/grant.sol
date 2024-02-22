//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Grant {
    //need to be able to track a user to their saved amount. best tool to use is mapping
    //mappings are basically for TRACKING
    uint public duration;
    mapping(address => uint256) savings;
    //this will inititiate an event to log actions that occur in a smart contract, will 
    //to the front end. Indexing allows querrying events on the blockchain faster and 
    //can take only 3 per event.
    event savingSuccessful(address indexed user, uint256 indexed amount);

    function deposit(address _receiver, uint _duration) external payable {
        //sanity check
        require(msg.sender != address(0), "wrong EOA");
        require(msg.value > 0, "can't save zero value");

        duration = _duration + block.timestamp;

        

        payable(address(this)).transfer(msg.value);
        savings[_receiver] = savings[_receiver] + msg.value;

        
        emit savingSuccessful(msg.sender, msg.value);
    }

    function claim() external {
        require(msg.sender != address(0), "wrong EOA");
        require(duration < block.timestamp, "Not Eligible to claim");

        uint256 _userSavings = savings[msg.sender];

        require(_userSavings > 0, "you don't have any savings");


        savings[msg.sender] -= _userSavings;

        payable(msg.sender).transfer(_userSavings);
    }

    function checkSavings(address _user) external view returns (uint256) {
        return savings[_user];
    }

      receive() external payable {
        
    }
}