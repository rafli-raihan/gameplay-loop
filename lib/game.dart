import 'dart:async';
import 'dart:io';

class Game {
  int score = 0;
  bool isPlaying = true;
  int timeLimit; // Time limit in seconds
  Timer? gameTimer;
  DateTime? endTime; // The time when the timer will end

  Game(this.timeLimit);

  void start() async {
    print('Game started! You have $timeLimit seconds to score as many points as you can.');

    // Start the game timer
    startTimer();

    // Start the gameplay loop
    await gameplayLoop();
  }

  void startTimer() {
    endTime = DateTime.now().add(Duration(seconds: timeLimit));

    // Create a timer that will call endGame when the time is up
    gameTimer = Timer(Duration(seconds: timeLimit), endGame);
  }

  bool isTimerActive() {
    if (endTime != null) {
      // Check if current time is before the end time
      return DateTime.now().isBefore(endTime!);
    }
    return false;
  }

  Future<void> gameplayLoop() async {
    while (isTimerActive()) {
      print('Press "Y" to score a point:');
      
      // Wait for the player to input
      String? control = stdin.readLineSync();
      
      if (control == "Y" || control == "y") {
        score++;
        print('You scored! Total points: $score');
        
        // Add 10 seconds to the timer and restart it
        timeLimit = 10;
        startTimer();  // Reset the timer after scoring
      } else {
        print("Try again");
      }
    }
  }

  void endGame() {
    isPlaying = false;
    gameTimer?.cancel(); // Cancel the timer
    print('\nTime\'s up! Final score: $score');
    exit(0); // Exit the program
  }
}


