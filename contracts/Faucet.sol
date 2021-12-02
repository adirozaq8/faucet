// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {
    receive() external payable {}

    function addFunds() external payable {}

    function justTesting() external pure returns (uint256) {
        return 2 + 2;
    }

    /*
        pure, view --- read only call, no gas fee
        view -> it indicates that the function will not alter the storage state in any way
        pure -> even more strict, indicating thath it won't even read the storage state
    */

    /*
        Transaction (can generate state changes) and require gas fee
    */
}

// const instance = await Faucet.deployed()
// instance.addFunds({value: "2000000000000000000"})

// web3.eth.sendTransaction({from: address, to: address/smart_contract, data: hashed_keccak256_function (4 bytes), value: value_in_wei})
