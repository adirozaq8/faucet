// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

    receive() external payable {}
    function addFunds() external payable {}
}

// const instance = await Faucet.deployed()
// instance.addFunds({value: "2000000000000000000"})

// web3.eth.sendTransaction({from: address, to: address/smart_contract, data: hashed_keccak256_function (4 bytes), value: value_in_wei})