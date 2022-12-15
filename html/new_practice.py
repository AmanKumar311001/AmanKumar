import csv

# opening the CSV file
with open('new.csv', mode ='r')as file:

# reading the CSV file
    csvfile= csv.reader(file)

# displaying the contents of the CSV file
    for lines in csvfile:
        print(lines)
