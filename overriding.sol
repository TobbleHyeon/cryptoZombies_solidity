// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;


contract Father {
    string public familyName = "Kim";
    string public giveName = "Jung";
    uint256 public money = 100;

    constructor(string memory _givenName) {
        giveName = _givenName;
    }

    function getFamilyName() view public returns(string memory) {
        return familyName;
    }

    function getGivenName() view public returns(string memory) {
        return giveName;
    }

    function getMoney() view virtual public returns(uint256) {
        return money;
    }
}

contract Son is Father {

    constructor() Father("James"){
        
    }
    uint256 public earning = 0;
    function work() public {
        earning += 100;
    }

    function getMoney() view override public returns(uint256) {
        return money + earning;
    }
    
}