// SPDX-License-Identifier:MIT
pragma solidity ^0.8.24;

interface IERC20 {
    function totalSupply() external returns (uint);
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
    ) external returns (uint);

    // event
    event Transfer(address indexed _from, address indexed _to, uint _amount);
    event Approval(address _owner, address _spender, uint _amount);
}

contract NACOSSTOKEN is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint _totalSupply;
    address public owner_;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    constructor() {
        name = "NACOSS TOKEN";
        symbol = "NCST";
        decimals = 2;
        _totalSupply = 100000000;
        balances[msg.sender] = _totalSupply;
        owner_ = msg.sender;
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address address_) public view returns (uint) {
        return balances[address_];
    }
    function approve(address _spender, uint _amount) public returns (bool) {
        allowed[msg.sender][_spender] = _amount;
        return true;
    }

    function transfer(address _to, uint _amount) public returns (bool) {
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = balances[_to] + _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferFrom(
        address owner,
        address _to,
        uint _amount
    ) public returns (bool) {
        require(
            allowed[owner][msg.sender] >= _amount,
            "Limit to spend exceeded"
        );
        require(balances[owner] > _amount, "Insufficient balance");
        balances[owner] = balances[owner] - _amount;
        balances[_to] = balances[_to] + _amount;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - _amount;
        emit Transfer(owner, _to, _amount);
        return true;
    }

    function allowance(
        address owner,
        address _spender
    ) public view returns (uint) {
        return allowed[owner][_spender];
    }
}
