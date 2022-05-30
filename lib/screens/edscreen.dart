import "package:flutter/material.dart";

class EdScreen extends StatelessWidget {
  const EdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF5271FF),
        title: const Text("Apran'n jwe Hangman"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40.0),
            width: double.infinity,
            child: Text(
              "* * Y *",
              style: const TextStyle(fontSize: 35.0),
              textAlign: TextAlign.center,
            ),
          ),
          Text("Itil pou note yon bagay"),
          Container(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text("Li epi konpran teks ki ekri anba pil ti etwal yo...",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0XFF5271FF),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            child: const Text(
                "Chak ti etwal sa yo reprezante on lèt nan mo nou chwazi a...",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0XFF000000),
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15.0),
            child: const Text(
                "Jis tape mo'w panse ki bon a lèt pa lèt nan klavye sa...",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0XFF000000),
                    fontWeight: FontWeight.bold)),
          ),
          Icon(
            Icons.arrow_downward_rounded,
            color: Color(0XFF5271FF),
            size: 60.0,
          ),
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
                  ...listKeyboard(
                      ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"])
                ],
              )),
          Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
              color: const Color(0XFFD1D4D9),
              child: GridView.count(
                padding: const EdgeInsets.only(top: 5.0),
                primary: false,
                shrinkWrap: true,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 9,
                children: [
                  ...listKeyboard(["A", "S", "D", "F", "G", "H", "J", "K", "L"])
                ],
              )),
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
                    ...listKeyboard(
                        ["MAJ", "Z", "X", "C", "V", "B", "N", "M", "CROSS"])
                  ])),
        ],
      ),
    );
  }

  List<Widget> listKeyboard(List<String> keyboard) {
    List<Widget> listwidget = [];
    for (var i = 0; i < keyboard.length; i++) {
      listwidget.add(touche(keyboard[i]));
    }
    return listwidget;
  }

  Widget touche(String lt) {
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
          onPressed: () {});
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
          onPressed: () {});
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
              backgroundColor: MaterialStateProperty.all<Color>(lt == "Y"
                  ? const Color(0XFF5271FF)
                  : const Color.fromARGB(255, 255, 255, 255)),
              foregroundColor: MaterialStateProperty.all<Color>(lt == "Y"
                  ? Colors.white
                  : const Color.fromARGB(255, 0, 0, 0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(
                          color: Color.fromARGB(255, 173, 173, 173))))),
          onPressed: () {});
    }
  }
}
