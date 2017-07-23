web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
abi = JSON.parse('[{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"userInfo","outputs":[{"name":"userAddress","type":"address"},{"name":"tokensBought","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"song","type":"bytes32"}],"name":"playSong","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_artist","type":"address"}],"name":"getSongs","outputs":[{"name":"songs","type":"bytes32[]"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"songList","outputs":[{"name":"","type":"bytes32"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"totalTokens","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"bytes32"}],"name":"numPlays","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"pricePerPlay","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"song","type":"bytes32"}],"name":"validSong","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_value","type":"uint256"}],"name":"buy","outputs":[{"name":"","type":"uint256"}],"payable":true,"type":"function"},{"constant":true,"inputs":[],"name":"balanceTokens","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"song","type":"bytes32"}],"name":"totalNumPlays","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"inputs":[{"name":"tokens","type":"uint256"},{"name":"pricePerToken","type":"uint256"},{"name":"songNames","type":"bytes32[]"},{"name":"songArtist","type":"address[]"}],"payable":false,"type":"constructor"}]')
VotingContract = web3.eth.contract(abi);
// In your nodejs console, execute contractInstance.address to get the address at which the contract is deployed and change the line below to use your deployed address
contractInstance = VotingContract.at('0x017020bc2234d7fa40577bc915960d20d76f3291');
songs = {"a": "candidate-1", "b": "candidate-2", "c": "candidate-3"}

function playSong(candidate) {
  songName = $("#candidate").val();
  contractInstance.playSong(songName, {from: web3.eth.accounts[0]}, function() {
    let div_id = songs[songName];
    $("#" + div_id).html(contractInstance.totalNumPlays.call(songName).toString());
  });
}

$(document).ready(function() {
  songNames = Object.keys(songs);
  for (var i = 0; i < songNames.length; i++) {
    let name = songNames[i];
    let val = contractInstance.totalNumPlays.call(name).toString()
    $("#" + songs[name]).html(val);
  }
});