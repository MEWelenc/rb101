require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

LANGUAGE = 'english'

def messages(message, lang='english')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  puts message
end

def obtain_name(name)
  loop do
    name = gets.chomp
    if name.strip.empty?
      prompt('valid_name')
    else
      break
    end
  end
  name
end

def obtain_loan_amount
  prompt('prompt_amount')

  loan_amount = 0

  loop do
    loan_amount = gets.chomp
    if valid_float(loan_amount) && greater_than_zero(loan_amount)
      break
    else
      prompt('amount_validation_fail')
    end
  end
  loan_amount
end

def obtain_loan_years
  prompt('prompt_years')

  loan_years = 0

  loop do
    loan_years = gets.chomp
    if valid_float(loan_years) && greater_than_zero(loan_years)
      break
    else
      prompt('years_validation_fail')
    end
  end
  loan_years
end

def obtain_apr
  prompt('prompt_apr')

  apr = 0

  loop do
    apr = gets.chomp
    if valid_float(apr) && apr.to_f >= 0
      break
    else
      prompt('apr_validation_fail')
    end
  end
  apr
end

def valid_float(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def greater_than_zero(input)
  input.to_f > 0
end

def years_to_months(years)
  years.to_f * 12
end

def percentage_to_decimal(percentage)
  percentage.to_f / 100
end

def calculate_monthly_rate(apr)
  apr / 12
end

def calculate_monthly_payment(loan_amount, monthly_interest_rate, loan_months)
  loan_amount * (monthly_interest_rate /
    (1 - ((1 + monthly_interest_rate)**(-loan_months))))
end

prompt('welcome')

name = ''

name = obtain_name(name)
puts format(messages('greeting'), name: name)

loop do
  loan_amount = obtain_loan_amount
  loan_years = obtain_loan_years
  apr = obtain_apr

  loan_months = years_to_months(loan_years)
  decimal_apr = percentage_to_decimal(apr)
  monthly_interest_rate = calculate_monthly_rate(decimal_apr)
  monthly_payment = calculate_monthly_payment(loan_amount.to_f,
                                              monthly_interest_rate,
                                              loan_months)
  monthly_payment = format("%.2f", monthly_payment)

  puts format(messages('display_payment'), monthly_payment: monthly_payment)

  prompt('prompt_restart')
  calculate_again = gets.chomp

  break unless calculate_again.downcase.start_with?("y")
end

puts format(messages('thank'), name: name)
prompt('farewell')
