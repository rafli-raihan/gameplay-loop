import 'dart:async';
import 'dart:io';

class Game {
  int score = 0;
  bool isPlaying = true;
  int remainingTime; // Remaining time in seconds
  Timer? gameTimer;

  Game(this.remainingTime);

  void start() {
    print('Game started! You have $remainingTime seconds to score as many points as you can.');

    // Start the game timer
    startTimer();

    // Start the gameplay loop
    gameplayLoop();
  }

  void startTimer() {
    // Cancel any existing timer if it exists
    gameTimer?.cancel();

    // Create a new timer that triggers after the remaining time
    gameTimer = Timer(Duration(seconds: remainingTime), endGame);
  }

  void gameplayLoop() async {
    while (isPlaying) {
      print('Press enter to score a point (remaining time: $remainingTime seconds):');

      // Wait for the player to press Enter
      await stdin.readLineSync();

      if (isPlaying) {
        score++;
        print('You scored! Total points: $score');

        // Add 2 seconds to the remaining time
        remainingTime += 2;
        print('Time extended! Remaining time: $remainingTime seconds');

        // Restart the timer with the updated time
        startTimer();
      }
    }
  }

  void endGame() {
    isPlaying = false;
    gameTimer?.cancel(); // Ensure timer is stopped
    print('\nTime\'s up! Final score: $score');
    exit(0); // Exit the program
  }
}

