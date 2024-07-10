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

VALID_CHOICES = ['r', 'p', 's', 'l', 'v']

USER_INPUT_TRANSLATION = {'r' => 'rock', 'p' => 'paper', 's' => 'scissors',
                          'l' => 'lizard', 'v' => 'Spock'}

GAME_LOGIC_HASH = {'s' => ['p', 'l'],
                    'r' => ['s', 'l'],
                    'p' => ['r', 'v'],
                    'l' => ['v', 'p'],
                    'v' => ['s', 'r']}

def prompt(message)
  Kernel.puts("=> #{message}")
end

def print_game_tutorial
  puts <<-TUTORIAL

  In this game, scissors cuts paper covers rock crushes lizard poisons Spock
  smashes scissors decapitates lizard eats paper disproves Spock vaporizes 
  rock crushes scissors.

  You will type the first letter of your choice, except for Spock, where
  you will type "v" because he is a Vulcan!

  So type s for scissors, r for rock, p for paper, l for lizard, and v for Spock!

  Whichever player first wins three games, wins the match and becomes the Grand Champion.

  Have fun!

  TUTORIAL
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
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = Kernel.gets().chomp()

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{USER_INPUT_TRANSLATION[choice]}; Computer chose: #{USER_INPUT_TRANSLATION[computer_choice]}")

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
