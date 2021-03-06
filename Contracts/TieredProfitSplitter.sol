pragma solidity ^0.5.0;


contract TieredProfitSplitter {
    address payable employee_one; // CEO
    address payable employee_two; // CTO
    address payable employee_three; // Bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

  
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    
    // Makes deposits to different tiers of associate-level employees
    function deposit() public payable {
        uint points = msg.value / 100;
        uint total;
        uint amount;

        amount = points * 60; 
        total += amount;
        employee_one.transfer(amount);              // CEO retains 60% of profits

        amount = points * 25; 
        total += amount;
        employee_two.transfer(amount);               // CTO retains 25% of profits

        amount = points * 15; 
        total += amount;
        employee_three.transfer(amount);             // Bob level employees retain 15% of profits
        
        employee_one.transfer(msg.value - total);    // CEO retains the remaining funds
    }

    function() external payable {
        deposit();
    }
}
