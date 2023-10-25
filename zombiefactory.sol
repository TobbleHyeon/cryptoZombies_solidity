pragma solidity ^0.4.19; // 새로운 컴파일 버전이 나오더라도 기존 코드가 깨지지 않도록 버전을 명시함.

contract ZombieFactory {
    // contract 기본골조

    event NewZombie(uint zombieId, string name, uint dna); // 유저단에서 컨트랙트에 액션이 발생했을 때 작동

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

    // 매핑 (key => value)
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) public ownerZombieCount;
    

    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) -1; // 좀비의 id는 zombies.length -1 값으로 생성함.

        zombieToOwner[id] = msg.sender; // 좀비의 id값을 넣은 후, ID를 msg.sender에 zombieToOwner 매핑을 업데이트해서 저장한다. 
        ownerZombieCount[msg.sender]++; // ownerZombieCount 카운트를 +1 증가시킨다. 

        emit NewZombie(id, _name, _dna);
    }

    function _privateCreateZombie(string _name, uint _dna) private { // private 함수는 관례상 함수명 앞에 underScore를 넣어준다.
        zombies.push(Zombie(_name, _dna));
    }

    function _generateRandomDna (string _str) private view returns (uint) { 
        // returns 로 써줘야됨 return 아님! returns 타입 정의해줘야 함.
        // 솔리디티 함수 제어자로 view, pure가 있음.

        // view는 함수밖의 변수를 읽을 수는 있으나, 변수의 값을 변경할 수 없음.
        // pure는 함수밖의 변수를 읽을 수도 없고, 변수의 값을 변경할 수도 없음.
        uint rand = uint(keccak256(abi.encodePacked(_str))); //keccak256 : 256비트 16진수로 변환하여 반 랜덤인 반환값 출력
        return rand % dnaModulus;
    }

    
    function createRandomZombie(string _name) public { // 좀비의 이름을 입력값으로 받아 랜덤 DNA를 가진 좀비를 만드는 public 함수를 생성.
        require(ownerZombieCount[msg.sender] == 0); // require : 특정 조건이 참이 아닐 때 함수가 에러 메세지를 발생하고 실행을 멈추게 함.
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

} 
