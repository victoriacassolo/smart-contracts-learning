pragma solidity ^0.8.4;

contract Coin {
    //endereço do dono
    address public minter;
    // array para adicionar o endereço de cada pessoa que tiver a coin
    // e seu valor: balances
    mapping (address => uint) public balances;

    // An event that after emited returns the arguments for client through web3.js
    // it has costs
    event Sent(address from, address to, uint amount);

    // Executed during the creation of the contract and canot be called afterwards.
    constructor() {
        // people has created the contract
        minter = msg.sender;
        // msg.sender is always the address that call the current function.
    }

// mintar quando seu NFT é criado e adicionado a um endereço na rede blockchain
// users and contracts can call this
    function mint(address receiver, uint amount) public {
        // require is a condition that reverts all changes if not true
        // ensures that only the creator of the contract can call mint.
        require(msg.sender == minter);

        // uint have a max value that limit for not have an overflow.
        // Checked Arithmetic uint
        balances[receiver] += amount;
    }

    // errors provide more informations to caller about operation failed.
    error InsufficientBalance(uint requested, uint available);

    // users and contracts can call this
    function send(address receiver, uint amount) public {
        // if the amount is greater than the sender
        if(amount > balances[msg.sender])
            // revert: aborts and reverts all changes and Insu.. look at the error
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        // balances amount currency of the sender decreases the amount parameter
        balances[msg.sender] -= amount;

        // balances amount currency of the receiver increases the amount parameter
        balances[receiver] += amount;

        // An event that after emited returns the arguments for client through web3.js
        emit Sent(msg.sender, receiver, amount);
    }
}


/*
pragma solidity ^0.6.0;

// SPDX-License-Identifier: MIT

import "./SafeMath.sol";


    // @title Bare-bones Token implementation
    // @notice Based on the ERC-20 token standard as defined at
    //         https://eips.ethereum.org/EIPS/eip-20

contract Token {

    using SafeMath for uint256;

    string public symbol;
    string public name;
    uint256 public decimals;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _decimals,
        uint256 _totalSupply
        
    )
        public
    {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    
        // @notice Getter to check the current balance of an address
        // @param _owner Address to query the balance of
        // @return Token balance
     
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function mint(address _to, uint256 value) public returns (bool) {
        require(owner == msg.sender, "not allowed");
        require(address(0) != _to);
        balances[_to] += value;
        emit Transfer(address(0), _to, value);

        return true;
    }

    function burn(uint256 value) public returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, address(0), value);

        return true;
    }

    
        // @notice Getter to check the amount of tokens that an owner allowed to a spender
        // @param _owner The address which owns the funds
        // @param _spender The address which will spend the funds
        // @return The amount of tokens still available for the spender
     
    function allowance(
        address _owner,
        address _spender
    )
        public
        view
        returns (uint256)
    {
        return allowed[_owner][_spender];
    }

    
        // @notice Approve an address to spend the specified amount of tokens on behalf of msg.sender
        // @dev Beware that changing an allowance with this method brings the risk that someone may use both the old
        //      and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
        //      race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
        //      https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
        // @param _spender The address which will spend the funds.
        // @param _value The amount of tokens to be spent.
        // @return Success boolean
     
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    //  shared logic for transfer and transferFrom
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(balances[_from] >= _value, "qualquer coisa");
        require(address(0) != _to);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(_from, _to, _value);
    }

    
        // @notice Transfer tokens to a specified address
        // @param _to The address to transfer to
        // @param _value The amount to be transferred
        // @return Success boolean
     
    function transfer(address _to, uint256 _value) public returns (bool) {
        _transfer(msg.sender, _to, _value);

        return true;
    }

    
        // @notice Transfer tokens from one address to another
        // @param _from The address which you want to send tokens from
        // @param _to The address which you want to transfer to
        // @param _value The amount of tokens to be transferred
        // @return Success boolean
     
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    )
        public
        returns (bool)
    {
        require(allowed[_from][msg.sender] >= _value, "Insufficient allowance");
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }

}
*/