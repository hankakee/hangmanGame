import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:hangmangame/screens/edscreen.dart';
import 'dart:async';
import 'utils/fomate.dart';
import 'screens/enfoscreen.dart';
import 'screens/mizajou.dart';

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
List<String> letPouMosa = [];

List arrayMoKLe = [
  {
    "id": 20,
    "tem": ["BONJOU", "Se yon mo ki itilize pou salye moun le maten..."],
    "info": ["Wi se BONJOU yo di le maten...", "Domaj mo sa te komanse a B..."]
  },
  {
    "id": 21,
    "tem": ["LEKOL", "Youn nan pi bon kote ki ka enstwi moun..."],
    "info": [
      "Wi LEKOL se youn nan kote ki ka enstwi moun...",
      "Domaj mo sa te komanse a L..."
    ]
  },
  // {
  //   "id": 22,
  //   "tem": ["SOULYE", "Itil pou proteje pye'w..."],
  //   "info": [
  //     "Wi soulye Itil pou proteje pye'w...",
  //     "Domaj mo sa te komanse a L..."
  //   ]
  // },
  // {
  //   "id": 23,
  //   "tem": ["LAJAN", "Echanjab pou preske tout bagay"],
  //   "info": [
  //     "Wi lajan echanjab pou preske tout bagay...",
  //     "Domaj mo sa te komanse a L..."
  //   ]
  // },
  // {
  //   "id": 24,
  //   "tem": ["Zaboka", "Ka akonpaye preske tout manje..."],
  //   "info": [
  //     "Wi zaboka ka akonpaye preske tout manje...",
  //     "Domaj mo sa te komanse a Z..."
  //   ]
  // }
];
List backupArrowMoKle = [
  {
    "id": 20,
    "tem": ["BONJOU", "Se yon mo ki itilize pou salye moun le maten..."],
    "info": ["Wi se BONJOU yo di le maten...", "Domaj mo sa te komanse a B..."]
  },
  {
    "id": 21,
    "tem": ["LEKOL", "Youn nan pi bon kote ki ka enstwi moun..."],
    "info": [
      "Wi LEKOL se youn nan kote ki ka enstwi moun...",
      "Domaj mo sa te komanse a L..."
    ]
  },
  // {
  //   "id": 22,
  //   "tem": ["SOULYE", "Itil pou proteje pye'w..."],
  //   "info": [
  //     "Wi soulye Itil pou proteje pye'w...",
  //     "Domaj mo sa te komanse a L..."
  //   ]
  // },
  // {
  //   "id": 23,
  //   "tem": ["LAJAN", "Echanjab pou preske tout bagay"],
  //   "info": [
  //     "Wi lajan echanjab pou preske tout bagay...",
  //     "Domaj mo sa te komanse a L..."
  //   ]
  // },
  // {
  //   "id": 24,
  //   "tem": ["Zaboka", "Ka akonpaye preske tout manje..."],
  //   "info": [
  //     "Wi zaboka ka akonpaye preske tout manje...",
  //     "Domaj mo sa te komanse a Z..."
  //   ]
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
    fraz = FomateTeks.rekipereTeks(arrayMoKLe, fraz);
    moChwazi = fraz.split("&")[0];
    infoChwazi = fraz.split("&")[1];
    rechechMo = fraz.split("&")[2];
    losing = fraz.split("&")[4];
    winning = fraz.split("&")[3];
    letPouMosa.clear();
  }

  callbackReplay(attrib) {
    // print(attrib);
    if (arrayMoKLe.isEmpty) {
      // print("So its done go to mizajouscreen brother");
    } else {
      if (attrib != "loose") {
        // print("Mo gagnan bro:" + attrib);
        // cheche mo gagnan an epi efasel
        // arrayMoKLe
        // print('finding this bro...');
        // print("arrayMoKLe list : " + arrayMoKLe.toString());
        // print("arrayMoKLe list qty: " + arrayMoKLe.length.toString());
        // print("Men backup la before  bro:  " + backupArrowMoKle.toString());
        arrayMoKLe.removeWhere((item) => item['tem'][0] == attrib);
        // print("After removing arrayMoKLe list : " + arrayMoKLe.toString());
        // print("arrayMoKLe list after qty: " + arrayMoKLe.length.toString());
        // print("Men backup la bro:  " + backupArrowMoKle.toString());
      }
      // print("Men backup la before  bro:  " + backupArrowMoKle.toString());
      // print("Men backup la bro:  " + backupArrowMoKle.toString());
      Navigator.pop(context, true);
      // print("Yo replay klike");
      fraz = "";
      setState(() {
        lives = 5;
        statusTyping = 'a';
        fraz = FomateTeks.rekipereTeks(arrayMoKLe, fraz);
        moChwazi = fraz.split("&")[0];
        infoChwazi = fraz.split("&")[1];
        rechechMo = fraz.split("&")[2];
        winning = fraz.split("&")[3];
        losing = fraz.split("&")[4];
        letPouMosa.clear();
      });
    }
  }

  Widget touche(String lt, callback, bool freeze, int lives) {
    if (lt == "MAJ") {
      return TextButton(
          child: const Icon(Icons.arrow_upward,
              color: Color.fromARGB(255, 0, 0, 0)),
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
                          color: Color.fromRGBO(173, 173, 173, 1))))),
          onPressed: callback);
    } else if (lt == "CROSS") {
      return TextButton(
          child: const Icon(Icons.backspace_rounded, color: Colors.white),
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0XFFAEB5BF)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 0, 0, 0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 173, 173, 173))))),
          onPressed: callback);
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
                  Color.fromARGB(255, 0, 0, 0)),
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
                    callbackReplay("loose");
                  },
                  title: const Text(
                    "Rejwe",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  )),
              ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EdScreen()));
                    print("Ed klike");
                  },
                  title: const Text("Ed",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0))),
              ListTile(
                  onTap: () {
                    print("soti hangman tile");
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
              color: const Color(0XFFFAFAFA),
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
                  // Container(
                  //   child: ElevatedButton(
                  //     child: Text("Testay"),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => EnfoScreen(
                  //                     statusInfo: "winner",
                  //                     losing: 'ti test loose',
                  //                     winning: "ti test win",
                  //                     vies: lives,
                  //                     callbackFunction: () {},
                  //                   )));
                  //     },
                  //   ),
                  // ),
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
                ? SizedBox(
                    width: 90.0,
                    height: 70.0,
                    child: TextButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(thisletter,
                                style: const TextStyle(
                                  color: Color(0XFFFF0000),
                                  fontSize: 40.0,
                                )),
                            const IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 20.00,
                                color: Color(0XFFFF0000),
                              ),
                              onPressed: null,
                            )
                          ],
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
                                        color: Color.fromARGB(
                                            255, 173, 173, 173))))),
                        onPressed: () {})) //  Row(
                //
                //     children: [
                //         Text(thisletter,
                //             style: const TextStyle(
                //               color: Color(0XFFFF0000),
                //               fontSize: 40.0,
                //             )),
                //         IconButton(
                //             icon: const Icon(
                //               Icons.close,
                //               size: 20.00,
                //               color: Color(0XFFFF0000),
                //             ),
                //             onPressed: () {}),
                //       ])
                : statusTyping == 't'
                    ? SizedBox(
                        width: 90.0,
                        height: 70.0,
                        child: TextButton(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(thisletter,
                                    style: const TextStyle(
                                      color: Color(0XFF00FF00),
                                      fontSize: 40.0,
                                    )),
                                const IconButton(
                                  icon: Icon(
                                    Icons.check,
                                    size: 20.00,
                                    color: Color(0XFF00FF00),
                                  ),
                                  onPressed: null,
                                )
                              ],
                            ),
                            style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)), backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)), foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 0, 0)), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0), side: const BorderSide(color: Color.fromARGB(255, 173, 173, 173))))),
                            onPressed: () {}))

                    //  Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                    //     Text(thisletter,
                    //         style: const TextStyle(
                    //           color: Color(0XFF00FF00),
                    //           fontSize: 40.0,
                    //         )),
                    //     IconButton(
                    //         icon: const Icon(
                    //           Icons.check,
                    //           size: 20.00,
                    //           color: Color(0XFF00FF00),
                    //         ),
                    //         onPressed: () {}),
                    //   ])
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
                      () => {
                            //load eraser
                            if (letPouMosa.isNotEmpty)
                              {
                                print(eraseLetter(moChwazi, letPouMosa.last)),
                                setState(() => {
                                      moChwazi =
                                          eraseLetter(moChwazi, letPouMosa.last)
                                    }),
                                letPouMosa.removeLast(),
                                print("denye mo pou affiche " +
                                    letPouMosa.toString()),
                                print("CROSS choosed in the callback")
                              }
                          },
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
    Timer(const Duration(microseconds: 10000), () {
      setState(() => freezeBtn = false);
    });
    mlor = ParseText(moChwazi, rechechMo, ltd, context);
    statusTyping = mlor.split("&")[1];
    print("ici in the puppet master " + statusTyping);
    mlor = mlor.split("&")[0];
    print("men mlor:" + mlor);
    moChwazi = mlor;
    setState(() => {
          moChwazi = mlor,
        });

    if (statusTyping == 'f') {
      if (lives == 1 || lives < 1) {
        // statusTyping = 'f';
        pedi(context);
        setState(() => lives = 0);
        return;
      } else if (lives > 1) {
        Timer(const Duration(microseconds: 600), () {
          setState(() => {
                lives--,
              });
        });
        Timer(const Duration(seconds: 5), () {
          setState(() => {
                statusTyping = 'a',
              });
        });
      }
    } else if (statusTyping == 't') {
      //get the letter and save it
      letPouMosa.add(ltd);
      print("Men denye let tape yo..." + letPouMosa.toString());
      Timer(const Duration(seconds: 1), () {
        setState(() => statusTyping = 'a');
      });
    }
  }

  String pedi(context) {
    print("Ou pedu ui bro");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnfoScreen(
                statusInfo: "loser",
                vies: 0,
                losing: losing,
                winning: winning,
                callbackFunction: () {
                  callbackReplay("loose");
                })));
    return "";
  }

  String ParseText(String word, String search, String letter, context) {
    // moChwazi
    var tmpKrypt = word.split("");
    var tmptesksTab = search.split("");
    thisletter = letter;
    var tmoin = "f";
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
        if (arrayMoKLe.length - 1 < 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MizajouScreen(
                        vies: lives,
                        winning: winning,
                        callbackRekomanse: () {
                          arrayMoKLe = List.from(backupArrowMoKle);
                          callbackReplay("loose");
                        },
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnfoScreen(
                        statusInfo: "winner",
                        vies: lives,
                        losing: losing,
                        winning: winning,
                        callbackFunction: () {
                          callbackReplay(ro);
                        },
                      )));
        }

        // context
      }
      print("Find the bottle");
      print(tmpKrypt);
      print("temoin: " + tmoin);

      return ro + "&" + tmoin;
    }
  }

  String eraseLetter(String word, String letter) {
    var tmpKrypt = word.split("");
    for (var i = 0; i < tmpKrypt.length; i++) {
      if (tmpKrypt[i] == letter) {
        tmpKrypt[i] = "*";
      }
    }
    var ro = "";
    for (var i = 0; i < tmpKrypt.length; i++) {
      ro += tmpKrypt[i];
    }
    return ro;
  }
}
