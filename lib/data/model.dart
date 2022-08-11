import 'package:quiz_app/data/questions.dart';

List<Qustion> getQuestionsList() {
  var firstQuestion = Qustion();
  firstQuestion.questionTitle =
      'Flutter is an open-source UI software development kit created by ______';
  firstQuestion.correctAnswer = 1;
  firstQuestion.answerList = ['Apple', 'Google', 'Facebook', 'Microsoft'];

  var secondQuestion = Qustion();
  secondQuestion.questionTitle = 'When google release Flutter.';
  secondQuestion.correctAnswer = 2;
  secondQuestion.answerList = ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'];

  var thirdQuestion = Qustion();
  thirdQuestion.questionTitle =
      'A memory location that holds a single letter or number.';
  thirdQuestion.correctAnswer = 2;
  thirdQuestion.answerList = ['Double', 'Int', 'Char', 'Word'];

  var fourthQuestion = Qustion();
  fourthQuestion.questionTitle =
      'What command do you use to output data to the screen?';
  fourthQuestion.correctAnswer = 2;
  fourthQuestion.answerList = ['Cin', 'Count>>', 'Cout', 'Output>>'];

  return [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion];
}
