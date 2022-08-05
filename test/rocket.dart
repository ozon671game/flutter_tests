import 'package:flutter/foundation.dart';

class Rocket {
  String lable = '';
  int maxFuel = 0;
  int countFuel = 0;
  int get shouldFuel => maxFuel-countFuel;

  void fill(int currentCountFuel) {
    if(countFuel+currentCountFuel > maxFuel){
      countFuel = maxFuel;
      return;
    }
    countFuel += currentCountFuel;
  }

  String start() => 'lets go';

  Rocket(String l, int c){
   lable = l;
   maxFuel = c;
  }
  Rocket.basic(){
    lable = 'none';
    maxFuel = 50;
    countFuel = 30;
  }
}
