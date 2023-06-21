function RandomizeLoadout(callback){
    if($(".loadout-menu") == null){
      $(".character").click()
    }
    setTimeout(function(){
      $(".loadout-menu li:last-child span:first-child").click()
      setTimeout(function(){
        $("dialog button:first-child").click()
        callback();
       }, 1000);
    }, 1000);
  }
  
  function newTimeout(){
    RandomizeLoadout(function(){
          setTimeout(newTimeout, 60000);
    });
  }
  
  setTimeout(newTimeout, 60000);