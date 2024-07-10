# Scissors cuts paper covers rock crushes lizard poisons Spock
# smashes scissors decapitates lizard eats paper disproves
# Spock vaporizes rock crushes scissors.

# Scissors wins over: paper, lizard
# Scissors loses under: rock, Spock
# Rock wins over: scissors, lizard
# Rock loses under: paper, Spock
# Paper wins over: rock, Spock
# Paper loses under: scissors, lizard
# Lizard wins over: Spock, paper
# Lizard loses under: scissors, rock
# Spock wins over: scissors, rock
# Spock loses under: paper, lizard

VALID_MOVES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
VALID_MOVE_ABBREVIATIONS = ['r', 'p', 's', 'l', 'sp']

GAME_LOGIC_HASH = {'scissors' => ['paper', 'lizard'],
                    'rock' => ['scissors', 'lizard'],
                    'paper' => ['rock', 'spock'],
                    'lizard' => ['spock', 'paper'],
                    'spock' => ['scissors', 'rock']}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def print_game_tutorial
  puts <<-TUTORIAL

  In this game, scissors cuts paper covers rock crushes lizard poisons Spock
  smashes scissors decapitates lizard eats paper disproves Spock vaporizes 
  rock crushes scissors.

  You may type the full word or the first letter of your choice, except for 
  Spock, where you will type "sp".

  Whichever player first wins three games, wins the match and becomes the Grand Champion.

  Have fun!

  TUTORIAL
end

def translate_users_move(move)
  case move
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 's' then 'scissors'
  when 'l' then 'lizard'
  when 'sp' then 'spock'
  else move
  end
end  

def win?(first, second)
  GAME_LOGIC_HASH[first].include?(second)
end

def display_results(player, computer, scoring_array)
  if win?(player, computer)
    prompt("You won!")
    tally_score('user', scoring_array)
  elsif win?(computer, player)
    prompt("Computer won!")
    tally_score('machine', scoring_array)
  else
    prompt("It's a tie!")
    tally_score('tie', scoring_array)
  end
end

def tally_score(winner, scoring_array)
  scoring_array << winner
end

def display_score(scoring_array)
  player_score = 0
  computer_score = 0

  if scoring_array.tally['user']
    player_score = scoring_array.tally['user']
  end

  if scoring_array.tally['machine']
    computer_score = scoring_array.tally['machine']
  end

  prompt("Your score: #{player_score}; Computer score: #{computer_score}")
end

def game_over?(scoring_array)
  if scoring_array.tally['user'] == 3 
    "You"
  elsif scoring_array.tally['machine'] == 3
    "Computer"
  else
    false
  end
end

scoring_array = []
champion = ""

prompt("Welcome to Rock Paper Scissors Lizard Spock!")
prompt("Would you like a game tutorial?")
tutorial_preference = gets.chomp

if tutorial_preference.downcase.start_with?('y')
  print_game_tutorial
else
  prompt('Okay, on to the game!')
end

loop do
  loop do
    choice = ''
    loop do
      prompt("Choose one: #{VALID_MOVES.join(', ')}")
      choice = Kernel.gets().chomp().downcase

      if VALID_MOVES.include?(choice) || VALID_MOVE_ABBREVIATIONS.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    choice = translate_users_move(choice)
    computer_choice = VALID_MOVES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    display_results(choice, computer_choice, scoring_array)
    display_score(scoring_array)

    champion = game_over?(scoring_array)
    break if champion
  end

  prompt("#{champion} won the match! Congratulations to the Grand Champion!")

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
  scoring_array = []
end

prompt("Thank you for playing. Good bye!")
