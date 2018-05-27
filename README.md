Budgeting calc for the state of TN that takes a text file in a specified format and calculates
your budget, then exports to CSV format. 

program is ran in format: ruby budget.rb your_text_file_containing_budget.txt

Format for text file input:

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
