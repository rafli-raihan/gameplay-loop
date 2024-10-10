import 'dart:async';
import 'dart:io';

class Game {
  int score = 0;
  bool isPlaying = true;
  int timeLimit; // Time limit in seconds
  Timer? gameTimer;
  DateTime? endTime; // The time when the timer will end

  Game(this.timeLimit);

  Future start() async {
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
      // Check if the current time is before the end time
      return DateTime.now().isBefore(endTime!);
    }
    return false; // If endTime is null, the timer is not active
  }

  int getRemainingTime() {
    if (endTime != null) {
      // Calculate remaining time by subtracting current time from endTime
      return endTime!.difference(DateTime.now()).inSeconds;
    }
    return 0;
  }

  Future gameplayLoop() async {
    while (isTimerActive()) {
      // Stop the loop immediately if the timer is inactive
      if (!isTimerActive()) {
        print("Time's up");
        break;
      }

      // Display the remaining time
      print('Remaining time: ${getRemainingTime()} seconds');
      print('Press "Y" to score a point (or any other key to try again):');
      
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

      // Add a slight delay for better display of countdown (optional)
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void endGame() {
    isPlaying = false;
    gameTimer?.cancel(); // Cancel the timer
    print('\nTime\'s up! Final score: $score');
    exit(0); // Exit the program
  }
}

