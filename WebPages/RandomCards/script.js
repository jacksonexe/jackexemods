var masterList = [
  "Walk backwards only",
  "Kills only count if you shoot them in the ass",
  "Must play an animal call while you walk"
];
var cardNumber = [...masterList];

function randomCard() {
  var cardNumberLength = cardNumber.length;
  var randomCardNumber = Math.floor(Math.random() * cardNumberLength);
  var cardText = cardNumber.splice(randomCardNumber, 1);
  $(".card-p p").text(cardText);
  setTimeout(function () {
    $("#card").flip(true);
  }, 300);
}

function addDeck(numCards) {
  $(".deck").html("");
  var top = 0;
  var left = 365;
  for (let i = 0; i < numCards; i++) {
    $(".deck").append(
      '<div class="deck-cards" style="top: ' +
        top +
        "px;left: " +
        left +
        "px;z-index:" +
        (numCards - i) +
        '"><p></p></div>'
    );
    top += 0;
    left += 3;
  }
}
$("#card").flip({
  axis: "y", // y or x
  reverse: true, // true and false
  trigger: "manual", // click or hover
  speed: "250",
  front: $(".front"),
  back: $("#main-back"),
  autoSize: false
});
randomCard();

addDeck(cardNumber.length);
$(".draw").click(function (e) {
  e.preventDefault();
  $("#card").fadeOut(400, function () {
    $("#card").fadeIn();
    if (cardNumber.length == 0) {
      cardNumber = [...masterList];
      $(".draw").text("Pick Random Card!");
      addDeck(cardNumber.length);
    }
    $("#card").flip(false);
    setTimeout(function () {
      randomCard();
      addDeck(cardNumber.length);
      if (cardNumber.length == 0) {
        $(".draw").text("Shuffle Deck");
      }
    }, 300);
  });
});

$(".export").click(function () {
  console.log("Exporting");
  var node = document.getElementById("card");

  domtoimage.toJpeg(node, { quality: 0.95 }).then(function (dataUrl) {
    var link = document.createElement("a");
    link.download = "current_card.jpeg";
    link.href = dataUrl;
    link.click();
  });
});