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

VALID_CHOICES = ['rock', 'paper', 'scissors']

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
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

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
