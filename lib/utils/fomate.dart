import "dart:math";

class FomateTeks {
  static String kripteTeks(String teks) {
    var strparsed = "";
    for (var i = 0; i < teks.length; i++) {
      strparsed += "*";
    }
    return (strparsed);
  }

  static String rekipereTeks(List tab, fraz) {
    if (fraz == "") {
      var element = tab[Random().nextInt(tab.length)];
      var thisWord = (element['tem'][0]).toString();

      print(tab.length);
      // if (lisMoJweDeja.length == tab.length) {
      //   print("a deja parcouru tout le tableau dommage sortie imminante");
      //   print("Fom soti wi");
      //   return kripteTeks(element['tem'][0]) +
      //       "&" +
      //       element['tem'][1] +
      //       "&" +
      //       "danger" +
      //       "&" +
      //       "danger" +
      //       "&" +
      //       "danger";
      // }
      // lisMoJweDeja.add(thisWord);
      print("this word:" + thisWord);
      // print(lisMoJweDeja.length);
      //
      //
      //else if (!(lisMoJweDeja.contains(thisWord))) {
      //   print('Nou bon li pa Contains lettter breaking out');
      //   print("Nouvo eleman:" + element);
      //   print(element);
      // }
      // else {
      // while (lisMoJweDeja.contains(thisWord)) {
      //   if (lisMoJweDeja.contains(thisWord)) {
      // print("Ancien eleman:" + element);
      // print('Contains lettter chwazi on lot');
      // element = tab[Random().nextInt(tab.length)];
      //   } else {
      //     print('Nou bon li pa Contains lettter breaking out');
      //     print("Nouvo eleman:" + element);
      //     print(element);
      //     break;
      //   }
      // }
      // }

      //  else if (LisMoJweDeja.contains(element)) {
      //   element = tab[Random().nextInt(tab.length)];
      //   print("la deja bro");
      //   print(element);
      // } else {
      //   LisMoJweDeja.add(element['tem'][0]);
      //   // break;
      // }
      // print("LisMoJweDeja:");
      // print(lisMoJweDeja.toString());

      print(element['tem'][0] +
          "&" +
          element['tem'][1] +
          "&" +
          element['tem'][0] +
          "&" +
          element['info'][0] +
          "&" +
          element['info'][1]);
      return kripteTeks(element['tem'][0]) +
          "&" +
          element['tem'][1] +
          "&" +
          element['tem'][0] +
          "&" +
          element['info'][0] +
          "&" +
          element['info'][1];
    } else {
      print("Print fraz la deja: " + fraz);
      return fraz;
    }
  }
}
