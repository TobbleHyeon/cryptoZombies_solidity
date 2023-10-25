pragma solidity ^0.4.19;

import './zombiefactory.sol'; // ZombieFactory를 상속하기 위한 import 구문

contract KittyInterface { // 좀비의 먹이(...) interface를 정의한다. contract를 만드는 방법과 동일함.
    function getKitty(uint256 _id) external view returns (bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes);
}

contract ZombieFeeding is ZombieFactory { // 상속, ZombieFeeding 컨트랙트가 ZombieFactory 컨트랙트를 상속받는다.
    
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d; 
    KittyInterface kittyContract = KittyInterface(ckAddress); // kittyContract를 정의하고 kittyContract를 ckAddress로 초기화함.
    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId]; 
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;

        if(keccak256(abi.encodePacked(_species)) == keccak256("kitty")) {
            newDna = newDna - newDna % 100 + 99;
        }
        _createZombie("NoName", newDna); // ZombieFeeding 에서 _createZombie 함수를 사용할 수 있도록 _createZombie 원본 함수로 돌아가, internal로 처리한다.
    }

    function feedOnKitty (uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}