Use tass; 

-- Question 1
SELECT CustomerID, FirstName, Lastname 
FROM customer 
WHERE Country = 'Begonia'
ORDER BY CustomerID ASC;

-- Question 2
SELECT DISTINCT FlightNumber
FROM booking
WHERE MONTH(BookingDate) = 11 and MONTH(DepartureDateTime) = 1 AND YEAR(DepartureDateTime) = 2023;

-- Question 3
SELECT FromCurrency, ToCurrency, AVG(ExchangeRate) AS AverageExchangeRate
FROM `exchange`
WHERE FromCurrency = 'BegoniaDollar'
GROUP BY FromCurrency, ToCurrency
HAVING AverageExchangeRate > 1
ORDER BY AverageExchangeRate ASC;

-- Question 4
SELECT FlightNumber, COUNT(FlightNumber) AS NumberOfFlights 
FROM flightavailability
WHERE (OriginAirportCode = 'AP02' AND DestinationAirportCode = 'AP09')
OR (OriginAirportCode = 'AP09' AND DestinationAirportCode = 'AP02')
GROUP BY FlightNumber;

-- Question 5
SELECT AirlineCode, COUNT(*) as NumberOfFlightNumbers
FROM flight
GROUP BY AirlineCode;

-- Question 6
SELECT a.AirlineName, f.BusinessClassIndicator, COUNT(*) as NumberOfFlightNumbers
FROM airline a
LEFT JOIN flight f ON a.AirlineCode = f.AirlineCode
WHERE a.AirlineName LIKE '%u%'
GROUP BY a.AirlineName,f.BusinessClassIndicator;

-- Question 7
SELECT OfficeID, COUNT(*) AS NumberOfBookings
FROM booking 
GROUP BY OfficeID
ORDER BY NumberOfBookings DESC
LIMIT 3;

-- Question 8
SELECT FlightNumber 
FROM flightavailability
GROUP BY FlightNumber
ORDER BY AVG((BookedBusinessSeats + BookedEconomySeats) / (TotalBusinessSeats + TotalEconomySeats)) ASC
LIMIT 5;

-- Question 9
SELECT AVG(PaymentCount) as AvgNumberOfPayments
FROM (
SELECT COUNT(*) AS PaymentCount
FROM booking b
INNER JOIN payment p ON b.BookingID = p.BookingID
WHERE b.StatusID = 'ST01'
GROUP BY b.BookingID
) AS PaymentCounts;

-- Question 10
SELECT CONCAT(ROUND(COUNT(*) / (SELECT COUNT(*) FROM customer) * 100, 2), '%') AS ForeignerPercent
FROM customer c
WHERE c.Country != c.Nationality;


-- Question 11
SELECT b.BookingID 
FROM booking b
WHERE b.BookingDate BETWEEN '2022-10-16' AND '2022-11-15'
AND b.BookingID NOT IN (SELECT p.BookingID FROM payment p);

-- Question 12
SELECT c.CustomerID, c.FirstName, c.LastName, MAX(p.PaymentDate) AS LatestPayment
FROM customer c
LEFT JOIN payment p ON c.CustomerID = p.CustomerID
WHERE c.Nationality = 'Begonia'
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- Question 13
SELECT c.CustomerID, COUNT(DISTINCT b.BookingID) as NumberOfBookings, 
COUNT(DISTINCT e.Email) AS NumberOfEmails, COUNT(DISTINCT CONCAT(p.CountryCode, p.LocalNumber)) AS NumberOfPhones
FROM customer c
LEFT JOIN booking b ON c.CustomerID = b.CustomerID
LEFT JOIN customeremail e ON c.CustomerID = e.CustomerID
LEFT JOIN customerphone p ON c.CustomerID = p.CustomerID
GROUP BY c.CustomerID
ORDER BY c.CustomerID ASC
LIMIT 5;

-- Question 14
SELECT f.FlightNumber, STD(b.flightPrice) AS StdFlightPrice, AVG(f.TotalBusinessSeats - f.BookedBusinessSeats) AS AvgAvailableBusinessSeats, AVG(f.TotalEconomySeats - f.BookedEconomySeats) AS AvgAvailableEconomySeats
FROM flightavailability f
LEFT JOIN booking b ON f.FlightNumber = b.FlightNumber
GROUP BY f.FlightNumber
ORDER BY StdFlightPrice DESC
LIMIT 5;

-- Question 15
SELECT c.CustomerID, CONCAT(FirstName, ' ', LastName) AS FullName, CONCAT(p.CountryCode, '-', p.AreaCode, '-', p.LocalNumber) AS PhoneNo
FROM customer c
INNER JOIN customerphone p ON c.CustomerID = p.CustomerID
WHERE c.CustomerID NOT IN (SELECT CustomerID FROM customeremail) 
AND (SELECT COUNT(CustomerID) FROM customerphone WHERE CustomerID = c.CustomerID) = 1
ORDER BY c.CustomerID ASC;

-- Question 16
SELECT c.CountryName, ct.CityName, SUM(b.TotalPrice) AS TotalSales
FROM booking b
INNER JOIN bookingoffice bo ON b.OfficeID = bo.OfficeID
INNER JOIN city ct ON bo.CityCode = ct.CityCode
INNER JOIN country c ON ct.CountryCode = c.CountryCode
WHERE b.StatusID NOT IN (SELECT StatusID FROM `status` WHERE `Status` = 'Canceled')
GROUP BY c.CountryName, ct.CityName
HAVING SUM(b.TotalPrice) = (
    SELECT MAX(total_sales)
    FROM (
        SELECT c.CountryName, ct.CityName, SUM(b.TotalPrice) AS total_sales
        FROM booking b
        INNER JOIN bookingoffice bo ON b.OfficeID = bo.OfficeID
        INNER JOIN city ct ON bo.CityCode = ct.CityCode
        INNER JOIN country c ON ct.CountryCode = c.CountryCode
        WHERE b.StatusID NOT IN (SELECT StatusID FROM `status` WHERE `Status` = 'Canceled')
        GROUP BY c.CountryName, ct.CityName
    ) AS SalesByCity
    WHERE SalesByCity.CountryName = c.CountryName
)
ORDER BY c.CountryName ASC;

-- Question 17
SELECT b.BookingID, fa.FlightNumber, fa.ArrivalDateTime, fa.DepartureDateTime, a1.CityCode AS OriginCityCode, a2.CityCode AS DestinationCityCode
FROM booking b
INNER JOIN flightavailability fa ON b.FlightNumber = fa.FlightNumber AND b.ArrivalDateTime = fa.ArrivalDateTime AND b.DepartureDateTime = fa.DepartureDateTime
INNER JOIN `status` s ON b.StatusID = s.StatusID
INNER JOIN airport a1 ON fa.OriginAirportCode = a1.AirportCode
INNER JOIN airport a2 ON fa.DestinationAirportCode = a2.AirportCode
WHERE s.`Status` = 'Canceled'
ORDER BY b.FlightPrice DESC
LIMIT 5;

-- Question 18
SELECT COUNT(DISTINCT b.FlightNumber) AS NumberOfPotentialAffected
FROM booking b
INNER JOIN flightavailability fa ON b.FlightNumber = fa.FlightNumber
INNER JOIN airport a1 ON fa.OriginAirportCode = a1.AirportCode
INNER JOIN airport a2 ON fa.DestinationAirportCode = a2.AirportCode
INNER JOIN city ci1 ON a1.CityCode = ci1.CityCode
INNER JOIN city ci2 ON a2.CityCode = ci2.CityCode
INNER JOIN currency cu1 ON ci1.CountryCode = cu1.CountryCode
INNER JOIN currency cu2 ON ci2.CountryCode = cu2.CountryCode
WHERE (cu1.Currency = 'CarnationDollar' OR cu2.Currency = 'CarnationDollar')
  AND b.FlightNumber IN (
    SELECT b2.FlightNumber
    FROM booking b2
    INNER JOIN payment p ON b2.BookingID = p.BookingID
    INNER JOIN customer c ON p.CustomerID = c.CustomerID
    INNER JOIN country co ON c.Country = co.CountryName
    INNER JOIN currency cu ON co.CountryCode = cu.CountryCode
    WHERE cu.Currency = 'RoseDollar'
  );

-- Question 19
SELECT AirportCode, DENSE_RANK() OVER (ORDER BY SUM(TotalFlights) DESC) AS `Rank`
FROM (
    SELECT OriginAirportCode AS AirportCode, COUNT(*) AS TotalFlights
    FROM flightavailability
    WHERE WEEKDAY(DepartureDateTime) BETWEEN 0 AND 4
    GROUP BY OriginAirportCode
    UNION
    SELECT DestinationAirportCode AS AirportCode, COUNT(*) AS TotalFlights
    FROM flightavailability
    WHERE WEEKDAY(ArrivalDateTime) BETWEEN 0 AND 4
    GROUP BY DestinationAirportCode
) AS AirportFlights
GROUP BY AirportCode
ORDER BY `Rank`;