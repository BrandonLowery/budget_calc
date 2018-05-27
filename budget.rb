
# line num of txt file:

# 0. line will be income
# 1. line will be housing cost in 1 month format
# 2. line is water in month
# 3. is elec in month
# 4. is house/renters insurance
# 5. is estimated monthly grocery
# 6. is car payment if exists monthly
# 7. is car insurance
# 8. is % of income set back in month for retirement
# any remaining line is min payment on a debt owed

# fed inc tax will be flat for testing, to be made real later

def taxes(income)
  income * 0.85 # flat 15% tax, will change to irl later
end

def housing(income, rent, water, elec, insur)
  income - (rent + water + elec + insur) # deducts water, elec, housing insur
end

def food(income, food)
  income - food # deducts groceries
end

def car(income, car_p, car_i)
  income - (car_p + car_i)
end

def responsible(income, future_happiness)
  income * 100 - future_happiness # sets back some for old you!
end

def sadness(income, debt)
  # deducts bad stuff
  total_debt = 0
  debt.each do |d|
    total_debt += d
  end
  income - total_debt
end

arr = []
File.open(ARGV[0]).each do |line| # open file and process
  arr << line.to_f # all lines are float to increase accuracy
end

# arr.each do |line|
#  puts line
# end

real_income = responsible(arr[0], arr[8]) # set up for 401k/403b pre-tax contrib
real_income = taxes(real_income) # does your taxes... kinda ;)
real_income /= 12 # gives monthly income
post_housing = housing(real_income, arr[1], arr[2], arr[3], arr[4])

post_food = food(post_housing, arr[5])
post_car = car(post_food, arr[6], arr[7])

# block to calc debts
arr2 = [] # array for debt
last = arr.length
for counter in 9..last - 1 # apparently MUST use counter instead of i
  arr2 << arr[counter]
end

debt = 0.0 # adds up your min debt payments
arr2.each { |num| debt = num + debt } # debt += num.to_f }

arr[9] = debt # sets min debt to 1 field
arr = arr[0..9] # removes debt already totaled
arr.delete_at(7) # deletes ele 7, which is % saved for retirement

final_income = sadness(post_car, arr2) # subtracts your min debt payments

# export to CSV
header = %w[Income Rent Water Electric Rent_Insurance Groceries Car_Payment
            Car_Insurance Min_Debt_Payments Discretionary_Income]

final = arr + [final_income - debt]

require 'csv'
CSV.open('budget.csv', 'w') do |csv|
  csv << header
  csv << final
end

puts 'Done'
