pragma solidity ^0.4.19; // 새로운 컴파일 버전이 나오더라도 기존 코드가 깨지지 않도록 버전을 명시함.

contract ZombieFactory {
    // contract 기본골조

    uint dnaDigits = 16; // uint 자료형은 부호가 없는 정수. (값이 음수여서는 안됨.) <<>> int 자료형
    // uint은 uint256을 의미함. etc) uint8, uint16, uint32
    uint dnaModulus = 10 ** dnaDigits;
    
    struct Zombie { // 구조체, 변수 묶음
        string name; // string은 UTF-8 데이터를 위해서 활용됨.
        uint dna;
    }

    // 솔리디티에는 static fixed Array 와 dynamic Array가 있음.
    
    uint[4] fixedUnitArray; // 4개의 원소를 담을 수 있는 정적 배열
    string[10] stringArray; // 5개의 string 원소를 담을 수 있는 정적 배열
    uint[] dynamicArray; // 원소 제한 없는 동적 배열

    Zombie[] public zombies; // public 배열, 솔리디티에서는 public을 선언할 시, getter를 자동 생성해서 공개 데이터 처리.
    

    function createZombie(string _name, uint _dna) public {
        zombies.push(Zombie(_name, _dna)); // Zombie 구조체 구성에 맞게 zombies 배열에 새로운 zombie를 push 해줌.
    }

      function _privateCreateZombie(string _name, uint _dna) private { // private 함수는 관례상 함수명 앞에 underScore를 넣어준다.
        zombies.push(Zombie(_name, _dna));
    }
} 
