import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int leftScore = 0;
  int rightScore = 0;
  String leftName = 'Novy';
  String rightName = 'Pedro';
  String temporaryName = "";

  @override
  Widget build(BuildContext context) {
    _dismissDialog() {
      Navigator.pop(context);
    }

    void _showWinnerDialog(side) {
      String winner = "";
      if (side == 'left') {
        winner = leftName;
      } else if (side == 'right') {
        winner = rightName;
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Vencedor:",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$winner!!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      leftScore = 0;
                      rightScore = 0;
                    });
                    _dismissDialog();
                  },
                  child: Text('Finalizar partida'),
                )
              ],
            );
          });
    }

    updateScore(position, action) {
      switch (position) {
        case 'left':
          if (action == "plus") {
            setState(() {
              if (leftScore < 10) {
                leftScore = leftScore + 2;
              } else {
                _showWinnerDialog("left");
              }
            });
          } else if (action == "minus") {
            setState(() {
              if (leftScore > 0) {
                leftScore = leftScore - 2;
              } else {
                leftScore = 0;
              }
            });
          }

          break;
        case 'right':
          if (action == "plus") {
            setState(() {
              if (rightScore < 10) {
                rightScore = rightScore + 2;
              } else {
                _showWinnerDialog("right");
              }
            });
          } else if (action == "minus") {
            setState(() {
              if (rightScore > 0) {
                rightScore = rightScore - 2;
              } else {
                rightScore = 0;
              }
            });
          }
          break;
      }
    }

    void _showMaterialDialog(side) {
      String nameToDisplay = "";
      if (side == 'left') {
        nameToDisplay = leftName;
      } else if (side == 'right') {
        nameToDisplay = rightName;
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Nome: $nameToDisplay'),
              content: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          temporaryName = text;
                        });
                      },
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      _dismissDialog();
                    },
                    child: Text('Fechar')),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (side == 'left') {
                        leftName = temporaryName;
                      } else if (side == 'right') {
                        rightName = temporaryName;
                      }
                      _dismissDialog();
                    });
                  },
                  child: Text('Mudar nome'),
                )
              ],
            );
          });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/logo.png",
                width: 220,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "$leftName",
                        style: TextStyle(fontSize: 40),
                      ),
                      onPressed: () {
                        _showMaterialDialog("left");
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "$rightName",
                        style: TextStyle(fontSize: 40),
                      ),
                      onPressed: () {
                        _showMaterialDialog("right");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$leftScore",
                      style: TextStyle(fontSize: 150),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$rightScore",
                      style: TextStyle(fontSize: 150),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () => updateScore("left", "minus"),
                      child: Icon(
                        Icons.remove,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () => updateScore("left", "plus"),
                      child: Icon(Icons.add),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      onPressed: () => updateScore("right", "minus"),
                      child: Icon(
                        Icons.remove,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      onPressed: () => updateScore("right", "plus"),
                      child: Icon(Icons.add),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                height: 160,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      color: Colors.red,
                      child: Text(
                        'Truco',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      onPressed: () {
                        setState(() {
                          leftScore = leftScore + 4;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      color: Colors.black,
                      child: Text(
                        'Truco',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      onPressed: () {
                        setState(() {
                          rightScore = rightScore + 4;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
