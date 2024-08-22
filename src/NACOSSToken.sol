// SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

interface IERC20 {
    function totalSupply() external pure returns (uint);
    function balanceOf(address address_) external returns (uint);
    function approve(address _spender, uint _amount) external returns (bool);
    function transfer(address _to, uint _amount) external returns (bool);
    function transferFrom(
        address _owner,
        address _to,
        uint _amount
    ) external returns (bool);
    function allowance(
        address _owner,
        address _spender
    ) external returns (uint);`

    // event
    event Transfer(address indexed _from, address indexed _to, uint _amount);
    event Approval(address _owner, address _spender, uint _amount);
}

contract NACOSSTOKEN is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint _totalSupply;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    constructor() {
        name = "NACOSS TOKEN";
        symbol = "NCST";
        decimals = 2;
    }

    function totalSupply() public returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address address_) public returns (uint) {
        return balances[address_];
    }
    function approve(address _spender, uint _amount) public returns (bool) {
        allowed[msg.sender][_spender] = _amount;
    }

    function transfer(address _to, uint _amount) public returns (bool) {
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = balances[_to] + _amount;
        emit Transfer(msg.sender, _to, _amount);
    }
}
