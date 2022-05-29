import "package:flutter/material.dart";

class MizajouScreen extends StatelessWidget {
  final int vies;
  final String winning;
  final Function callbackRekomanse;

  const MizajouScreen(
      {Key? key,
      required this.winning,
      required this.vies,
      required this.callbackRekomanse})
      : super(key: key);

  List<Widget> countStars(int count) {
    List<Widget> starsData = [];

    for (var k = 0; k < count; k++) {
      starsData.add(IconButton(
          iconSize: 25.0,
          icon: const Icon(Icons.star),
          color: const Color(0xFFF3BC10),
          onPressed: () {}));
    }

    return starsData;
  }

  @override
  Widget build(BuildContext context) {
    String textEnfo = "";

    if (vies == 5) {
      textEnfo =
          "Sapa bolèt menm non , felisitasyon ou genyen san pedi yon chans!!!";
    } else if (vies == 2 || vies == 1) {
      textEnfo = "Waw ou manke chire wi...,antouka ou fè bèl efo wi...";
    } else if (vies > 2 && vies < 5) {
      textEnfo = "Felitasyon ou genyen wi...";
    } else {
      textEnfo = "Podyab , ou pèdi wi!!!";
    }

    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 70.0,
                    icon: const Icon(Icons.emoji_events_sharp),
                    color: const Color.fromARGB(255, 0, 114, 0),
                    onPressed: () {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: countStars(vies),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    textEnfo,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 114, 0),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  winning,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 114, 0),
                      fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Felisitasyon ,ou fini jwèt Hangman nan,tan yon lot vesyon anko,ki gen plis mo,oswa rekomanse a zero...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 0, 114, 0),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          print(" Reset win clicked");
                          // backupArrowMoKle
                          callbackRekomanse();
                        },
                        child: Container(
                          width: 100,
                          height: 25,
                          margin: const EdgeInsets.only(top: 20.0, right: 20.0),
                          padding: const EdgeInsets.all(4.0),
                          child: const Center(
                              child: Text(
                            "Rekomanse",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFA799AF),
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0xFFA799AF),
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0,
                                ),
                              ]),
                        )),
                    const SizedBox(),
                    GestureDetector(
                        onTap: () {
                          print("Kite clicked");
                        },
                        child: Container(
                          width: 100,
                          height: 25,
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.all(4.0),
                          child: const Center(
                              child: Text(
                            "Kite ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFA799AF),
                                  offset: Offset(-1.0, -1.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Color(0xFFA799AF),
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 0,
                                ),
                              ]),
                        )),
                  ],
                ),
              ],
            ))));
  }
}
