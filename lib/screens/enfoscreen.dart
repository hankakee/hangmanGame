import "package:flutter/material.dart";

// hide BoxDecoration, BoxShadow
// import "package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart";
class EnfoScreen extends StatelessWidget {
  final String statusInfo;
  final int vies;
  final String winning;
  final String losing;
  final Function callbackFunction;

  const EnfoScreen(
      {Key? key,
      required this.winning,
      required this.losing,
      required this.statusInfo,
      required this.vies,
      required this.callbackFunction})
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
      child: statusInfo == "winner"
          ? Center(
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
                // const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          print("Rejwe win clicked");
                          callbackFunction();
                        },
                        child: Container(
                          width: 100,
                          height: 25,
                          margin: const EdgeInsets.only(top: 20.0, right: 20.0),
                          padding: const EdgeInsets.all(4.0),
                          child: const Center(
                              child: Text(
                            "Rejwe",
                            style: TextStyle(fontWeight: FontWeight.w400),
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
                            style: TextStyle(fontWeight: FontWeight.w400),
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
                )
              ],
            ))
          :
          //loser
          Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: 70.0,
                    icon:
                        const Icon(Icons.sentiment_very_dissatisfied_outlined),
                    color: Color.fromARGB(255, 219, 0, 0),
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
                        color: Color.fromARGB(255, 219, 0, 0),
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Text(
                  losing,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 219, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
                // const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          callbackFunction();
                          print("Rejwe pedi clicked nooooo");
                        },
                        child: Container(
                          width: 100,
                          height: 25,
                          margin: const EdgeInsets.only(top: 20.0, right: 20.0),
                          padding: const EdgeInsets.all(4.0),
                          child: const Center(
                              child: Text(
                            "Rejwe",
                            style: TextStyle(fontWeight: FontWeight.w400),
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
                    SizedBox(),
                    GestureDetector(
                        onTap: () {
                          print("Kite clicked");
                        },
                        child: Container(
                          width: 100,
                          height: 25,
                          margin: EdgeInsets.only(top: 20.0),
                          padding: EdgeInsets.all(4.0),
                          child: Center(
                              child: Text(
                            "Kite ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          )),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
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
                )
              ],
            )),
    ));
  }
}
