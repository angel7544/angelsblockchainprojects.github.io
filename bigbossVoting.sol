/*** BigBoss Voting 

The BigBoss:    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

Particpients names:     LordPuneet, FukraInsaan, PujaBhatt, ElvishYadav
Particpients names:     LordPuneet, FukraInsaan, PujaBhatt, ElvishYadav
(name, bytes32-encoded name, account)

LordPuneet:              0x416c696365000000000000000000000000000000000000000000000000000000  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

FukraInsaan:              0x4265747479000000000000000000000000000000000000000000000000000000  0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

PujaBhatt:            0x436563696c696100000000000000000000000000000000000000000000000000  0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB

ElvishYadav:               0x44616e6100000000000000000000000000000000000000000000000000000000  0x617F2E2fD72FD9D5503197092aC168c91465E7f2

Contract input argument:
["0x416c696365000000000000000000000000000000000000000000000000000000","0x4265747479000000000000000000000000000000000000000000000000000000","0x436563696c696100000000000000000000000000000000000000000000000000","0x44616e6100000000000000000000000000000000000000000000000000000000"]
***/

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

contract Token {
    struct Voter {
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

    struct Particpient {
        bytes32 name;
        uint voteCount;
    }

    address public BigBoss;

    mapping(address => Voter) public voters;

    Particpient[] public particpients;

    constructor(bytes32[] memory particpientNames) {// used to intialize the indexing
        BigBoss = msg.sender;
        voters[BigBoss].weight = 1;

        for (uint i = 0; i < particpientNames.length; i++) {
            particpients.push(Particpient({
                name: particpientNames[i],
                voteCount: 0
            }));
        }
    }

    function giveRightToVote(address voter) external {
        require(
            msg.sender == BigBoss,
            "Only BigBoss can give right to vote."
        );
        require(
            !voters[voter].voted,
            "The voter already voted."
        );
        require(voters[voter].weight == 0);
        voters[voter].weight = 1;
    }

//    function delegate(address to) private {
        // Voter storage sender = voters[msg.sender];
        // require(!sender.voted, "You already voted.");
        // require(to != msg.sender, "Self-delegation is disallowed.");

        // while (voters[to].delegate != address(0)) {
            // to = voters[to].delegate;

            // require(to != msg.sender, "Found loop in delegation.");
        // }

        // Voter storage delegate_ = voters[to];
        // sender.voted = true;
        // sender.delegate = to;

        // if (delegate_.voted) {
            // proposals[delegate_.vote].voteCount += sender.weight;
        // } else {
            // delegate_.weight += sender.weight;
        // }
    // }

    function vote(uint particpient) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = particpient;

        particpients[particpient].voteCount += sender.weight;
    }

    function winningParticpient() public view
            returns (uint winningParticpient_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < particpients.length; p++) {
            if (particpients[p].voteCount > winningVoteCount) {
                winningVoteCount = particpients[p].voteCount;
                winningParticpient_ = p;
            }
        }
    }

    function winnerName() external view
            returns (bytes32 winnerName_)
    {   
        winnerName_ = particpients[winningParticpient()].name;
    }
}   
