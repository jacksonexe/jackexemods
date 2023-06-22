var masterList = [
  { title: "Reverse Gear", Description: "Walk backwards only" },
  {
    title: "Rear-End Specialist",
    Description: "Kills only count if you shoot them in the ass"
  },
  {
    title: "Call Of The Wild",
    Description: "You can only walk while using a caller"
  },
  {
    title: "Sniper's Nest",
    Description: "Kill the next animal from a stand/blind"
  },
  { title: "Hipster Shots", Description: "Next kill has to be a hip-shot" },
  { title: "Bullseye Bonanza", Description: "Next kill must be a headshot" },
  {
    title: "Bow and Arrow Barrage",
    Description: "Next kill must be while using a bow"
  },
  {
    title: "One and Done",
    Description: "You can only one shot one kill an animal for 15 minutes"
  },
  { title: "Shotgun Showdown", Description: "Shotgun only for 15 minutes",
  timer: 900000 },
  { title: "Handgun Havoc", Description: "Handguns only for 15 minutes",
  timer: 900000 },
  { title: "ATV Abandonment", Description: "Ditch Your ATV for 15 minutes",
  timer: 900000 },
  { title: "Tiny Targets", Description: "Only hunt small game for 15 minutes",
  timer: 900000 },
  { title: "Paparazzi Time", Description: "Only take photos for 5 minutes",
  timer: 300000 },
  {
    title: "Crossbow Crusade",
    Description: "Hunt only using crossbows for 15 minutes",
    timer: 900000
  },
  { title: "Birdman", Description: "Only hunt birds for 15 minutes",
  timer: 900000 },
  {
    title: "Bear Necessities",
    Description: "You can only kill bears for the next 15 minutes.",
    timer: 900000
  },
  {
    title: "Out of Sight",
    Description: "Must make your next kill without using your scope/binoculars."
  },
  {
    title: "Wing Shot",
    Description: "You can only kill flying birds for the next 15 minutes.",
    timer: 900000
  },
  {
    title: "Long Range",
    Description: "Your next kill must be from a distance of 150+ meters."
  },
  {
    title: "Close Quarters",
    Description:
      "Your next kill must be from a distance of less than 20 meters."
  },
  {
    title: "Pacifist Challenge",
    Description: "Cannot kill anything for the next 5 minutes.",
    timer: 300000
  },
  {
    title: "Fuzzy Target",
    Description: "Your next kill must be made while your health is below 50%."
  },
  {
    title: "Track Master",
    Description:
      "You can only kill the animal that you've been tracking. No switching tracks."
  },
  {
    title: "RNGesus",
    Description:
      "Roll a dice (or use a random number generator), and you can only kill that number of animals for the next 15 minutes.",
      timer: 900000
  },
  {
    title: "No Ammo Resupply",
    Description: "You can't resupply ammo for the next 15 minutes.",
    timer: 900000
  },
  {
    title: "Slow and Steady",
    Description: "Can't run for the next 10 minutes."
  },
  {
    title: "Scent Masker Off",
    Description: "You can't use a scent masker for the next 15 minutes.",
    timer: 900000
  },
  {
    title: "Wind Caller",
    Description:
      "Must always move in the direction of the wind for the next 15 minutes.",
      timer: 900000
  },
  {
    title: "Quick Draw",
    Description: "Next kill must be within 5 seconds of spotting the animal."
  },
  {
    title: "One with Nature",
    Description:
      "You can't hide in bushes or tall grass for the next 15 minutes.",
      timer: 900000
  },
  {
    title: "Walking in Circles",
    Description: "You must make a full circle on the map before your next kill."
  },
  {
    title: "Silent Hunter",
    Description:
      "You cannot use any form of vocal or noise communication for the next 5 minutes.",
      timer: 300000
  },
  {
    title: "Blind Spot",
    Description:
      "Must cover a portion of your screen (top/bottom or side) for the next kill."
  },
  {
    title: "Narrow Vision",
    Description:
      "Play in windowed mode for the next 15 minutes (the window cannot be larger than 50% of your screen).",
      timer: 900000
  },
  {
    title: "Lightweight",
    Description:
      "You can only carry one type of weapon for the next 15 minutes.",
      timer: 900000
  },
  {
    title: "Switcheroo",
    Description:
      "Swap your weapon with the lowest damage output one for your next kill."
  },
  {
    title: "Sticky Situation",
    Description:
      "You must stay in the same spot for the next kill (or 10 minutes), you cannot move to chase an animal.",
      timer: 600000
  },
  {
    title: "Spotter",
    Description:
      "You must spot and identify the animal species and provide a piece of trivia (make it up idc) before you can take a shot."
  },
  {
    title: "Predator Turned Prey",
    Description:
      "For the next 15 minutes, you can only hunt predators (bears, wolves, etc.)",
      timer: 900000
  },
  {
    title: "Herbivore's Feast",
    Description:
      "For the next 15 minutes, only hunt herbivores (deer, rabbits, etc.)",
    timer: 900000
  }
];

var victims = ["Jackexe", "Koro", "Krandose"];
var lastVictim = undefined;
var cardNumber = [...masterList];
var currentItem = undefined;
var utterThis = undefined

function randomCard() {
  var cardNumberLength = cardNumber.length;
  var randomCardNumber = Math.floor(Math.random() * cardNumberLength);
  var cardText = cardNumber.splice(randomCardNumber, 1)[0];
  currentItem = cardText;
  $("#card .card-p .card-title").text(cardText.title);
  $("#card .card-p .card-description").text(cardText.Description);
  var victimsLength = victims.length;
  var randomVictimsNumber = Math.floor(Math.random() * victimsLength);
  var text = victims[randomVictimsNumber];
  while(text == lastVictim){
    randomVictimsNumber = Math.floor(Math.random() * victimsLength);
    text = victims[randomVictimsNumber];
  }
  lastVictim = text;
  $(".vict").text(text);
  $(".vict").hide();
  let ourText = cardText.title + "    " + text + cardText.Description;
  utterThis = new SpeechSynthesisUtterance(ourText);
}

function addDeck(numCards) {
  $(".deck").html("");
  var top = -10;
  var left = -302;
  for (let i = 0; i < numCards; i++) {
    $(".deck").append(
      '<div class="deck-cards" style="margin-top: ' +
        top +
        "px;margin-left: " +
        left +
        "px;z-index:" +
        (numCards - i) +
        '"><p></p></div>'
    );
    top += 1;
    left += 0.1;
  }
}
var config = {
  axis: "y", // y or x
  reverse: true, // true and false
  trigger: "click", // click or hover
  speed: "250",
  front: $("#card .front"),
  back: $("#card #main-back"),
  autoSize: false
};
$("#card").flip(config);
randomCard();
var effectIndex = 1;

function beep() {
  var snd = new Audio("data:audio/wav;base64,//uQRAAAAWMSLwUIYAAsYkXgoQwAEaYLWfkWgAI0wWs/ItAAAGDgYtAgAyN+QWaAAihwMWm4G8QQRDiMcCBcH3Cc+CDv/7xA4Tvh9Rz/y8QADBwMWgQAZG/ILNAARQ4GLTcDeIIIhxGOBAuD7hOfBB3/94gcJ3w+o5/5eIAIAAAVwWgQAVQ2ORaIQwEMAJiDg95G4nQL7mQVWI6GwRcfsZAcsKkJvxgxEjzFUgfHoSQ9Qq7KNwqHwuB13MA4a1q/DmBrHgPcmjiGoh//EwC5nGPEmS4RcfkVKOhJf+WOgoxJclFz3kgn//dBA+ya1GhurNn8zb//9NNutNuhz31f////9vt///z+IdAEAAAK4LQIAKobHItEIYCGAExBwe8jcToF9zIKrEdDYIuP2MgOWFSE34wYiR5iqQPj0JIeoVdlG4VD4XA67mAcNa1fhzA1jwHuTRxDUQ//iYBczjHiTJcIuPyKlHQkv/LHQUYkuSi57yQT//uggfZNajQ3Vmz+Zt//+mm3Wm3Q576v////+32///5/EOgAAADVghQAAAAA//uQZAUAB1WI0PZugAAAAAoQwAAAEk3nRd2qAAAAACiDgAAAAAAABCqEEQRLCgwpBGMlJkIz8jKhGvj4k6jzRnqasNKIeoh5gI7BJaC1A1AoNBjJgbyApVS4IDlZgDU5WUAxEKDNmmALHzZp0Fkz1FMTmGFl1FMEyodIavcCAUHDWrKAIA4aa2oCgILEBupZgHvAhEBcZ6joQBxS76AgccrFlczBvKLC0QI2cBoCFvfTDAo7eoOQInqDPBtvrDEZBNYN5xwNwxQRfw8ZQ5wQVLvO8OYU+mHvFLlDh05Mdg7BT6YrRPpCBznMB2r//xKJjyyOh+cImr2/4doscwD6neZjuZR4AgAABYAAAABy1xcdQtxYBYYZdifkUDgzzXaXn98Z0oi9ILU5mBjFANmRwlVJ3/6jYDAmxaiDG3/6xjQQCCKkRb/6kg/wW+kSJ5//rLobkLSiKmqP/0ikJuDaSaSf/6JiLYLEYnW/+kXg1WRVJL/9EmQ1YZIsv/6Qzwy5qk7/+tEU0nkls3/zIUMPKNX/6yZLf+kFgAfgGyLFAUwY//uQZAUABcd5UiNPVXAAAApAAAAAE0VZQKw9ISAAACgAAAAAVQIygIElVrFkBS+Jhi+EAuu+lKAkYUEIsmEAEoMeDmCETMvfSHTGkF5RWH7kz/ESHWPAq/kcCRhqBtMdokPdM7vil7RG98A2sc7zO6ZvTdM7pmOUAZTnJW+NXxqmd41dqJ6mLTXxrPpnV8avaIf5SvL7pndPvPpndJR9Kuu8fePvuiuhorgWjp7Mf/PRjxcFCPDkW31srioCExivv9lcwKEaHsf/7ow2Fl1T/9RkXgEhYElAoCLFtMArxwivDJJ+bR1HTKJdlEoTELCIqgEwVGSQ+hIm0NbK8WXcTEI0UPoa2NbG4y2K00JEWbZavJXkYaqo9CRHS55FcZTjKEk3NKoCYUnSQ0rWxrZbFKbKIhOKPZe1cJKzZSaQrIyULHDZmV5K4xySsDRKWOruanGtjLJXFEmwaIbDLX0hIPBUQPVFVkQkDoUNfSoDgQGKPekoxeGzA4DUvnn4bxzcZrtJyipKfPNy5w+9lnXwgqsiyHNeSVpemw4bWb9psYeq//uQZBoABQt4yMVxYAIAAAkQoAAAHvYpL5m6AAgAACXDAAAAD59jblTirQe9upFsmZbpMudy7Lz1X1DYsxOOSWpfPqNX2WqktK0DMvuGwlbNj44TleLPQ+Gsfb+GOWOKJoIrWb3cIMeeON6lz2umTqMXV8Mj30yWPpjoSa9ujK8SyeJP5y5mOW1D6hvLepeveEAEDo0mgCRClOEgANv3B9a6fikgUSu/DmAMATrGx7nng5p5iimPNZsfQLYB2sDLIkzRKZOHGAaUyDcpFBSLG9MCQALgAIgQs2YunOszLSAyQYPVC2YdGGeHD2dTdJk1pAHGAWDjnkcLKFymS3RQZTInzySoBwMG0QueC3gMsCEYxUqlrcxK6k1LQQcsmyYeQPdC2YfuGPASCBkcVMQQqpVJshui1tkXQJQV0OXGAZMXSOEEBRirXbVRQW7ugq7IM7rPWSZyDlM3IuNEkxzCOJ0ny2ThNkyRai1b6ev//3dzNGzNb//4uAvHT5sURcZCFcuKLhOFs8mLAAEAt4UWAAIABAAAAAB4qbHo0tIjVkUU//uQZAwABfSFz3ZqQAAAAAngwAAAE1HjMp2qAAAAACZDgAAAD5UkTE1UgZEUExqYynN1qZvqIOREEFmBcJQkwdxiFtw0qEOkGYfRDifBui9MQg4QAHAqWtAWHoCxu1Yf4VfWLPIM2mHDFsbQEVGwyqQoQcwnfHeIkNt9YnkiaS1oizycqJrx4KOQjahZxWbcZgztj2c49nKmkId44S71j0c8eV9yDK6uPRzx5X18eDvjvQ6yKo9ZSS6l//8elePK/Lf//IInrOF/FvDoADYAGBMGb7FtErm5MXMlmPAJQVgWta7Zx2go+8xJ0UiCb8LHHdftWyLJE0QIAIsI+UbXu67dZMjmgDGCGl1H+vpF4NSDckSIkk7Vd+sxEhBQMRU8j/12UIRhzSaUdQ+rQU5kGeFxm+hb1oh6pWWmv3uvmReDl0UnvtapVaIzo1jZbf/pD6ElLqSX+rUmOQNpJFa/r+sa4e/pBlAABoAAAAA3CUgShLdGIxsY7AUABPRrgCABdDuQ5GC7DqPQCgbbJUAoRSUj+NIEig0YfyWUho1VBBBA//uQZB4ABZx5zfMakeAAAAmwAAAAF5F3P0w9GtAAACfAAAAAwLhMDmAYWMgVEG1U0FIGCBgXBXAtfMH10000EEEEEECUBYln03TTTdNBDZopopYvrTTdNa325mImNg3TTPV9q3pmY0xoO6bv3r00y+IDGid/9aaaZTGMuj9mpu9Mpio1dXrr5HERTZSmqU36A3CumzN/9Robv/Xx4v9ijkSRSNLQhAWumap82WRSBUqXStV/YcS+XVLnSS+WLDroqArFkMEsAS+eWmrUzrO0oEmE40RlMZ5+ODIkAyKAGUwZ3mVKmcamcJnMW26MRPgUw6j+LkhyHGVGYjSUUKNpuJUQoOIAyDvEyG8S5yfK6dhZc0Tx1KI/gviKL6qvvFs1+bWtaz58uUNnryq6kt5RzOCkPWlVqVX2a/EEBUdU1KrXLf40GoiiFXK///qpoiDXrOgqDR38JB0bw7SoL+ZB9o1RCkQjQ2CBYZKd/+VJxZRRZlqSkKiws0WFxUyCwsKiMy7hUVFhIaCrNQsKkTIsLivwKKigsj8XYlwt/WKi2N4d//uQRCSAAjURNIHpMZBGYiaQPSYyAAABLAAAAAAAACWAAAAApUF/Mg+0aohSIRobBAsMlO//Kk4soosy1JSFRYWaLC4qZBYWFRGZdwqKiwkNBVmoWFSJkWFxX4FFRQWR+LsS4W/rFRb/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////VEFHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAU291bmRib3kuZGUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMjAwNGh0dHA6Ly93d3cuc291bmRib3kuZGUAAAAAAAAAACU=");  
  snd.play();
}
const synth = window.speechSynthesis

addDeck(cardNumber.length);
$(".card").click(function (e) {
  e.preventDefault();
  var flip = $("#card").data("flip-model");
  if (!flip.isFlipped) {
    var vic = $(".vict").text();
    $(".vict").text("");
    var clone = $("#card").clone();
    var id = "card" + effectIndex;
    $(clone).attr('id', id);
    var divId = id + "div";
    var compId = id + "comp";
    var tableId = id + "table";
    $(".previousCards").append("<table id=\"" + tableId + "\"><tr><td id=\"" + divId + "\"></td><td><span class=\"old-card-id\">" + vic + "</span></td><td id=\"" + compId + "\"></td></tr></table>");
    if(currentItem != undefined && currentItem.timer !== undefined){
      var totalTime = currentItem.timer / 60000;
      var totalSec = 59;
      $("#" + compId).addClass("Timer");
      $("#" + compId).text("" + totalTime);
      totalTime -= 1;
      var intv = setInterval(function(){
        totalSec -= 1;

        if(totalTime <= 0 && totalSec <= 0){
          clearInterval(intv);
          beep();
          beep();
          $("#" + tableId).fadeOut(400);
        }
        else{
          var txt = totalTime + "";
          if(totalSec != 60){
            var sec = "" + totalSec;
            if(sec.length != 2){
              sec = "0" + sec;
            }
            txt += ":" + sec;
          }
          $("#" + compId).text(txt);
        }
        if(totalSec <= 0){
          totalSec = 60;
          totalTime -= 1;
        }
      }, 1000)
    }
    else{
      var butId = id + "button";
      $("#" + compId).append("<a class=\"button\" id=\"" + butId + "\">Complete</a>")
      $("#" + butId).click(function(){
        beep();
        beep();
        $("#" + tableId).fadeOut(400);
      });
    }
    $("#" + divId).append(clone);
    effectIndex ++;
    $("#" + id + " #main-back").removeAttr( 'style' );
    $("#" + id + " .front").remove();
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
  } else {
    $(".vict").show();
    synth.speak(utterThis)
  }
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
