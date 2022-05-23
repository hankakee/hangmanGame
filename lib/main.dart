import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "dart:math";
import "dart:io";
import 'dart:async';

void main() {
  runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false, title: "Hangman", home: Hangman()),
  );
}

String fraz = "";
String moChwazi = "";
String infoChwazi = "";
String rechechMo = "";
String thisletter = "";

String winning = "";
String losing = "";

List<String> lisMoJweDeja = [];
List mo = [
  {
    "tem": ["BONSWA", "Se yon mo ki itilize pou salye moun le swa..."],
    "info": ["Wi se BONSWA yo di le swa...", "Domaj mo sa te komanse a B..."]
  },
  {
    "tem": ["LEKOL", "Youn nan pi bon kote ki ka enstwi moun..."],
    "info": [
      "Wi LEKOL se youn nan kote ki ka enstwi moun...",
      "Domaj mo sa te komanse a L..."
    ]
  },
  // {
  //   "tem": ["SOULYE", "Itil pou proteje pye'w..."],
  //   "info": ["Wi soulye Itil pou proteje pye'w...", "Domaj mo sa te komanse a L..."]
  // },
  // {
  //   "tem": ["LAJAN", "Echanjab pou preske tout bagay"],
  //   "info": ["Wi lajan echanjab pou preske tout bagay...", "Domaj mo sa te komanse a L..."]
  // },
  // {
  //   "tem": ["LEGIM", "Ka akonpaye preske tout manje..."],
  //   "info": ["Wi LEGIM ka akonpaye preske tout manje...", "Domaj mo sa te komanse a L..."]
  // }
];

class Hangman extends StatefulWidget {
  const Hangman({Key? key}) : super(key: key);
  @override
  _HangmanState createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  int lives = 5;
  String statusTyping = '';
  bool shift = true;
  bool freezeBtn = false;
  _HangmanState() {
    //enstans
    fraz = FomateTeks.rekipereTeks(mo, fraz);
    moChwazi = fraz.split("&")[0];
    infoChwazi = fraz.split("&")[1];
    rechechMo = fraz.split("&")[2];
    losing = fraz.split("&")[4];
    winning = fraz.split("&")[3];
  }

  Widget touche(String lt, callback, bool freeze, int lives) {
    if (lt == "MAJ") {
      return (Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: IconButton(
            icon: const Icon(Icons.arrow_upward), onPressed: callback),
      ));
    } else if (lt == "CROSS") {
      return Container(
        color: const Color(0XFFAEB5BF),
        child: IconButton(
            icon: const Icon(
              Icons.backspace_rounded,
              color: Colors.white,
            ),
            onPressed: callback),
      );
    } else {
      return TextButton(
          child: Text(
            lt,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 255, 255, 255)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 0, 0, 0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 173, 173, 173))))),
          onPressed: (freeze || lives == 0) ? null : callback);
    }
  }

  @override
  Widget build(BuildContext context) {
    String mlor = "";
    // if (rechechMo == "danger") {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const MizajouScreen()));
    //   return const Text("");
    // } else {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF5271FF),
          title: const Text("Hangman"),
          actions: [
            Row(
              children: [
                Text(
                  lives.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                IconButton(
                    icon: const Icon(Icons.star),
                    color: const Color(0xFFF3BC10),
                    onPressed: () {}),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                color: const Color(0xFF5271FF),
                padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                child: const Text(
                  "Hangman",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30.0),
                ),
                height: 250.0,
              ),
              ListTile(
                  onTap: () {
                    Navigator.pop(context, true);
                    print("Yo replay klike");
                    fraz = "";
                    setState(() {
                      lives = 5;
                      statusTyping = 'a';
                      fraz = FomateTeks.rekipereTeks(mo, fraz);
                      moChwazi = fraz.split("&")[0];
                      infoChwazi = fraz.split("&")[1];
                      rechechMo = fraz.split("&")[2];
                      winning = fraz.split("&")[3];
                      losing = fraz.split("&")[4];
                    });
                  },
                  title: const Text(
                    "Rejwe",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  )),
              ListTile(
                  onTap: () {
                    print("Ed klike");
                  },
                  title: const Text("Ed",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0))),
              ListTile(
                  onTap: () {
                    print("soti");
                    // // exit(0);
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');

                    // _getOutOfApp();
                  },
                  title: const Text("Kite",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0))),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Color(0XFFFAFAFA),
              padding: const EdgeInsets.only(top: 40.0, bottom: 100.0),
              width: double.infinity,
              child: Column(
                //////////////text needed //////////////
                children: [
                  Text(
                    moChwazi,
                    style: const TextStyle(fontSize: 35.0),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text("Bor"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EnfoScreen(statusInfo: "winner")));
                      },
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(infoChwazi)),
                  // Container(
                  //     padding: EdgeInsets.only(top: 10.0),
                  //     child: Text(
                  //       "Domaj sete Bonswa!!!",
                  //       style: const TextStyle(fontSize: 20.0),
                  //     )),
                ],
              ),
            ),
            statusTyping == 'f'
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(thisletter,
                            style: const TextStyle(
                              color: Color(0XFFFF0000),
                              fontSize: 40.0,
                            )),
                        IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 20.00,
                              color: Color(0XFFFF0000),
                            ),
                            onPressed: () {}),
                      ])
                : statusTyping == 't'
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text(thisletter,
                                style: const TextStyle(
                                  color: Color(0XFF00FF00),
                                  fontSize: 40.0,
                                )),
                            IconButton(
                                icon: const Icon(
                                  Icons.check,
                                  size: 20.00,
                                  color: Color(0XFF00FF00),
                                ),
                                onPressed: () {}),
                          ])
                    : const Text(""),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const Pedi_Screen()));
            //     },
            //     child: Text("Return")),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
              color: const Color(0XFFD1D4D9),
              child: GridView.count(
                  padding: const EdgeInsets.only(top: 5.0),
                  primary: false,
                  shrinkWrap: true,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 10,
                  children: [
                    touche(
                        shift ? 'Q' : 'q',
                        () => {
                              puppetMaster("Q", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'W' : 'w',
                        () => {
                              puppetMaster("W", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'E' : 'e',
                        () => {
                              puppetMaster("E", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'R' : 'r',
                        () => {
                              puppetMaster("R", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'T' : 't',
                        () => {
                              puppetMaster("T", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'Y' : 'y',
                        () => {
                              puppetMaster("Y", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'U' : 'u',
                        () => {
                              puppetMaster("U", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'I' : 'i',
                        () => {
                              puppetMaster("I", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'O' : 'o',
                        () => {
                              puppetMaster("O", context),
                            },
                        freezeBtn,
                        lives),
                    touche(
                        shift ? 'P' : 'p',
                        () => {
                              puppetMaster("P", context),
                            },
                        freezeBtn,
                        lives),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
              color: const Color(0XFFD1D4D9),
              width: double.infinity,
              child: GridView.count(
                padding: const EdgeInsets.only(top: 5.0),
                primary: false,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 9,
                children: [
                  touche(
                      shift ? 'A' : 'a',
                      () => {
                            puppetMaster("A", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'S' : 's',
                      () => {
                            puppetMaster("S", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'D' : 'd',
                      () => {
                            puppetMaster("D", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'F' : 'f',
                      () => {
                            puppetMaster("F", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'G' : 'g',
                      () => {
                            puppetMaster("G", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'H' : 'h',
                      () => {
                            puppetMaster("H", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'J' : 'j',
                      () => {
                            puppetMaster("J", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'K' : 'k',
                      () => {
                            puppetMaster("K", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'L' : 'l',
                      () => {
                            puppetMaster("L", context),
                          },
                      freezeBtn,
                      lives),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 5.0, bottom: 15.0),
              color: const Color(0XFFD1D4D9),
              child: GridView.count(
                padding: const EdgeInsets.only(top: 5.0),
                // primary: false,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 9,
                children: [
                  touche(
                      'MAJ',
                      () => {
                            shift
                                ? setState(() => {
                                      shift = false,
                                    })
                                : setState(() => {
                                      shift = true,
                                    }),
                          },
                      false,
                      lives),
                  touche(
                      shift ? 'Z' : 'z',
                      () => {
                            puppetMaster("Z", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'X' : 'x',
                      () => {
                            puppetMaster("X", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'C' : 'c',
                      () => {
                            puppetMaster("C", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'V' : 'v',
                      () => {
                            puppetMaster("V", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'B' : 'b',
                      () => {
                            puppetMaster("B", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'N' : 'n',
                      () => {
                            puppetMaster("N", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      shift ? 'M' : 'm',
                      () => {
                            puppetMaster("M", context),
                          },
                      freezeBtn,
                      lives),
                  touche(
                      'CROSS',
                      () => {print("CROSS choosed in the callback")},
                      false,
                      lives),
                ],
              ),
            ),
          ],
        ));
  }

  void puppetMaster(ltd, context) {
    var mlor = "";
    setState(() => freezeBtn = true);
    Timer(const Duration(microseconds: 600), () {
      setState(() => freezeBtn = false);
    });
    mlor = ParseText(moChwazi, rechechMo, ltd, context);
    statusTyping = mlor.split("&")[1];
    mlor = mlor.split("&")[0];
    print("men mlor:" + mlor);
    moChwazi = mlor;
    setState(() => {
          moChwazi = mlor,
        });
    if (statusTyping == 'f') {
      if (lives > 1) {
        Timer(const Duration(seconds: 1), () {
          setState(() => {
                statusTyping = 'a',
                lives--,
              });
        });
      } else {
        lives = 0;
        pedi(context);
      }
    } else if (statusTyping == 't') {
      Timer(const Duration(seconds: 1), () {
        setState(() => statusTyping = 'a');
      });
    }
  }

  void _getOutOfApp() {
    if (Platform.isIOS) {
      try {
        exit(0);
      } catch (e) {
        SystemNavigator.pop();
      }
    } else {
      try {
        SystemNavigator.pop(); // sometimes it cant exit app
      } catch (e) {
        exit(0);
      }
    }
  }

  static String pedi(context) {
    print("Ou pedu ui bro");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EnfoScreen(statusInfo: "loser")));
    return "";
  }

  static String ParseText(String word, String search, String letter, context) {
    // moChwazi
    var tmpKrypt = word.split("");
    var tmptesksTab = search.split("");
    thisletter = letter;
    var tmoin = "f";
    // print("search");
    // print(search.length);
    // print("search.split");

    // for (var i = 0; i < tmptesksTab.length; i++) {
    //   tmptesksTab.add(word[i]);
    // }
    print("tmptesksTab");
    print(tmptesksTab);
    print("tmptesksTab  " + tmptesksTab.length.toString());
    print("-----------------salopri separator----------------------");
    print("tmpKrypt");
    print(tmpKrypt);
    print("tmpkrypt " + tmpKrypt.length.toString());

    if (tmpKrypt.contains(letter)) {
      //  already have this letter
      tmoin = 'a';
      print("ce que je return alreadfy :" + tmpKrypt.join("") + "&" + tmoin);
      return tmpKrypt.join("") + "&" + tmoin;
    } else {
      for (var i = 0; i < tmptesksTab.length; i++) {
        if (tmptesksTab[i] == letter) {
          tmpKrypt[i] = tmptesksTab[i];
          tmoin = 't';
        }
      }
      var ro = "";
      for (var i = 0; i < tmpKrypt.length; i++) {
        ro += tmpKrypt[i];
      }

      if (!tmpKrypt.contains("*")) {
        tmoin = 'd';
        print("Completed no letter to complete..");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EnfoScreen(statusInfo: "winner")));
        // context
      }
      print("Find the bottle");
      print(tmpKrypt);
      print("temoin: " + tmoin);

      return ro + "&" + tmoin;
    }
  }
}

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
      print(lisMoJweDeja.length);
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
      print(lisMoJweDeja.toString());

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

class MizajouScreen extends StatelessWidget {
  const MizajouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bro")),
      body: Container(
        child:
            Text("Domaj brother eskeuw vle reset oubyen wap tan lot version"),
      ),
    );
  }
}

class EnfoScreen extends StatelessWidget {
  final String statusInfo;
  const EnfoScreen({Key? key, required this.statusInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: statusInfo == "loser"
              ? Row(
                  children: [
                    Text("Domaj se fini..."),
                    Text(losing),
                  ],
                )
              : Center(
                  child: Column(
                    children: [
                      Text("You win bro"),
                      Text(winning),
                      // const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: Text("Rejwe")),
                          ElevatedButton(onPressed: () {}, child: Text("Kite")),
                          Container(
                            width: 200,
                            height: 200,
                            child: Icon(Icons.android),
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-4.0, -4.0),
                                    blurRadius: 15.0,
                                    spreadRadius: 1.0,
                                  )
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                )),
    );
  }
}
