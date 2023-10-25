// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.9.0;

contract lec6 {
    uint256 public a = 1;

    //1. view
    function read_a() public view returns(uint256) {
        return a + 2;
    }

    //2.pure
    function read_a2() public pure returns(uint256) {
        uint256 b = 1;
        return 4+2+b;
    }

    //3. pure, view : X
    function read_a3() public returns(uint256) {
        a = 13;
        return a;
    }
}