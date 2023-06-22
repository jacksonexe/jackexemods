var masterList = [
{ "title" : "Reverse Gear", "Description" : "Walk backwards only"},
{ "title" : "Rear-End Specialist", "Description" : "Kills only count if you shoot them in the ass"},
{ "title" : "Call Of The Wild", "Description" : "You can only walk while using a caller"},
{ "title" : "Sniper's Nest", "Description" : "Kill the next animal from a stand/blind"},
{ "title" : "Hipster Shots", "Description" : "Next kill has to be a hip-shot"},
{ "title" : "Bullseye Bonanza", "Description" : "Next kill must be a headshot"},
{ "title" : "Bow and Arrow Barrage", "Description" : "Next kill must be while using a bow"},
{ "title" : "One and Done", "Description" : "You can only one shot one kill an animal for 15 minutes"},
{ "title" : "Shotgun Showdown", "Description" : "Shotgun only for 15 minutes"},
{ "title" : "Handgun Havoc", "Description" : "Handguns only for 15 minutes"},
{ "title" : "ATV Abandonment", "Description" : "Ditch Your ATV for 15 minutes"},
{ "title" : "Tiny Targets", "Description" : "Only hunt small game for 15 minutes"},
{ "title" : "Paparazzi Time", "Description" : "Only take photos for 5 minutes"},
{ "title" : "Crossbow Crusade", "Description" : "Hunt only using crossbows for 15 minutes"},
{ "title" : "Birdman", "Description" : "Only hunt birds for 15 minutes"},
{ "title" : "Bear Necessities", "Description" : "You can only kill bears for the next 15 minutes."},
{ "title" : "Out of Sight", "Description" : "Must make your next kill without using your scope/binoculars."},
{ "title" : "Wing Shot", "Description" : "You can only kill flying birds for the next 15 minutes."},
{ "title" : "Long Range", "Description" : "Your next kill must be from a distance of 150+ meters."},
{ "title" : "Close Quarters", "Description" : "Your next kill must be from a distance of less than 20 meters."},
{ "title" : "Pacifist Challenge", "Description" : "Cannot kill anything for the next 5 minutes."},
{ "title" : "Fuzzy Target", "Description" : "Your next kill must be made while your health is below 50%."},
{ "title" : "Track Master", "Description" : "You can only kill the animal that you've been tracking. No switching tracks."},
{ "title" : "RNGesus", "Description" : "Roll a dice (or use a random number generator), and you can only kill that number of animals for the next 15 minutes."},
{ "title" : "No Ammo Resupply", "Description" : "You can't resupply ammo for the next 15 minutes."},
{ "title" : "Slow and Steady", "Description" : "Can't run for the next 10 minutes."},
{ "title" : "Scent Masker Off", "Description" : "You can't use a scent masker for the next 15 minutes."},
{ "title" : "Wind Caller", "Description" : "Must always move in the direction of the wind for the next 15 minutes."},
{ "title" : "Quick Draw", "Description" : "Next kill must be within 5 seconds of spotting the animal."},
{ "title" : "One with Nature", "Description" : "You can't hide in bushes or tall grass for the next 15 minutes."},
{ "title" : "Walking in Circles", "Description" : "You must make a full circle on the map before your next kill."},
{ "title" : "Silent Hunter", "Description" : "You cannot use any form of vocal or noise communication for the next 5 minutes."},
{ "title" : "Blind Spot", "Description" : "Must cover a portion of your screen (top/bottom or side) for the next kill."},
{ "title" : "Narrow Vision", "Description" : "Play in windowed mode for the next 15 minutes (the window cannot be larger than 50% of your screen)."},
{ "title" : "Lightweight", "Description" : "You can only carry one type of weapon for the next 15 minutes."},
{ "title" : "Switcheroo", "Description" : "Swap your weapon with the lowest damage output one for your next kill."},
{ "title" : "Sticky Situation", "Description" : "You must stay in the same spot for the next kill (or 10 minutes), you cannot move to chase an animal."},
{ "title" : "Spotter", "Description" : "You must spot and identify the animal species and provide a piece of trivia (make it up idc) before you can take a shot."},
{ "title" : "Predator Turned Prey", "Description" : "For the next 15 minutes, you can only hunt predators (bears, wolves, etc.)"},
{ "title" : "Herbivore's Feast", "Description" : "For the next 15 minutes, only hunt herbivores (deer, rabbits, etc.)"}
]

var cardNumber = [...masterList];

function randomCard() {
  var cardNumberLength = cardNumber.length;
  var randomCardNumber = Math.floor(Math.random() * cardNumberLength);
  var cardText = cardNumber.splice(randomCardNumber, 1)[0];
  $(".card-p .card-title").text(cardText.title);
  $(".card-p .card-description").text(cardText.Description);
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