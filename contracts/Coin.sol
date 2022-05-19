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