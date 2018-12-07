require 'round_robin_tournament'
require 'colorize'
require 'chronic'
require 'pry'

# Team data
team_1 = {
  name: 'Manchester United',
  location: 'Old Trafford'
}
team_2 = {
  name: 'Real Madrid',
  location: 'Santiago Bernabéu Stadium'
}
team_3 = {
  name: 'Barcelona',
  location: 'Camp Nou'
}
team_4 = {
  name: 'Bayern Munich',
  location: 'Allianz Arena'
}
team_5 = {
  name: 'Manchester City',
  location: 'Etihad Stadium'
}
team_6 = {
  name: 'Arsenal',
  location: 'Emirates Stadium'
}
team_7 = {
  name: 'Chelsea',
  location: 'Stamford Bridge'
}
team_8 = {
  name: 'Liverpool',
  location: 'Anfield'
}
teams = [team_1, team_2, team_3, team_4, team_5, team_6, team_7, team_8]

##### Creating team pairs for each game with round_robin gem
def create_pairs(teams)
  return RoundRobinTournament.schedule(teams.shuffle)
end

##### Parsing the date to set the rounds a week apart from one another #####

def date_parser(date)
  date = Chronic.parse("#{date.downcase}")
  while date.wday < 6
    date = date += 1 # makes start date the next saturday from the input date
  end
  return date
end


def print_fixture(fixture)
  fixture.each_with_index do |game|
      puts """
      =========== Round: #{game[:round]} | Game: #{game[:game]} ===========

      Date/Time: #{game[:date_time]}
      Location: #{game[:location]}
      Home Team: #{game[:home_team].colorize(:green)}
      VS
      Away Team: #{game[:away_team].colorize(:blue)}
      "
  end
end


####### Making the Fixture #######

def make_fixture(teams, date) 
  pairs = create_pairs(teams)
  start_date = date_parser(date)
  fixture = []
  a_day = 60 * 60 * 24 # seconds in a day to use later

  pairs.each_with_index do |round, c|
    round_start_date = start_date + a_day * c * 7
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
  print_fixture(fixture)
  fixture
end

# Getting the start date ##
puts "What day does this season begin?(e.g 01 january 2020 or mm/dd/yyyy or 01 jan)"
dateinput = gets.chomp

fixture = make_fixture(teams, dateinput)


############# Find when your favourite Club is playing #############

def get_info_on_club(fixture)
  puts "See when your favourites are playing:(enter favourite club name)"
  fav_club = gets.chomp
  all_fav_matches = fixture.map do |game|
    if game[:home_team].downcase.include?(fav_club) || game[:away_team].downcase.include?(fav_club)
      game
    end
  end.compact

  if all_fav_matches.empty?
    puts "Did not match the database!"
  else
    puts all_fav_matches
  end
end

# get_info_on_club(fixture)
