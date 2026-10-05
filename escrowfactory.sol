// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Escrow.sol";

contract EscrowFactory {
    address[] public deployedEscrows;

    event EscrowCreated(address indexed escrowAddress, address indexed buyer, address indexed seller, address arbitrator);

    function createEscrow(address _seller, address _arbitrator) external returns (address) {
        // Deploys a new instance of the Escrow contract
        Escrow newEscrow = new Escrow(msg.sender, _seller, _arbitrator);
        
        deployedEscrows.push(address(newEscrow));
        
        emit EscrowCreated(address(newEscrow), msg.sender, _seller, _arbitrator);
        return address(newEscrow);
    }

    function getDeployedEscrows() external view returns (address[] memory) {
        return deployedEscrows;
    }
}
}
