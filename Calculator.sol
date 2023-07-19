// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract testcontract {
    string public Calculator; 
    function GetSum(int Num1, int Num2) public pure returns(int) {
       int Sum = Num1 + Num2;
       return Sum;
    }
    function GetSub(int Num1, int Num2) public pure returns(int) {
        int Sub = Num1 - Num2 ;
        return Sub;
    }
    function GetProduct(int Num1, int Num2) public pure returns(int){
        int Product = Num1 * Num2 ;
        return Product;
    }
    function GetDivision(int Num1, int Num2) public pure returns(int){
        int Division = Num1 / Num2;
        return Division;
    }
	
} 

