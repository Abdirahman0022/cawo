





# **Airline Reservation System ___CRS___ Software Requirements Specs Computer Technology Essay**

 Airline reservations system (___CRS___) is a online software application
 used to reserve and retrieve information and perform orders related to
 air travel. Formerly designed and performed by airlines, ___CRS___(s) were
 later developed for the utilization of travel companies. Major ___CRS___ 
 operations that book and sell seat tickets for multiple airlines are
 known as Global distribution systems (___GDS___). Airlines have divested the
 majority of their direct holdings to dedicated ___GDS___ companies, who make
 their systems accessible to consumers through Internet gateways.
 Modern ___GDS___(es) are providing the services like booking hotel rooms and
 rental cars as well as airline tickets. In addition they provide usage
 of railway reservations in some markets although these are not always
 integrated with the main system.

-  #### **REQUIREMENTS DOCUMENT**

 -  First we could developing a Software Requirements Standards (___SRS___)
   document that speciﬁes what an air travel reservation system should
   and should not do. The ___SRS___ ﬁle is divided into ﬁve areas namely

- ### System Objectives

   Mainly we discuss the goals and objectives of the system categorized
   predicated on the point of view of the airline company , agent , third
   parties and the customer. They help in a top-down development of the
   ___SRS___.

- ## System Context

 This section clearly depicts the environment and restrictions of the
 ___CRS___ and the entities with which it interacts. It helps us observe how
 the system matches into the existing system of things. What the
 machine will do alone and what it desires other entities to do is
 plainly delineated.

- ## Functional Requirements

 These requirements areas the functions of the system - what it should
 do and what it will not. This may includes the most common
 requirements of the customer in addition to some additional

 features. like reserving tickets, rescheduling seat tickets etc.
 Flexibility from ambiguity and navigability were kept in mind while
 documents. A steady terminology has been implemented throughout and
 the terms are described in the appendix. The subsections follow a
 rational sequence that reﬂects real life. For example, a customer
 cannot reschedule a ticket unless he has bought one prior and cannot
 buy one unless he has checked out its supply.

- ## Non-functional Requirements

 These are quality requirements that stipulate the performance levels
 required of the machine for various types of activities. Numerical
 lower and upper limits arranged conditions on the response times,
 access times etc. of the system. Sometimes, tradeoffs are essential
 among various non- functional requirements.

- ## Future Requirements

 As technology bettering daily, users needs are also increasing. so we
 have to update our applications period to amount of time in order to
 gratify the customers. They are the speciﬁcations that are not
 provided for now in today\'s version of ___CRS___ but that could be
 integrated into future variations. Some of these need advanced
 technologies and interfaces with other systems. The

 ___CRS___ could be designed in future to enhance the existing features or
 add totally new ones

 The assumptions and limits of the ___CRS___ have been interspersed in the
 ___SRS___ to present the same in their proper context.

 # **REQUIREMENTS Evaluation DOCUMENT**

  ## System Objectives

  - 1.1. The Airline Booking System (___CRS___) is a software application to aid
    an airline with orders related to making solution reservations,
    which include obstructing, reserving, canceling and rescheduling
    tickets.

  - 1.2 From the viewpoint of the airline -

  - - 1.2.1 Minimize repeated work done by the system administrator and
 reservation clerks.

 1.2. 2 Maintain reliability among different access settings, e. g.
 by mobile, by web, at the information table and across different
 physical locations. The users should be essentially used through the
 same steps by the machine as each goes through in classic
 desk-reservation systems.

 1.2. 3 Maintain customer information in case of disaster, e. g.
 airline ﬂight cancellation due to bad weather. The proﬁle can even be
 utilized by the ﬂight company to trail user preferences and travel
 patterns to serve them better, plan routes, for better marketing and
 eﬃcient scheduling of ﬂights.

 1.2. 4 Maximize the revenue of the ﬂight company by various means:

 1.2. 4. 1 Increase awareness among regular travelers about various
 special deals and special discounts.

 1.2. 4. 2 Minimize the number of vacant seats over a ﬂight and boost
 ﬂight capacity utilization.

 1.2. 4. 3 Maintain the ability to adopt a adaptable pricing policy.
 The price tag on the seat tickets should be dynamically motivated
 based about how early, before the date of departure, the

 customer buys the ticket.

 1.3 A survey conducted by air travel companies shows that users of a
 preexisting reservation system would reply favorably to an ___CRS___ that
 satisﬁed or helped them meet the following aims:

 1.3. 1 Reduce effort and annoyance for travelers in arranging a
 vacation, especially by minimizing the search effort for the air
 travel they need to take.

 1.3. 2 Show all possible combinations and itineraries available for
 a pair of origin-destination

towns.

 1.3. 3 Reduce redundancy in the info required from the customers in
 order for them to buy tickets, create customer accounts etc.

 1.3. 4 Check the validity of suggestions data and present a feedback
 to an individual in case of mistakes or inconsistency.

 1.3. 5 Provide adaptable access modes to users - internet,
 telephone, PDA.

 1.3. 6 Protect customers\' privateness concerns.

1.3.7 Make it easy for travelers to check on the ticket position or
     make changes with their trip.

2. ## System Context

2.1 The ___CRS___ will provide the next types of easy-to-use, interactive,
 and intuitive visual and telephonic interfaces.

    2.1. 1 The ___CRS___ provides an easy-to-use, intuitive Graphical
 INTERFACE (GUI) within the Clerk/Administrator\'s working desktop
 environment.

 2.1. 2 The ___CRS___ will also provide an interactive GUI, on the World
 Wide Web for the overall customers.

 The above two ___CRS___ interfaces shall help provide the pursuing
 functionalities to the users - access to the ___CRS___ to check on the ﬂight
 program, availability of seating, ticket price and block, reserve,

 cancel, and reschedule tickets.

 The ___CRS___ will also provide an easy-to-use, simple telephonic interface,
 which can be accessed by the clients through phone or mobile phone
 from everywhere. This program shall provide gain access to, only to
 the next functionalities, namely, check ﬂight program and check
 solution position including any change in the journey timings. The
 eﬃciency available through this telephonic

 program is bound because of security constraints.

2.  2 The system and its environment and the relationships between them
    are depicted in the diagram below.

 DB-Reservations

 Flight Schedule Database Customer

 Via Web DB-User

 DB-Schedule INTERFACE

 \'CW\'

 DB-Geography ___CRS___ software

 INTERFACE \'Cp\'

 Customer Via Phone

 ![](media/image1.png)INTERFACE \'A\'

 Administrator

 The shut down boundary above plainly delineates the machine and the
 environment. The diagram shows the connections between the ___CRS___ 
 software and the directories inside the machine. A

 couple of three databases internal to the machine and that your system
 preserves. DB-user is the database containing all the personal
 information of the registered users of the ___CRS___. This can be updated by
 the user by logging in to the system. Information from this database
 is used during

 transactions like charging the bank card etc. DB-schedule is a copy of
 the airline ﬂight schedule databases. The latter is out there
 independently and it is updated by way of a airfare scheduler system
 which is out of opportunity of the ___CRS___ . DB-schedule is kept up to date
 with the latest

 status of the journey schedule databases whenever you can ﬁnd any
 change in the second option. For example, if a ﬂight has been put into
 the schedule between two metropolitan areas on

 Tuesdays, DB-schedule gets kept up to date with this change through a
 process with which we are not concerned. It is external to the system
 and has gone out of the opportunity of the ___SRS___. DB- schedule also
 contains the base prices of tickets for various trip ﬁgures.
 DB-reservations are a

 repository containing information about the number of car seats
 available on each school on

 different plane tickets. It offers provision for marking how many of
 the reserved seating have been obstructed however, not yet bought.
 DB-reservations should revise itself using DB-schedule, for

 example, if a fresh ﬂight is added. DB-geography is a database, which
 includes information about the locations and cities serviced by the
 ﬂight. The length between all towns and cities is within a

 matrix form. You will ﬁnd three interfaces, one for the administrator,
 one for the customer via web and another for the client via telephone.
 The administrator can upgrade DB-schedule with any

 changes in the bottom prices of airfare tickets. The system uses a
 charges algorithm and

 dynamically decides the real price from this base price with regards
 to the date of reservation vis- - vis date of departure. The client
 interfaces (web and telephone) allow multiple functions that happen to
 be described in the next section - section 3.

# Functional Requirements

 User Accounts

 Registration and creation of end user proﬁle

 Checking Availability

 Making Reservations/Blocking/Conﬁrmation

 ![](media/image1.png)Conﬁrm Ticket Reschedule Ticket Cancellation
 Update Proﬁle

 View Ticket Status Query Trip Details

 Telephone access

# User Accounts

 The passenger, who will henceforth be called the \'individual\', will
 be presented with 3 selections by the reservation system, as the ﬁrst
 rung on the ladder in the connection between them. A end user can
 choose one of these and his choice would be governed by whether he\'s
 a visitor or a

 documented end user and whether he needs to check on the availability
 of seat tickets or also stop/buy them. The terms \'registered
 consumer\' and \'visitor\' are detailed below.

 A user who may have journeyed by the ﬂight earlier would have been
 given a consumer id and a security password. He would have his
 personal information stored in the repository referred

 preceding as \'DB-user\'. This \'personal information\' would be
 henceforth known as \'account\'. Such a

 user with a account in DB-user will be called a \'registered
 customer\'. A documented user will be able to check the availability
 of tickets as well as block/buy a ticket by logging into the system.

 A new end user, on the other palm, would either have to

 register himself with the machine by providing personal information or
 log in to the system as a visitor.

 In case of \'a\', the new consumer becomes a recorded user. In case of
 \'b\', the new consumer would stay a guest.

 A guest can only check the availability of seat tickets and cannot
 stop or buy tickets.

 But a signed up customer can also become a guest if he only wishes to
 check on the availability of tickets. \'Supply of seat tickets\'
 always identiﬁes viewing the trip program for given days and nights,
 the price tag on seat tickets and any discount offers. The machine
 shall present an individual with a choice to exit from the machine at
 any time during the following processes.

# ![](media/image1.png)Registration and creation of user proﬁle

 The system shall require a user to register, in order to handle any
 transactions with it aside from

 checking the option of tickets. It\'ll ask an individual for the
 following information leastwise - a user id, a security password, ﬁrst
 name, last name, address, contact number, email address, gender, age,
 preferred mastercard number. The system will automatically create a
 \'sky miles\' ﬁeld and initialize it to zero in the user\'s proﬁle.

# Checking Availability

 After logging in a user (the registered customer or a guest), the
 system shall require him to enter in the following details - source
 city and destination city. \"City\' is a common term and identiﬁes a
 city or town as the case may be. The origin and destination
 metropolitan areas would be moved into as text. The machine shall now
 make reference to the ﬂight schedule database, known as \'DB-

 geography\' prior, and check when there is any ambiguity with the
 brands of the metropolitan areas. In case there are deﬁnitely more
 than two locations with same name as entered by an individual, the
 machine shall list all of them (with more qualiﬁcations) and have the
 user to choose one of them. In case, either the foundation or
 destination metropolitan areas are not stated in DB-

 geography to be straight serviced by the air travel, the machine shall
 suggest the nearest city to which service can be acquired, like the
 distance of the destination city from this nearest city.

 After the foundation and destination cities are ascertained, the
 system shall now access the ﬂight plan database, known as
 \'DB-schedule\', and checks if there is a direct functional service
 between the two cities. If not, the machine shall suggest possible
 routes and transfer points using a \'option selection algorithm\'. An
 individual shall now be presented with a choice of either selecting
 one of the routes. In case he chooses a route, the system shall
 complete the intermediate stop over tips and build a multiple trip
 itinerary for an individual.

 The system shall now ask the user to enter the next details -
 category, one-way or round trip, departure day and the number of adult
 travellers, children and senior

 citizens.

 \'Class\' refers to business course/ﬁrst school/club
 school/smoking/non smoking. This choice shall be made by the user
 through a drop down menu indicating all the possible mixtures of
 choices.

 One-way/round trip shall be the drop down menu or a check package
 selection. \'Departure time frame\' refers to either a sole date or a
 variety of dates, came into by having a calendar-like menu.

 This menu shall not show dates before or those schedules that are too
 ahead in the future(as

 ![](media/image2.png){width="0.26516404199475063in"
 height="0.14731299212598425in"}determined by the airline insurance
 policy). In the event, the trip is a round trip, the machine shall
 also ask the user to type in the departure day on the go back trip.
 Having used all the above source from an individual, the system bank
 checks for any phony entries like the departure time frame on the
 return trip being earlier than the departure time on the onward trip.
 In case of incompatibility, the machine shall display the right error
 message and prompt the user to enter the info correctly.

 Having considered all of the information, the machine shall now access
 the ﬂight schedule

 databases \'DB-schedule\' and inquiries it using the insight provided
 by an individual. The system questions the reservation repository
 \'DB-reservations\' to check on which of the plane tickets on the
 routine have seating available. The system displays the results the
 right form (a tabular form) with the following information depicted -
 for every ﬂight number - the air travel number departure time

 in origin city, introduction time in destination city, the period of
 the journey (taking into account the possibility of an change of your
 time zone) and the amount of seats on that airfare.

 There can be several plane tickets between two towns and all of them
 will be outlined for this date that the user wants to depart from the
 foundation City. In the event, an individual has entered a variety of
 dates, the machine shall display all the plane tickets for all those
 dates in the range.

 If an individual has requested a circular trip, the system shall
 display two desks - one for the

 onward trip and one for the come back trip. There will be a check ﬁeld
 in front of each line in the stand representing a trip with available
 chairs.

 The user is now asked to check on one of the boxes reﬂecting a
 selection of a ﬂight number and time. In case there is a spherical
 trip, an individual is asked to check one container each in both
 tables.

 The system shall now display the price of the solution for the trip.
 This will be the sum of the costs for all the customers of the travel
 party being symbolized by an individual.

 The system shall also list any guidelines about the cancellation of
 tickets - what percentage of the price will be refunded within what
 time frame ranges. This will likely be displayed as a table.

# Making Reservations/Preventing/Conﬁrmation

 After having considered an individual through the, Checking
 Availability, The system will now ask an individual if he wishes to
 stop/buy the ticket. If yes, and

 if the user is a guest, he will have to ﬁrst register and become a
 registered end user and then log onto the system.

 If an individual is already a registered consumer, and if he has
 logged on already, he is able to block/buy the solution, but if he has
 been acting as a visitor, he\'ll have to sign on.

 Having guaranteed that an individual is logged on validly according
 the system compares the departure date with the machine date. If the
 departure date falls within 2 weeks of the system

 ![](media/image1.png)date, the system informs an individual that he
 does not have any option to obstruct the solution and asks him if he
 would prefer to buy it.

 If the difference between the departure time frame and system
 particular date is more than 2

 weeks, the machine asks the user if he\'d like to prevent or choose
 the ticket. The machine informs an individual that they can block the
 solution free now. In addition, it informs him that if he

 chooses to block the solution, he should make your ﬁnal decision
 before 2 weeks of the departure time frame. The machine shall send a
 contact to an individual, 3 weeks before the departure day as a
 reminder, in case he determines to stop the ticket now.

 Having used the insight from an individual, the system shall now
 proceed to update the reservation database DB-reservation. It\'ll
 decrement the number of available chairs on the particular ﬂight for
 the particular class by the number of travelers being represented by
 an individual.

 In case of the blocking, the system makes an email than it in the data
 source - to be used if an individual doesn\'t arrive before 2 weeks of
 the departure time frame. It generates a blocking quantity and
 displays it for an individual to notice down.

 In case the user buys the ticket, the system accesses his account and
 charges the price of the solution to his credit card number. It
 concurrently generates a conﬁrmation number and exhibits it to an
 individual for him to note down. The solution has been reserved.

 It provides the mileage of the trip (accounting for the number of
 travelers) to the skymiles in his account.

# Conﬁrm Ticket

 A user who has earlier clogged a ticket after going right through the
 prior steps necessary to either conﬁrm the solution before fourteen
 days of the departure time frame or the ticket stands terminated.

 To let the user conﬁrm a ticket, the system shall ﬁrst log him on and
 have for his obstructing amount. Then it accesses DB-reservation and
 cleans away the check symbol, which so far represented a blocked seat.
 The chair is now conﬁrmed and reserved for an individual.

 The system accesses DB-user and charges the price tag on the ticket to
 the credit card number of an individual. It simultaneously produces a
 conﬁrmation quantity and displays it for an individual to notice down.
 The ticket has been reserved.

 It gives the mileage of the trip (accounting for the number of
 travelers) to the skymiles in his account.

# ![](media/image1.png)Reschedule Ticket

 The system shall present an individual with an option to re-schedule
 his travel party\'s trip. In order to do this, the system ﬁrst logs on
 an individual and requests his conﬁrmation amount. It will not allow a
 consumer to reschedule a blocked solution but only a established
 ticket. Making use of this, it queries DB-reservation and presents the
 facts of the visit to the user, including however, not limited to
 origin city, destination city, night out of departure and day of
 introduction (in case the trip is a rounded trip).

 The system shall now ask an individual to select new dates from the
 calendar-menu.

 In case, there are no available tickets for the times entered, it
 displays a suitable concept informing him that rescheduling to that
 date is extremely hard.

 In circumstance there are tickets available, the system asks an
 individual to select the ﬂight quantity for the trip (another for the
 come back trip if the trip is a rounded trip) and proceeds to update
 the database.

 The system accesses DB-reservation and decrements the amount of
 available seats on the ﬂight(s) by the amount of people in the user\'s
 travel party. It then increments the access for the

 prior journey by the same quantity to reﬂect an increase in the
 available seats on it therefore of the rescheduling.

 The system now checks when there is any difference in the costs of the
 tickets. If so, it accesses DB-user and charges or credits the credit
 card as the truth may be. The system generates a fresh conﬁrmation
 number and displays it to the user.

# Cancellation

 The system shall also give the user an option to cancel a conﬁrmed
 ticket or a clogged ticket.

 The latter circumstance is simpler and you will be dealt with ﬁrst -
 the machine shall ﬁrst log on the user and submission the blocking
 number. Then it accesses DB-reservation and revisions it by
 incrementing the amount of available chairs by the number of folks in
 the user\'s travel party.

 In the past case, i. e. , for a conﬁrmed ticket, it asks for the
 conﬁrmation amount and accesses DB- reservation and presents the
 details of the trip.

 It then lists the relevant guidelines for cancellation of tickets and
 depending on the system

 particular date and the departure particular date, it exhibits the %
 of the total amount that might be refunded if an individual cancels
 the ticket.

 ![](media/image1.png)After the user cancels the solution, the system
 produces a cancellation number and shows it for an individual to
 notice down. It accesses DB-reservation and updates it by incrementing
 the amount of available car seats on that airfare by the number of
 travelers in the user\'s get together. It accesses DB-user and credits
 the refund amount to his credit-based card number. The machine then
 deducts the mileage of the trip (taking into account the amount of
 travelers in his party) from the sky a long way in his proﬁle.

# Update Proﬁle

 The system shall permit an individual to revise his proﬁle at any
 time. Changes can be produced in ﬁelds including but not limited to
 addresses, contact number and preferred credit-based card number.

# View Solution Status

 The system shall allow a consumer to view all information about his
 trip. After logging him on, it asks for his blocking amount or his
 veriﬁcation amount. It accesses DB-reservation and retrieves the
 details of the trip and presents those to the user in a convenient
 format, including any last second changes to the journey timings etc.
 Such changes will be outlined.

# Query Airfare Details

 The system shall allow any end user (documented or non listed) to gain
 access to the details about the arrival and departure times of a
 airline ﬂight by requesting the user to type the ﬂight quantity and
 date. The machine accesses DB-schedule and presents the time of
 arrival and

 departure.

# Telephone access

 The system shall be accessible through a touch-tone telephone. The
 telephonic interface shall, at the least, provide the customer with
 the facility to check option of seat tickets and query ﬂight

 details. The machine shall walk the client exactly through steps 3. 3
 and 3. 9 respectively but by using a telephonic program.

# Non-functional Requirements Performance

 ![](media/image1.png)Response time of the Flight Reservation System
 should be less than 2 second almost all of enough time. Response time
 refers to the waiting time as the system accesses, concerns and
 retrieves the information from the databases (DB-user, DB-schedule
 etc) (A local copy of airline ﬂight schedule data source is taken care
 of as DB-schedule to reduce this access time)

 ___CRS___ will be able to deal with at least 1000 transactions/inquiries per
 second.

 ___CRS___ shall show no obvious deterioration in response time as the number
 of users or trip program data increases

# Reliability

 ___CRS___ shall be available 24 hours a day, 7 days a week

 ___CRS___ shall always provide real-time information about ﬂight
 availability information.

 ___CRS___ will be robust enough to have a high degree of fault tolerance.
 For instance, if an individual enters a negative number of people or a
 value too large, the system shouldn\'t crash and shall identify the
 invalid suggestions and produce a suitable error meaning.

 ___CRS___ will be able to recover from hardware failures, ability failures
 and other natural catastrophes and rollback the databases to their
 latest valid status.

# Usability

 ___CRS___ shall provide a easy-to-use graphical software similar to other
 existing reservation system so that the users do not have to learn a
 new style of conversation.

 The web interface should be intuitive and easily navigable Users can
 understand the menu and options provided by ___CRS___.

 Any notiﬁcation or problem messages generated by ___CRS___ shall be clear,
 succinct, polite and free from jargon.

# Integrity

 Only system administer gets the right to change system variables, such
 as pricing policy etc. The machine should be secure and must use
 encryption to protect the databases.

 Users have to be authenticated before having access to any personal
 data.

# Interoperability

 ![](media/image1.png)___CRS___ shall reduce the effort necessary to couple
 it to some other system, such as airfare schedule databases system.

# Future Requirements

 Support for holding out list functionality

 ___CRS___ shall be made more adaptable in ticket booking handling, and shall
 agree to hanging around list for reservation. The hanging around list
 handling capacity for ___CRS___ will be made more advanced, by allowing it
 to send demands to the Trip Scheduler to schedule extra ﬂights, with

 respect to the demand in a particular corridor, and providing the wait
 around listed travellers with a fresh ﬂight.

 The telephonic software of the ___CRS___ will be improved to aid more
 functionality like allowing the customers to cancel a solution etc. ,
 by including security actions.

 ___CRS___ will be made more active and beneﬁcial to the users by enabling it
 to send instant messages to the passengers, of a cancelled or
 rescheduled journey, through email, mobile, Fax etc. , informing them
 about the change, and providing them with other feasible alternatives.

 Information about the type of meals offered in a air travel and the
 sort of

 entertainment offered over a ﬂight should be integrated in to the
 system. Provide service integration with vehicle rental businesses and
 hotel chains.

 Interface for the travel agents shall be provided in the future
 variants with additional features like informing them of any option of
 seats over a ﬂight that was earlier booked to capacity.

 Choices like aisle or windows seats shall be provided to the users.

 The ___CRS___ shall be able to cope with the problem where journey services
 can be found to multiple airports in a single city.

 [Tweet](https://twitter.com/intent/tweet?hashtags=Studybay&original_referer=https%3A%2F%2Fstudybayhelp.co.uk%2F&ref_src=twsrc%5Etfw%7Ctwcamp%5Ebuttonembed%7Ctwterm%5Eshare%7Ctwgr%5E&text=Airline%20Booking%20System%20Ars%20Software%20Requirements%20Requirements%20Computer%20Knowledge%20Essay&url=https%3A%2F%2Fstudybayhelp.co.uk%2Fblog%2Fairline-booking-system-ars-software-requirements%2F)
 ![](media/image3.png){width="0.12499890638670166in"
 height="0.12499890638670166in"}[**Share**
 0](https://www.facebook.com/sharer/sharer.php?kid_directed_site=0&sdk=joey&u=https%3A%2F%2Fstudybayhelp.co.uk%2Fblog%2Fairline-booking-system-ars-software-requirements%2F&display=popup&ref=plugin&src=share_button)

 ![](media/image4.png)[Airasias BUSINESS DESIGN: Low Cost
 Carrier](https://studybayhelp.co.uk/blog/airasias-business-design-low-cost-carrier/)
 [Airplanes And Aircraft Executive
 Essay](https://studybayhelp.co.uk/blog/airplanes-and-aircraft-executive-essay/)

 **Latest posts**

 Read more informative topics on our blog

![](media/image1.png)

 ![](media/image1.png)**WE ACCEPT**

 **MONEY BACK GUARANTEE**

**100% QUALITY**

 **Essay Sample**

 [Tips on how to write a research
 proposal](https://studybayhelp.co.uk/advice-on-how-to-write-a-research-proposal/)

 [Epistemology in research -- the fountain of business
 wisdom](https://studybayhelp.co.uk/epistemology-in-research--the-fountain-of-business-wisdom/)

 [How to write a leadership in nursing
 essay](https://studybayhelp.co.uk/help-with-writing-a-leadership-in-nursing-essay/)

 [How to do research
 approach](https://studybayhelp.co.uk/how-to-do-research-approach/)

 [Writing an environment
 essay](https://studybayhelp.co.uk/how-to-write-a-convincing-environment-essay/)

 [How to write a mental health essay
 easily](https://studybayhelp.co.uk/how-to-write-a-mental-health-essay/)

 [How to write a report cover
 page](https://studybayhelp.co.uk/how-to-write-a-report-cover-page/)

![](media/image1.png)

 [Plan your dissertation questionnaire very
 carefully](https://studybayhelp.co.uk/plan-your-dissertation-questionnaire-very-carefully/)

 [What are good primary research
 methods?](https://studybayhelp.co.uk/primary-research-methods-that-work-for/)

 [The journey an online essay writer takes with an
 essay](https://studybayhelp.co.uk/the-journey-an-online-essay-writer-takes-with-an-essay/)

 [Why you need an oﬃce manager cover
 letter](https://studybayhelp.co.uk/write-an-office-manager-cover-letter/)

 [Writing a photographer cover
 letter](https://studybayhelp.co.uk/writing-a-photographer-cover-letter/)

 [Writing economics
 articles](https://studybayhelp.co.uk/writing-economics-articles/)

## SUPPORT

 ![](media/image5.png){width="0.1498840769903762in"
 height="0.14991141732283464in"}1-855-407-77-28

 ![](media/image6.png){width="0.15625in"
 height="0.10907152230971129in"}<support@studybayhelp.co.uk [About
 us](https://studybayhelp.co.uk/info/about/)

 [FAQ for students](https://studybayhelp.co.uk/info/help/2/)

## MAIN

 [FAQ for writers](https://studybayhelp.co.uk/info/help/3/)

 [Place an order](https://studybayhelp.co.uk/order/) [Authors
 Rating](https://studybayhelp.co.uk/authors/) [Latest
 orders](https://studybayhelp.co.uk/latest-orders/)
 [Rules](https://studybayhelp.co.uk/info/rules/)

 [Privacy Policy](https://studybayhelp.co.uk/info/privacy/) [Become a
 writer](https://studybayhelp.co.uk/essay-writing-jobs/)
 [Blog](https://studybayhelp.co.uk/blog/)

 ![](media/image7.png){width="1.6580238407699037in"
 height="0.559582239720035in"}

 ![](media/image1.png)We accept:

 © 2011-2021 Studybay all rights reserved
