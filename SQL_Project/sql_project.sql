/*

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.
*/

/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */
SELECT * 
FROM `Facilities` 
WHERE `membercost` !=0

/* Q2: How many facilities do not charge a fee to members? */
SELECT COUNT(`membercost`)
FROM `Facilities` 
WHERE `membercost` =0

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT  `facid` ,  `name` ,  `membercost` ,  `monthlymaintenance` , 
CASE WHEN `membercost` < (`monthlymaintenance` *20 /100) THEN  'less_than20%'
ELSE  'over19%' END AS  'fee_rate'
FROM  `Facilities`

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */
SELECT *
FROM Facilities
WHERE facid
IN ( 1, 5 )

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT `name` , `monthlymaintenance` ,
CASE WHEN `monthlymaintenance` >100
THEN 'expensive'
WHEN `monthlymaintenance` <=100
THEN 'cheap'
ELSE NULL
END AS "Label"
FROM Facilities
ORDER BY Label

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */
SELECT `firstname` , `surname` , `joindate`
FROM `Members`
WHERE `memid` =36

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
SELECT CONCAT (`firstname` , `surname` ,'-', `name`) AS q7
FROM `Members`
INNER JOIN `Bookings` ON Members.memid = Bookings.memid
INNER JOIN `Facilities` ON Bookings.facid = Facilities.facid
WHERE name LIKE "Tennis Court%"
ORDER BY `firstname`

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT CONCAT (`firstname` , `surname` ,'-', `name`) AS q8 , `guestcost` , `membercost` 
FROM `Members`
INNER JOIN  `Bookings` ON Members.memid = Bookings.memid
INNER JOIN `Facilities` ON Bookings.facid = Facilities.facid
WHERE `starttime` LIKE "2012-09-14%" 
AND (membercost>30 OR guestcost>30)
ORDER BY membercost,guestcost DESC
/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT CONCAT( `firstname` , `surname` , '-', `name` ) AS q8, `guestcost` , `membercost`
FROM `Members`
    INNER JOIN (SELECT starttime, name, guestcost, membercost, memid FROM `Bookings`
                INNER JOIN (SELECT * FROM `Facilities`)f ON Bookings.facid = f.facid
                WHERE `starttime` LIKE "2012-09-14%"
                AND (membercost >30 OR guestcost >30))bookings 
    ON Members.memid = bookings.memid
ORDER BY membercost, guestcost DESC
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT (`guestcost` +`membercost`+`initialoutlay`+`monthlymaintenance`) AS total_revenue, name
FROM `Facilities`
WHERE (`guestcost` +`membercost`+`initialoutlay`+`monthlymaintenance`) <1000
GROUP bY name
ORDER BY total_revenue
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     