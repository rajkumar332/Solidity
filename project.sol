pragma solidity ^0.5.11;

contract project{
    
struct producer{
    string fullname;
    address id;
    uint age;
    bool auditor;
    uint land_in_acres;
    uint untilised_land;
    string crop;
    int reputation;
}
struct adm{
    string name;
    address id;
    
}
struct commitments{
    address farmer_id;
    string crop;
    uint land;
    bool verified;
    address verified_by;
    bool reputation_given;
}

adm[] admi;
commitments[] public com;

mapping(address=>producer) public farmers;
address[] fars;

mapping(address=>bool) farmers_add;
mapping(address=>bool)  administrators;
mapping(address=>bool) auditors;

struct add_admin{
    string name;
    address add;
    uint noOfConfirmations;
}
add_admin[] adding;

constructor(string memory fullname) public {
    admi.push(adm(fullname,msg.sender));
    administrators[msg.sender]=true;

}

function add_administrator(string memory _name,address new_admin) public{
    require(administrators[msg.sender],"Only administrators can add");
    adding.push(add_admin(_name,new_admin,1));


}

function approve_administrator(uint _id)public{
    require(administrators[msg.sender],"Only administrators can Approve");
    adding[_id].noOfConfirmations +=1;
    if(adding[_id].noOfConfirmations>=(admi.length/2) +1){
        admi.push(adm(adding[_id].name,adding[_id].add));
    }
}


function farmer_registration(address add,string memory _name,uint _age,uint _land,string memory _crop)public {
    require(administrators[msg.sender],"Only Administrators can Register");
   farmers[add]=producer({id:add,fullname:_name,age:_age,auditor:false,land_in_acres:_land,crop:_crop,reputation:1,untilised_land:_land});
   farmers_add[add]=true;
   fars.push(add);
   
}

function make_commitment(string memory _crop,uint _land)public{
    require(farmers_add[msg.sender],"only farmers can make commitment");
    com.push(commitments({farmer_id:msg.sender,crop:_crop,land:_land,verified:false,verified_by:address(0),reputation_given:false}));

}
function confirm_commitment(uint id)public{
    require(administrators[msg.sender]==true || auditors[msg.sender]==true,"only auditor or administrators can confirm commitment");
    require(com[id].verified==false,"Already Verified");
    if(com[id].land<=farmers[com[id].farmer_id].untilised_land){
    farmers[com[id].farmer_id].reputation -=1;
    revert("incorrect commitment Reputation Decreased"); 
    }
    else{
        farmers[com[id].farmer_id].reputation +=1;
        farmers[com[id].farmer_id].untilised_land -=com[id].land;
        com[id].verified_by=msg.sender;
        com[id].verified=true;
        com[id].reputation_given=true;

    }

   // require(com[id].land<=farmers[com[id].farmer_id].untilised_land,"incorrect commitment");
}

function make_auditors()public{
    for(uint i=0;i<fars.length;i++){
        if(farmers[fars[i]].reputation>=10){
            farmers[fars[i]].auditor=true;
            auditors[fars[i]]=true;

        }
    }
}

function revoke()public{
for(uint i=0;i<fars.length;i++){
        if(farmers[fars[i]].reputation<=-10){
            delete farmers[fars[i]];
            delete fars[i];

        }
    }



}


}
