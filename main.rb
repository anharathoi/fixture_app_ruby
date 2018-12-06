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
  puts "What day does this season begin?(e.g 01 january 2020)"
  dateinput = gets.chomp
  a_day = 60 * 60 * 24 # secods in a day to use later
  season_start_date = Chronic.parse("#{dateinput.downcase}")
  while season_start_date.wday < 6
    season_start_date = season_start_date += 1 # makes start date the next saturday
  end
# p season_start_date.strftime('%A, %d %b %Y %l:%M %p')
  array.each_with_index do |round, i|

    # games divided in two
  round_start_date = season_start_date + a_day * i * 7
    
    puts "------------- Round #{i+1} ---------------"
    puts

    round.each_with_index do |game, i|
      if i < round.length/2
        game_date = round_start_date
      else
        game_date = round_start_date + a_day
      end
      puts "Game #{i+1}"
      home_team = game[0]
      away_team = game[1]
      puts """
      Location: #{home_team[:location]}
      Home Team: #{home_team[:name].colorize(:green)}
      VS
      Away Team: #{away_team[:name].colorize(:blue)}
      Date/Time: #{game_date.strftime('%A, %d %b %Y %l:%M %p')}
      """
    end
  end
end
make_fixture(matches)

