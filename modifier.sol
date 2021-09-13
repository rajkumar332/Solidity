pragma solidity ^0.7.5;
contract mycontract{
    uint peoplecount=0;
    mapping(uint=>Person) public people;
    struct Person{
        uint id;
        string fname;
        string lname;
    }
    address owner;
    modifier onlyowner{
        require(msg.sender==owner);
        _;
    }
    constructor() public{
        owner=msg.sender;
    }
    function addPerson(string memory f_name,string memory l_name) public onlyowner {
        incount();
        people[peoplecount]=Person(peoplecount,f_name,l_name);
    }
    function incount() internal{
        peoplecount++;
    }
}
