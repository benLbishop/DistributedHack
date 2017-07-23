$( document ).ready(function() {

$.ajax({
    type: "GET",
    url: "/test" // modify the url according to your application logic
}).done(function(data) {
    console.log(data);
});

});

function addClass( element, classname ) {
if (element.classList)
  element.classList.add(classname);
else
  element.className += ' ' + classname;
}

function removeClass( classname, element ) {
    var cn = element.className;
    var rxp = new RegExp( "\\s?\\b"+classname+"\\b", "g" );
    cn = cn.replace( rxp, '' );
    element.className = cn;
}

function play() {
  $( '#progress-bar' ).toggleClass( "play" );
  $( '#controls-play' ).toggleClass( "play" );
}


