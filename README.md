# The Airline Seat-booking System (TASS)
## ERD/LOGICAL DATA MODEL/SQL QUERIES
I designed a central seat-booking database to be used by all booking offices.

**Flight Information:**
- Flight number (unique)
- Airline code
- Business class indicator

**Flight Availability:**
- Flight number
- Date and time of departure
- Number of total seats in business class
- Number of confirmed seats in business class
- Number of total seats in economy class
- Number of confirmed seats in economy class

**Customers:**
- Customer ID (unique)
- First name
- Last name
- Mailing address (composed of street, city, province, country, and postal code)
- Phone numbers (each has country code, area code, and a unique local number)
- Email addresses (unique per customer)

**Booking:**
- Unique booking ID
- Booking city
- Booking date
- Flight number
- Departure date and time (local time, 24-hour format)
- Arrival date and time (local time)
- Class indicator (business or economy)  
  _Entity_
- Total price (local currency)
- Flight price (business class is 1.5x of economy class price)
- Status indicator (confirmed, canceled, scratched)  
  _Entity_
- Paid by (customer responsible for payment)
- Paid amount (local currency)
- Balance (outstanding, local currency)

**Additional Information:**
- The first name and last name are to be printed on the ticket.
- Airport taxes stored in local currencies.
- Daily exchange rates stored for price calculations.

**Assumptions:**
- One city = One airport
- One country >= One city
- Customers can come from countries other than the listed six.
- Some customers might not have bookings.
- All booking offices have at least one booking.
- One booking corresponds to one flight.
- All derived attributes are stored in their database tables.
## Data Visualisation and Storytelling with Tableau
Using dataset “TwoAirlineFlights.xlsx” on flight data of two airlines for July and August 2019. The two airlines, Acorn Airlines (AA) and Berry Airlines (BA) were compared to gain insights such that improvements can be made for Acorn Airlines.

BACKGROUND INFORMATION
The airline industry has grown into one of the world’s important industries having a direct impact on the world economy. However, the airline industry is also characterized by the presence of strong competition among the carriers. In addition, the industry faces rapid changes due to technology innovations, increased costs due to fuel price hikes and increased regulatory requirements. In such a competitive environment, airlines that have optimum aircraft utilization and on time performance get an advantage on the airline’s economic perspective and customer satisfaction.
A recent industry analysis in the USA has indicated that the worst airline delays occur during the summer travel season. Each year, a record number of travelers turn up at the airports for leisure travel during the summer season. It was reported that the airlines in the USA operated more than 1 million flights between July and August 2019, according to the U.S. Department of Transportation’s Bureau of Transportation Statistics (BTS). As a result of this increased demand, airlines are prone to delays during this season due to various reasons.
For an airline, an aircraft is a very expensive asset. State of the art aircrafts cost several million dollars a month in lease payments alone. As a result, airlines tend to operate with the least number of aircrafts with each aircraft utilized optimally with higher on-air times and lower turnaround times at the airport. Since the airlines operate with the minimum number of aircrafts, a delay in one flight segment can have a propagation effect of delaying several other flights that utilize the same aircraft. In case of a delay in departure, the airlines do not have freedom of flying at will due to increased air traffic and increased fuel costs as a result of increased speed of flight.

