// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

    uint public numOfFunders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    receive() external payable {}
    function addFunds() external payable {
        address funder = msg.sender;

        if(!funders[funder]) {
            uint index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function withdraw(uint withdrawAmount) external {
        require(withdrawAmount <= 100000000000000000, "Cannot withdraw more than 0.1 ETH");
        payable(msg.sender).transfer(withdrawAmount);
    }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);

        for(uint i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }

        return _funders;
    }

    function getFunderAtIndex(uint index) external view returns(address) {
        return lutFunders[index];
    }

    /*
        pure, view --- read only call, no gas fee
        view -> it indicates that the function will not alter the storage state in any way
        pure -> even more strict, indicating thath it won't even read the storage state
    */

    /*
        Transaction (can generate state changes) and require gas fee
    */

    // public can be accessed by internal function, external cannot
}

// const instance = await Faucet.deployed()
// instance.addFunds({value: "2000000000000000000"})

// web3.eth.sendTransaction({from: address, to: address/smart_contract, data: hashed_keccak256_function (4 bytes), value: value_in_wei})

// instance.addFunds({value: "2000000000000000000", from: accounts[0]})
// instance.funders(0) --> mandatory param, just like index array