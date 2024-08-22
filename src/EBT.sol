// SPDX-License-Identifier:MIT
pragma solidity >=0.8.26;

//safeMath library
import "./SafeMath/SafeMath.sol";

// interface

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address _address) external returns (uint256 balance);
    function approve(
        address _spender,
        uint256 _value
    ) external returns (bool success);
    function allowance(
        address _owner,
        address _spender
    ) external returns (uint256 remaining);
    function transfer(
        address _to,
        uint256 _value
    ) external returns (bool success);
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);

    //events
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _amount
    );
    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
}

contract Ownable {
    address public owner;
    bytes32 public ROLE_ID = keccak256("ADMIN_ROLE");
    mapping(bytes32 => mapping(address => bool)) public roles;

    constructor() {
        owner = msg.sender;
        roles[ROLE_ID][owner] = true;
    }

    modifier isOwner() {
        require(msg.sender == owner, "Permission denied");
        _;
    }

    function grantPermission(
        bytes32 ROLE,
        address _address
    ) public isOwner returns (bool) {
        roles[ROLE][_address] = true;
        return true;
    }
}

contract Token is IERC20, Ownable {
    using SafeMath for uint256;

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public _totalSupply;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    //constructor
    constructor() Ownable() {
        name = "Ether Bill Token";
        symbol = "EBT";
        decimals = 2;
    }

    function totalSupply() public view returns (uint256 total) {
        return _totalSupply;
    }
    function balanceOf(address _address) public view returns (uint256) {
        return balances[_address];
    }
    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transfer(
        address _to,
        uint256 _amount
    ) public returns (bool success) {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        balances[_to] = balances[_to].add(_amount);
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferFrom(
        address _owner,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(allowed[_owner][msg.sender] >= _value, "Limit exceeded");
        require(balances[_owner] >= _value, "Insufficient balance");
        balances[_owner] = balances[_owner].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(_value);
        emit Transfer(_owner, _to, _value);
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function _mint(address _to, uint256 _amount) internal returns (bool) {
        balances[_to] = balances[_to].add(_amount);
        _totalSupply = _totalSupply.add(_amount);
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function mint(address _to, uint256 _amount) public isOwner returns (bool) {
        return _mint(_to, _amount);
    }
}
