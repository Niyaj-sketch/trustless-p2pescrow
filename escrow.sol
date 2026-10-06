// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    address public buyer;
    address public seller;
    address public arbitrator;
    
    uint256 public amount;
    bool public isCompleted;
    
    enum State { AwaitingPayment, Active, Completed, Refunded, Disputed }
    State public currentState;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this");
        _;
    }

    modifier onlyArbitrator() {
        require(msg.sender == arbitrator, "Only arbitrator can call this");
        _;
    }

    modifier onlyParticipant() {
        require(msg.sender == buyer || msg.sender == seller || msg.sender == arbitrator, "Not a participant");
        _;
    }

    event Funded(address indexed buyer, uint256 amount);
    event Released(address indexed seller, uint256 amount);
    event Refunded(address indexed buyer, uint256 amount);
    event Disputed(address indexed initiator);

    constructor(address _buyer, address _seller, address _arbitrator) {
        buyer = _buyer;
        seller = _seller;
        arbitrator = _arbitrator;
        currentState = State.AwaitingPayment;
    }

    function deposit() external payable onlyBuyer {
        require(currentState == State.AwaitingPayment, "Already funded");
        require(msg.value > 0, "Must send ETH");
        
        amount = msg.value;
        currentState = State.Active;
        emit Funded(msg.sender, msg.value);
    }

    function releaseFunds() external onlyBuyer {
        require(currentState == State.Active, "Escrow not active");
        require(!isCompleted, "Already completed");

        isCompleted = true;
        currentState = State.Completed;
        
        uint256 payout = amount;
        amount = 0;

        (bool success, ) = payable(seller).call{value: payout}("");
        require(success, "Transfer failed");

        emit Released(seller, payout);
    }

    function raiseDispute() external onlyParticipant {
        require(currentState == State.Active, "Can only dispute active trades");
        currentState = State.Disputed;
        emit Disputed(msg.sender);
    }

    function resolveDispute(bool refundToBuyer) external onlyArbitrator {
        require(currentState == State.Disputed, "Not in dispute");
        require(!isCompleted, "Already completed");

        isCompleted = true;
        uint256 payout = amount;
        amount = 0;

        address recipient = refundToBuyer ? buyer : seller;
        if (refundToBuyer) {
            currentState = State.Refunded;
            emit Refunded(buyer, payout);
        } else {
            currentState = State.Completed;
            emit Released(seller, payout);
        }

        (bool success, ) = payable(recipient).call{value: payout}("");
        require(success, "Transfer failed");
    }
}// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    address public buyer;
    address public seller;
    address public arbitrator;
    
    uint256 public amount;
    bool public isCompleted;
    
    enum State { AwaitingPayment, Active, Completed, Refunded, Disputed }
    State public currentState;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this");
        _;
    }

    modifier onlyArbitrator() {
        require(msg.sender == arbitrator, "Only arbitrator can call this");
        _;
    }

    modifier onlyParticipant() {
        require(msg.sender == buyer || msg.sender == seller || msg.sender == arbitrator, "Not a participant");
        _;
    }

    event Funded(address indexed buyer, uint256 amount);
    event Released(address indexed seller, uint256 amount);
    event Refunded(address indexed buyer, uint256 amount);
    event Disputed(address indexed initiator);

    constructor(address _buyer, address _seller, address _arbitrator) {
        buyer = _buyer;
        seller = _seller;
        arbitrator = _arbitrator;
        currentState = State.AwaitingPayment;
    }

    function deposit() external payable onlyBuyer {
        require(currentState == State.AwaitingPayment, "Already funded");
        require(msg.value > 0, "Must send ETH");
        
        amount = msg.value;
        currentState = State.Active;
        emit Funded(msg.sender, msg.value);
    }

    function releaseFunds() external onlyBuyer {
        require(currentState == State.Active, "Escrow not active");
        require(!isCompleted, "Already completed");

        isCompleted = true;
        currentState = State.Completed;
        
        uint256 payout = amount;
        amount = 0;

        (bool success, ) = payable(seller).call{value: payout}("");
        require(success, "Transfer failed");

        emit Released(seller, payout);
    }

    function raiseDispute() external onlyParticipant {
        require(currentState == State.Active, "Can only dispute active trades");
        currentState = State.Disputed;
        emit Disputed(msg.sender);
    }

    function resolveDispute(bool refundToBuyer) external onlyArbitrator {
        require(currentState == State.Disputed, "Not in dispute");
        require(!isCompleted, "Already completed");

        isCompleted = true;
        uint256 payout = amount;
        amount = 0;

        address recipient = refundToBuyer ? buyer : seller;
        if (refundToBuyer) {
            currentState = State.Refunded;
            emit Refunded(buyer, payout);
        } else {
            currentState = State.Completed;
            emit Released(seller, payout);
        }

        (bool success, ) = payable(recipient).call{value: payout}("");
        require(success, "Transfer failed");
    }
}// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    address public buyer;
    address public seller;
    address public arbitrator;
    
    uint256 public amount;
    bool public isCompleted;
    
    enum State { AwaitingPayment, Active, Completed, Refunded, Disputed }
    State public currentState;

    modifier onlyBuyer() {
        require(msg.sender == buyer, "Only buyer can call this");
        _;
    }

    modifier onlyArbitrator() {
        require(msg.sender == arbitrator, "Only arbitrator can call this");
        _;
    }

    modifier onlyParticipant() {
        require(msg.sender == buyer || msg.sender == seller || msg.sender == arbitrator, "Not a participant");
        _;
    }

    event Funded(address indexed buyer, uint256 amount);
    event Released(address indexed seller, uint256 amount);
    event Refunded(address indexed buyer, uint256 amount);
    event Disputed(address indexed initiator);

    constructor(address _buyer, address _seller, address _arbitrator) {
        buyer = _buyer;
        seller = _seller;
        arbitrator = _arbitrator;
        currentState = State.AwaitingPayment;
    }

    function deposit() external payable onlyBuyer {
        require(currentState == State.AwaitingPayment, "Already funded");
        require(msg.value > 0, "Must send ETH");
        
        amount = msg.value;
        currentState = State.Active;
        emit Funded(msg.sender, msg.value);
    }

    function releaseFunds() external onlyBuyer {
        require(currentState == State.Active, "Escrow not active");
        require(!isCompleted, "Already completed");

        isCompleted = true;
        currentState = State.Completed;
        
        uint256 payout = amount;
        amount = 0;

        (bool success, ) = payable(seller).call{value: payout}("");
        require(success, "Transfer failed");

        emit Released(seller, payout);
    }

    function raiseDispute() external onlyParticipant {
        require(currentState == State.Active, "Can only dispute active trades");
        currentState = State.Disputed;
        emit Disputed(msg.sender);
    }

    function resolveDispute(bool refundToBuyer) external onlyArbitrator {
        require(currentState == State.Disputed, "Not in dispute");
        require(!isCompleted, "Already completed");

        isCompleted = true;
        uint256 payout = amount;
        amount = 0;

        address recipient = refundToBuyer ? buyer : seller;
        if (refundToBuyer) {
            currentState = State.Refunded;
            emit Refunded(buyer, payout);
        } else {
            currentState = State.Completed;
            emit Released(seller, payout);
        }

        (bool success, ) = payable(recipient).call{value: payout}("");
        require(success, "Transfer failed");
    }
}
