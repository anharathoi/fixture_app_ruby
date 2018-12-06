# Create Sports Fixture
This is a terminal app that generates fixtures, the starting date is set by the user.
### Configuration
- Clone the git repository
- Run bundle
- Open the program in terminal

### How it works
- The app is based on the Round Robin algorithm, each team plays the other team once.
- It utilizes the [round_roubin_tournament](https://github.com/ssaunier/round_robin_tournament) gem to create fixtures

### Features
- The games between are randomized, each time the app runs it generates a different fixture
- The rounds are set one week apart from each other
- All the games are set on either Saturday or Sunday
- The home teams are diplayed in green and the away teams in blue