pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract SongPlayer {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is candidate name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
  
struct user {
    address userAddress;            //The address of the user
    uint tokensBought;              //total number of tokens this user owns
    uint[] tokensUsedPerSong;       //keep track of amount of money a song has made
    bytes32[] userSongs;            //keep track of which songs user owns
}

mapping (bytes32 => uint) public numPlays;
mapping(address => user) public userInfo;

bytes32[] public songList;
uint public totalTokens;
uint public balanceTokens;
uint public pricePerPlay;
uint public numUsers;

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of candidates who will be contesting in the election
  */
  function SongPlayer(uint tokens, uint pricePerToken, bytes32[] songNames) {
    songList = songNames;
    totalTokens = tokens;
    balanceTokens = tokens;
    pricePerPlay = pricePerToken;
    numUsers = 0;
  }
  
  function addUser() {
      if (userInfo[msg.sender].userAddress == msg.sender) revert();
      userInfo[msg.sender].userAddress = msg.sender;
      userInfo[msg.sender].tokensBought = 5;
      numUsers += 1;
  }
  
  function getNumUsers() constant returns (uint){
      return numUsers;
  }
  
  
  /* This function is used to purchase the tokens. Note the keyword 
 'payable' below. By just adding that one keyword to a function, 
 your contract can now accept Ether from anyone who calls this 
 function. Accepting money can not get any easier than this!
 */
    function buy() payable returns (uint) {
        uint tokensToBuy = msg.value / pricePerPlay;
        if (tokensToBuy > balanceTokens) revert();
        userInfo[msg.sender].userAddress = msg.sender;
        userInfo[msg.sender].tokensBought += tokensToBuy;
        balanceTokens -= tokensToBuy;
        return tokensToBuy;
    }
    
    //return the user's current balance.
    function balanceOf() constant returns (uint256 balance) {
        return userInfo[msg.sender].tokensBought;
    }

  // This function returns the total votes a candidate has received so far
  function totalNumPlays(bytes32 song) returns (uint) {
    if (validSong(song) == false) revert();
    return numPlays[song];
  }

  // This function increments the vote count for the specified candidate. This
  // is equivalent to casting a vote
  function playSong(bytes32 song) returns (uint){
    if (validSong(song) == false) revert();
    if (pricePerPlay > userInfo[msg.sender].tokensBought) revert();
    numPlays[song] += pricePerPlay;
    userInfo[msg.sender].tokensBought -= pricePerPlay;
    return userInfo[msg.sender].tokensBought;
  }

  function validSong(bytes32 song) returns (bool) {
    for(uint i = 0; i < songList.length; i++) {
      if (songList[i] == song) {
        return true;
      }
    }
    return false;
  }
}