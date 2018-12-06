require 'round_robin_tournament'
require 'colorize'
require "chronic"

# Team data
team_1 = {
  name: "Manchester United",
  location: "Old Trafford"
}
team_2 = {
  name: "Real Madrid",
  location: "Santiago Bernabéu Stadium"
}
team_3 = {
  name: "Barcelona",
  location: "Camp Nou"
}
team_4 = {
  name: "Bayern Munich",
  location: "Allianz Arena"
}
team_5 = {
  name: "Manchester City",
  location: "Etihad Stadium"
}
team_6 = {
  name: "Arsenal",
  location: "Emirates Stadium"
}
team_7 = {
  name: "Chelsea",
  location: "Stamford Bridge"
}
team_8 = {
  name: "Liverpool",
  location: "Anfield"
}
teams = [team_1, team_2, team_3, team_4, team_5, team_6, team_7, team_8]

matches = RoundRobinTournament.schedule(teams.shuffle)

def make_fixture(array) 
  puts "What day does this season begin?(e.g 01 january 2020 or 01/01/2019 or 01 jan)"
  fixture = []
  dateinput = gets.chomp
  a_day = 60 * 60 * 24 # secods in a day to use later
  season_start_date = Chronic.parse("#{dateinput.downcase}")
  while season_start_date.wday < 6
    season_start_date = season_start_date += 1 # makes start date the next saturday
  end
  # p season_start_date.strftime('%A, %d %b %Y %l:%M %p')
  array.each_with_index do |round, c|
    round_start_date = season_start_date + a_day * c * 7
    round_number = c + 1

    round.each_with_index do |game, i|
      game_number = i + 1
      if i < round.length/2
        game_date = round_start_date
      else
        game_date = round_start_date + a_day
      end
      home_team = game[0]
      away_team = game[1]
      make_game = {
        round: round_number,
        game: game_number,
        location: home_team[:location],
        home_team: home_team[:name],
        away_team: away_team[:name],
        date_time: game_date.strftime('%A, %d %b %Y %l:%M %p')
      }
      fixture << make_game
    end
  end
  fixture
end


def print_fixture(matchArray)
  fixture = make_fixture(matchArray)
  fixture.each_with_index do |game|
      puts """
      =========== Round: #{game[:round]} ===========
      Game: #{game[:game]}
      Location: #{game[:location]}
      Home Team: #{game[:home_team].colorize(:green)}
      VS
      Away Team: #{game[:away_team].colorize(:blue)}
      Date/Time: #{game[:date_time]}
      "
  end
end

print_fixture(matches)
