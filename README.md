# The Airline Seat-booking System (TASS)
## ERD/LOGICAL DATA MODEL/SQL QUERIES
I designed a central seat-booking database to be used by all booking offices.
A flight has a flight number which is unique, an airline code, and a business class indicator.
Flight availability has flight number, date and time of departure, number of total seats available in business class, number of confirmed seats in business class, number of total seats available in economy class, and number of confirmed seats in economy class.
Customers may come from any country, not just from the six countries above. A customer is identified by a customer id (which is unique) and has a first name, a last name and a mailing address. A customer also has zero or more phone numbers, and zero or more email addresses.
A mailing address is composed of street, city, province, country and postal code. Phone number has country code, area code and local number which is unique in the country. Email address has only one string, and no structure is assumed.
A customer can book one or more flights. Two or more customers may have same mailing address and/or same phone number(s). But the email address is unique for each customer. First name and last name do not have to be unique.
Booking has the following information:
• a unique booking id
• booking city
• booking date
• flight number
• departure date and time (in local time, and time is always in hours and minutes: in 24 hours format e.g. 13:00
for 1pm exactly)
• arrival date and time (in local time)
• class indicator (i.e., business or economy). This is to be considered as an entity.
• total price (airport tax in origin airport plus airport tax in destination airport plus flight price – in local
currency)
• flight price (business class flight price is 1.5 times of flight price)
• status indicator (there are three types: confirmed – the booking is reserved/booked for the customer; canceled
– the customer canceled the booking, scratched – the customer had not paid in full 30 days prior to the
departure). This is to be considered as an entity.
• paid by (the customer who is responsible for payment)
• paid amount (amount-paid-so far (in local currency))
• balance (outstanding balance (in local currency))
Copyright © Danny Poo, 2023 Page 1 of 3
Some additional information:
• The first name and last name are to be printed on the ticket.
• The airport taxes must be stored in local currencies (i.e. Begonia dollars, Carnation dollars, Gaura dollars,
Ipomoea dollars, Rose dollars, and Tulip dollars).
• Since the exchange rates change daily, they also must be stored for calculations of all prices involved.
Assumptions were made for the followings:
• One City only has one Airport.
• One Country must have at least one City.
• Customers may come from countries other than the six countries listed here; the names of their originating
countries will be provided in the database.
• A Customer in the list may not have any booking.
• All Booking Offices have at least one booking.
• One booking is for one available Flight only.
• All derived attributes (if any) are to be stored in their respective database tables.

## Data Visualisation and Storytelling with Tableau
Using dataset “TwoAirlineFlights.xlsx” on flight data of two airlines for July and August 2019. The two airlines, Acorn Airlines (AA) and Berry Airlines (BA) were compared to gain insights such that improvements can be made for Acorn Airlines.

BACKGROUND INFORMATION
The airline industry has grown into one of the world’s important industries having a direct impact on the world economy. However, the airline industry is also characterized by the presence of strong competition among the carriers. In addition, the industry faces rapid changes due to technology innovations, increased costs due to fuel price hikes and increased regulatory requirements. In such a competitive environment, airlines that have optimum aircraft utilization and on time performance get an advantage on the airline’s economic perspective and customer satisfaction.
A recent industry analysis in the USA has indicated that the worst airline delays occur during the summer travel season. Each year, a record number of travelers turn up at the airports for leisure travel during the summer season. It was reported that the airlines in the USA operated more than 1 million flights between July and August 2019, according to the U.S. Department of Transportation’s Bureau of Transportation Statistics (BTS). As a result of this increased demand, airlines are prone to delays during this season due to various reasons.
For an airline, an aircraft is a very expensive asset. State of the art aircrafts cost several million dollars a month in lease payments alone. As a result, airlines tend to operate with the least number of aircrafts with each aircraft utilized optimally with higher on-air times and lower turnaround times at the airport. Since the airlines operate with the minimum number of aircrafts, a delay in one flight segment can have a propagation effect of delaying several other flights that utilize the same aircraft. In case of a delay in departure, the airlines do not have freedom of flying at will due to increased air traffic and increased fuel costs as a result of increased speed of flight.

