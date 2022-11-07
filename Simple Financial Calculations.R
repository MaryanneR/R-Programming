#Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Calculations
profit <- revenue - expenses
profit

tax <- round(profit*.30, 2)
tax

after_tax_profit <- profit - tax
after_tax_profit

profit_margin <- round(after_tax_profit/revenue, 2) * 100
profit_margin

mean_of_year <- mean(after_tax_profit)
mean_of_year

good_months <- after_tax_profit > mean_of_year
good_months

bad_months <- !good_months
bad_months
  
best_month <- after_tax_profit == max(after_tax_profit)
best_month

worst_month <- after_tax_profit == min(after_tax_profit)
worst_month

#Conversion to 1K units
revenue.1000 <- round(revenue/1000)
expenses.1000 <- round(expenses/1000)
profit.1000 <- round(profit/1000)
after_tax_profit.1000 <- round(after_tax_profit/1000)

#Print Results
revenue.1000
expenses.1000
profit.1000
after_tax_profit.1000
profit_margin
good_months
bad_months
best_month
worst_month

#matrices
m <- rbind(
  revenue.1000,
  expenses.1000,
  profit.1000,
  after_tax_profit.1000,
  profit_margin,
  good_months,
  bad_months,
  best_month,
  worst_month
)
m