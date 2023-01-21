import 'package:destiny/story.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Destiny());
}

class Destiny extends StatelessWidget {
  const Destiny({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int storyNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/space.jpg"), fit: BoxFit.cover),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 12,
              child: Center(
                child: Text(
                  getQuestions(),
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purple[300])),
                  onPressed: () {
                    setState(() {
                      nextQuestion(1);
                    });
                  },
                  child: Text(
                    getChoice1(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Visibility(
                  visible: buttonShouldBeVisible(),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple[500])),
                    onPressed: () {
                      setState(() {
                        nextQuestion(2);
                      });
                    },
                    child: Text(
                      getChoice2(),
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  String getQuestions() {
    return StoryBrain().storyBrain[storyNumber].storyTitle!;
  }

  String getChoice1() {
    return StoryBrain().storyBrain[storyNumber].choice1!;
  }

  String getChoice2() {
    return StoryBrain().storyBrain[storyNumber].choice2!;
  }

  nextQuestion(int userChoice) {
    if (userChoice == 1 && storyNumber == 0) {
      storyNumber = 2;
    } else if (userChoice == 2 && storyNumber == 0) {
      storyNumber = 1;
    } else if (userChoice == 1 && storyNumber == 1) {
      storyNumber = 2;
    } else if (userChoice == 2 && storyNumber == 1) {
      storyNumber = 3;
    } else if (userChoice == 1 && storyNumber == 2) {
      storyNumber = 5;
    } else if (userChoice == 2 && storyNumber == 2) {
      storyNumber = 4;
    } else if (storyNumber == 3 || storyNumber == 4 || storyNumber == 5) {
      restart();
    }
  }

  void restart() {
    storyNumber = 0;
  }

  bool buttonShouldBeVisible() {
    //You could also just check if (_storyNumber < 3)
    if (storyNumber == 0 || storyNumber == 1 || storyNumber == 2) {
      return true;
    } else {
      return false;
    }
  }
}
