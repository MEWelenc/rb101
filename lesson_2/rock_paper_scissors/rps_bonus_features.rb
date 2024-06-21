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

  Have fun!
  TUTORIAL
end

def win?(first, second)
  GAME_LOGIC_HASH[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

prompt("Welcome to Rock Paper Scissors Lizard Spock!")
prompt("Would you like a game tutorial?")
tutorial_preference = gets.chomp

if tutorial_preference.downcase.start_with?('y')
  print_game_tutorial
else
  prompt('Okay, on to the game!')
end

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

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
