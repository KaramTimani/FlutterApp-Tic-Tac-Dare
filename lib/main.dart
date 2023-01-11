import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //removes the red debug banner on the right
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //1.can be read synchronously when the widget is built
  //2.might change during the lifetime of the widge

  static var myFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      fontSize: 15.0,
      color: Color.fromARGB(255, 255, 255, 255),
      letterSpacing: 3,
      fontWeight: FontWeight.bold,
    ),
  );
  static var footerFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      fontSize: 8.0,
      color: Color.fromARGB(255, 255, 255, 255),
      letterSpacing: 3,
      fontWeight: FontWeight.bold,
    ),
  );
  bool isTurn = true; //to check who's turn it is
  int oScore = 0; //the score for O
  int xScore = 0; //the score of X
  int count = 0; //check how many times we pressed on the grid
  List<String> changeXO = [
    //list to save either the value of x or o
    // initially it is empty
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold is a class in flutter which provides many widgets
      //If you really really don't want to use scaffold, then use the Material widget
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      body: SafeArea(
        //Containing all the ui for the app
        child: Column(
          children: [
            Expanded(
              //The header
              child: Padding(
                //padding
                padding: const EdgeInsets.all(25.0), //value of the padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Place all the children of Row widget in center as close as possible.
                  children: [
                    Column(
                      children: [
                        Text(
                          'Player X',
                          style: GoogleFonts.pressStart2p(
                            textStyle: myFont,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(xScore.toString(), style: myFont),
                      ],
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Column(
                      children: [
                        Text(
                          'Player O',
                          style: myFont,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          oScore.toString(),
                          style: myFont,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              //The grid part
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0), //padding of the grid
                child: GridView.builder(
                  //GridBuilder
                  itemBuilder: (BuildContext context, int index) {
                    //allows us to interact with the app
                    return GestureDetector(
                      onTap: () {
                        //when you tap a function is called
                        setXOrO(index); //set value x or set value o
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //the border of the grid
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                            child: Text(
                          changeXO[index], //change the value inside the list
                          style: myFont,
                        )),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                ),
              ),
            ),
            Center(
              //the footer
              child: Padding(
                padding: const EdgeInsets.all(35.0), //padding
                child: Text(
                  'TIC TAC TOE',
                  style: myFont,
                ),
              ),
            ),
            Center(
              //the footer
              child: Padding(
                padding: const EdgeInsets.all(5.0), //padding
                child: Text(
                  'Karam and Chokor',
                  style: footerFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setXOrO(int i) {
    if (isTurn && changeXO[i] == '') {
      setState(() {
        changeXO[i] = 'o';
        isTurn = !isTurn;
      });
    } else if (!isTurn && changeXO[i] == '') {
      setState(() {
        changeXO[i] = 'x';
        isTurn = !isTurn;
      });
    }
    count++;
    checkWinner();
  }

  void checkWinner() {
    if (changeXO[0] == changeXO[1] &&
        changeXO[0] == changeXO[2] &&
        changeXO[0] != '') {
      _showDialog(changeXO[0]);
    }
    if (changeXO[3] == changeXO[4] &&
        changeXO[3] == changeXO[5] &&
        changeXO[3] != '') {
      _showDialog(changeXO[3]);
    }
    if (changeXO[6] == changeXO[7] &&
        changeXO[6] == changeXO[8] &&
        changeXO[6] != '') {
      _showDialog(changeXO[6]);
    }

    if (changeXO[0] == changeXO[3] &&
        changeXO[0] == changeXO[6] &&
        changeXO[0] != '') {
      _showDialog(changeXO[0]);
    }
    if (changeXO[1] == changeXO[4] &&
        changeXO[1] == changeXO[7] &&
        changeXO[1] != '') {
      _showDialog(changeXO[1]);
    }
    if (changeXO[2] == changeXO[5] &&
        changeXO[2] == changeXO[8] &&
        changeXO[2] != '') {
      _showDialog(changeXO[2]);
    }

    if (changeXO[0] == changeXO[4] &&
        changeXO[0] == changeXO[8] &&
        changeXO[0] != '') {
      _showDialog(changeXO[0]);
    }
    if (changeXO[2] == changeXO[4] &&
        changeXO[2] == changeXO[6] &&
        changeXO[2] != '') {
      _showDialog(changeXO[2]);
    }

    if (count == 9) {
      _showNoWinner();
      clearBoard();
    }
  }

  void _showNoWinner() {
    // will called at the end of condition of check winner method
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No Winner'),
            actions: [
              TextButton(
                onPressed: () {
                  count = 0;
                  clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text('Play again'),
              ),
            ],
          );
        });
  }

  // a function that return a random string of dares
  String _getRandomDare() {
    var random = Random();
    // array of dares
    var dares = [
      "Show the most embarrassing photo on your phone",
      "Show the last five people you texted and what the messages said",
      "Let the rest of the group DM someone from your Instagram account",
      "Eat a raw piece of garlic",
      "Do 100 squats",
      "Keep three ice cubes in your mouth until they melt",
      "Say something dirty to the person on your left",
      "Give a foot massage to the person on your right",
      "Put 10 different available liquids into a cup and drink it",
      "Yell out the first word that comes to your mind",
      "Give a lap dance to someone of your choice",
      "Remove four items of clothing",
      "Like the first 15 posts on your Facebook newsfeed",
      "Eat a spoonful of mustard",
      "Keep your eyes closed until it's your go again",
      "Send a sext to the last person in your phonebook",
      "Show off your orgasm face",
      "Seductively eat a banana",
      "Empty out your wallet/purse and show everyone what's inside",
      "Do your best sexy crawl",
      "Pretend to be the person to your right for 10 minutes",
      "Eat a snack without using your hands",
      "Say two honest things about everyone else in the group",
      "Twerk for a minute",
      "Try and make the group laugh as quickly as possible",
      "Try to put your whole fist in your mouth",
      "Tell everyone an embarrassing story about yourself",
      "Try to lick your elbow",
      "Post the oldest selfie on your phone on Instagram Stories",
      "Tell the saddest story you know",
      "Howl like a wolf for two minutes",
      "Dance without music for two minutes",
      "Pole dance with an imaginary pole",
      "Let someone else tickle you and try not to laugh",
      "Put as many snacks into your mouth at once as you can"
    ];
    int randomIndex = random.nextInt(dares.length);
    return dares[randomIndex];
  }

  void _showDialog(String winner) {
    // will called at the end of condition of check winner method
    var dare = _getRandomDare();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$winner is a winner.The other player has to: $dare'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Play again'),
              ),
            ],
          );
        });
    count = 0;
    clearBoard();
    if (winner == 'o') {
      setState(() {
        oScore++;
      });
    } else if (winner == 'x') {
      setState(() {
        xScore++;
      });
    }
  }

  void clearBoard() {
    for (int i = 0; i < 9; i++) {
      changeXO[i] = '';
    }
  }
}
