import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/data/constans.dart';
import 'package:quiz_app/data/model.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/result_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.name}) : super(key: key);
  final String? name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  @override
  void initState() {
    name = widget.name;
    super.initState();
  }

  int shownQuestionIndex = 0;
  Qustion? selectedQuestion;
  bool btnPressed = false;
  bool answerd = false;
  int correctAnswer = 0;
  int? selectAns;
  final int duration = 10;
  CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    selectedQuestion = getQuestionsList()[shownQuestionIndex];
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/bg.svg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 5, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: GestureDetector(
                          onTap: () {
                            if (shownQuestionIndex > 0) {
                              setState(() {
                                shownQuestionIndex--;
                                _controller.restart();
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      CircularCountDownTimer(
                        height: 55,
                        width: 55,
                        duration: duration,
                        ringColor: kGreenColor,
                        fillColor: Colors.grey.withOpacity(0.8),
                        ringGradient: LinearGradient(
                            colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)]),
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        autoStart: true,
                        isReverse: true,
                        controller: _controller,
                        onComplete: () {
                          if (shownQuestionIndex <
                              getQuestionsList().length - 1) {
                            setState(() {
                              shownQuestionIndex++;
                            });
                            _controller.restart();
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(
                                          resultanswer: correctAnswer,
                                          nameUser: name,
                                        )));
                          }
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            if (shownQuestionIndex <
                                getQuestionsList().length - 1) {
                              setState(() {
                                shownQuestionIndex++;
                              });
                              _controller.restart();
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                            resultanswer: correctAnswer,
                                            nameUser: name,
                                          )));
                            }
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Question ${shownQuestionIndex + 1}',
                        style: themeData.textTheme.headline4!
                            .copyWith(color: primaryColor),
                      ),
                      Text(
                        '/${getQuestionsList().length}',
                        style: themeData.textTheme.headline5!
                            .copyWith(color: primaryColor),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  endIndent: 20,
                  indent: 20,
                  color: primaryColor,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Text(
                        selectedQuestion!.questionTitle!,
                        style: themeData.textTheme.headline6!
                            .copyWith(color: Color(0xFF101010)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ...List.generate(4, (index) => getOptionItems(index))
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getOptionItems(int index) {
    Color getTheRightColor() {
      if (answerd) {
        if (index == selectedQuestion!.correctAnswer) {
          return kGreenColor;
        } else if (index == selectAns &&
            selectAns != selectedQuestion!.correctAnswer) {
          return kRedColor;
        }
      }
      return kGrayColor;
    }

    Icon getTheRightIcon() {
      return getTheRightColor() == kRedColor
          ? Icon(
              Icons.close,
              color: kRedColor,
              size: 16,
            )
          : Icon(
              Icons.done,
              color: kGreenColor,
              size: 16,
            );
    }

    return InkWell(
        onTap: () {
          if (index == selectedQuestion!.correctAnswer) {
            correctAnswer++;
          }
          setState(() {
            answerd = true;
            selectAns = index;
          });

          if (shownQuestionIndex == getQuestionsList().length - 1) {
            Future.delayed(Duration(seconds: 1)).then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultScreen(
                          resultanswer: correctAnswer,
                          nameUser: name,
                        ))));
          }

          Future.delayed(Duration(seconds: 1)).then((value) => setState(() {
                if (shownQuestionIndex < getQuestionsList().length - 1) {
                  shownQuestionIndex++;
                  answerd = false;
                  _controller.restart();
                }
              }));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: getTheRightColor().withOpacity(0.09),
              border: Border.all(color: getTheRightColor()),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${index + 1}.${selectedQuestion!.answerList![index]}',
                style: TextStyle(fontSize: 16, color: getTheRightColor()),
              ),
              Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: getTheRightColor()),
                    borderRadius: BorderRadius.circular(50)),
                child:
                    getTheRightColor() == kGrayColor ? null : getTheRightIcon(),
              )
            ],
          ),
        ));
  }
}
