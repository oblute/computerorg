All: convertFeet2Inches convertFahrenheit2Celsius convertMiles2Kilometers kilometersPerHour
LIB=libConversions.o
CC=gcc

convertFeet2Inches: convertFeet2Inches.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

convertFahrenheit2Celsius: convertFahrenheit2Celsius.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

convertMiles2Kilometers: convertMiles2Kilometers.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

kilometersPerHour: kilometersPerHour.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
