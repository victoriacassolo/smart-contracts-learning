pragma solidity ^0.8.4;

//var with a _ means that set a value and without _ means get a value

contract SimpleContract {
    uint value;

    function setValue(uint _value) external {
        value = _value;
    }

    function getValue() external view returns(uint) {
        return value;
    }
}