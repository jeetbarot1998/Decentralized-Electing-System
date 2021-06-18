pragma solidity >=0.4.22 <0.8.0;

// We want to model a candidate using struct. As in what are the params of the candidate
// Store the candidate params
// Fetch yhe data of candidate
// Store the count of how many candidiate are there.
contract Election {
    // string public candidate;
    //=============================================================================================================
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    //============================================================================================================
    //storing accounts that have already voted
    mapping(address => bool) public voters;
    // address as a key
    // so if someone has voted, then the address will be stored as key and the respective value which is of type bool
    // will bbe given as true. This way we can figure if someone or rather some address has voted or not 
    //==============================================================================================================
    // when we add a candidate to this mapping.
    // we are changing the state of the contract and add to the blockchain.
    mapping (uint => Candidate) public candidates;
    // mapping is a key value pair. like dictionary in Python.
    // in solidity there is no way to DETERMINE THE SIZE OF THE MAPPING
    // and NO WAY TO ITERATE OVER A MAPPING
   // HENCE to keep a track of how many candidates are being created in the election
    uint public candidatesCount;
    // so we will update this "candidiateCount" whenever we are adding a Candidate, so that we can later loop over the mapping.

    //==================================================================================================================
    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
    //==================================================================================================================

    
    function vote (uint _candidateId) public{
        // we have passed the msg.sender address to the mapping and checking if the address has already voted before. 
        // The mapping will return TRUE if the address exists in the mapping "voters".
        // The mapping will return FALSE if the address does not exists in the mapping "voters".
        require(!voters[msg.sender] , " You can't Vote Twice ");

        // To make sure the user can only vote for relevant Candidates.
        require(_candidateId > 0 && _candidateId <= candidatesCount , " Invalid Candidate Id. ");

        // update the vote status of candidate
        candidates[_candidateId].voteCount++;

        // record that the voter has voted once to avoid multiple voting
        voters[msg.sender] = true;
    }

    //=============================================================================================================
    // Adding a new Candidate to our blockchain or mapping.
    // we make this function "private" bcz we dont want anyone else to be able to create or add a new candidate to the mappin or blockchain
    // Just want the contract to be able to add a new Candidate.
    // So the candidates must be added to the very start in the constructor.
    // we use an "_" as it is a state variable not a local variable to the function. Its a good practice.

    function addCandidate (string memory _name) private {
        // here we increase the candidatesCount bcz to get the length and pass the id to the mapping
        candidatesCount ++;
        //  mappingname[the uint id or the key]= Custom Struct name(Id or candidatesCount , name, initial vote count =0 )
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

}





