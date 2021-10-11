pragma solidity ^0.5.0;
// we need 3 different accounts rahul(owner),abdul(mechanic),neeraj(valuation) 
contract bike_selling{
    struct Bike{
        string name;
        uint model;
        uint mileage;
        uint weight;
        uint year_bought;
    }
    
    Bike bike;
    address rahul;
    uint public value;
    string  agreement="No";
    bool[]  condition =new bool[](4);
    address payable abdul;
    address payable neeraj;
    
    constructor() public{
        rahul=msg.sender;
    }
    modifier onlyowner(){
        require(msg.sender==rahul);
        _;
    }
     
     modifier abdul_check(){
         require(msg.sender !=rahul);
         _;
     }
    
     modifier neeraj_valuation(){
         require(msg.sender !=rahul && msg.sender!=abdul);
         _;
     }
    
    
     function addSpecifications(string memory _name,uint _model,uint _mileage,uint _weight, uint _yearbought)public onlyowner{
       
       bike=Bike(_name,_model,_mileage,_weight,_yearbought);
    }
    
  
    function check()public abdul_check{ 
        // will check the conditions and update the conditions array
        // can only be performed by abdul
        
        abdul=msg.sender;
        
        if(bike.model>2017)
        condition[0]=true;
        if(bike.mileage>60)
        condition[1]=true;
        if(bike.weight<=110)
        condition[2]=true;
        if(bike.year_bought>2016)
        condition[3]=true;
    
        
    }
    function valuation()public neeraj_valuation{ //can only be performed by neeraj
        
        uint count=0;
        for(uint i=0;i<4;i++){
            if(condition[i]==true)
            count++;
        }
        if(count==4)
        value=100000;
        else if(count==3){
            value=80000;
        }
        else if(count==2){
            value=5000;
        }
        else{
            value=20000;
        }
        
    }
    function changeagreement()public onlyowner{ //rahul can sell based on value
        agreement="YES";
    }
    
}
