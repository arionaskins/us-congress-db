#### Developers: Arion Askins, Marzena Hurtado, Ricardo Jonathan, Brian Navarro, & Kevin Zhao
<br>
  

## **Motivation**

The database chosen will contain data about US congressional members, and supplemental data about each member. Because there are two chambers of congress, we will include members from both chambers, House of Representatives and Senate. For each member in each chamber, we will incorporate attributes such as their political party, state, district, associated committees, and possibly demographic information. Additionally, we plan to include the most recent **≈**5 congressional sessions accounting for the past 20 years.

We chose this topic because we were aware that there would be a lot of data that could be retrieved to make the database possible. Because of this, it became easier for us to brainstorm potential tables to be incorporated. With the current state of our government, we thought that this would be a good resource for citizens to gather information about a congressman or search for their contact information.

## **Target Audience**

This database would be a resource regarding current and past representatives in the U.S. Congress and it could be useful for any citizen wanting to find out more about the legislative branch of government and who were his/her state representatives in each chamber. It would also be useful in finding out how to contact any representative about the concerning issue. 

## **Sample Data**

Our plan for obtaining data is to use data that is already provided through many different links. Since our project touches on the topic of the U.S government specifically, the spectrum of the U.S congress, there's a lot of available data that can be used for our database. This link, [https://www.house.gov/](https://www.house.gov/), has all the data needed about the House of Representatives, including data such as their names, phone numbers, political affiliation, state, committees, etc. Another source we plan to use to collect data for our database will come from this link, [https://www.senate.gov/index.htm](https://www.senate.gov/index.htm). This link provides data about the Senate that includes, names, states, etc. Our database will also include data about the US Chambers of Commerce CCC100 and this url provides all the data that our group will use for our database, [https://www.uschamber.com/chamber-of-commerce-committee-of-100](https://www.uschamber.com/chamber-of-commerce-committee-of-100). Data on the Lobbyists will come from this link, [http://www.opensecrets.org/federal-lobbying/top-lobbyists](http://www.opensecrets.org/federal-lobbying/top-lobbyists); we also plan to collect data from [https://projects.propublica.org/api-docs/congress-api/members/](https://projects.propublica.org/api-docs/congress-api/members/) as well.

## **Potential entities/tables with potential attributes/Columns**

Table 1: Political Party Table



*   Potential Attributes/Columns Could Include: 
    *    Party Id; primary key, int, auto increment
    *   Party Name; varchar(20)

Table 2: Members



*   Potential Attributes/Columns Could Include: 
    *   Member Id; primary key, int, auto increment
    *   First Name; varchar(20)
    *   Last Name; varchar(20)
    *   Party Name; varchar(20)
    *   State; varchar(2)
    *   City; varchar(20)
    *   District; int
    *   DOB; date
    *   Gender; varchar(20)
    *   In Office; ENUM (Yes or No)

Table: House of Representatives



*   Potential Attributes/Columns Could Include: 
    *   Id; primary key, int, auto increment
    *   Party Id; int
    *   First Name; varchar(20)
    *   Last Name; varchar(20)
    *   State; varchar(2)
    *   City; varchar(20)

Table : Senate



*   Potential Attributes/Columns Could Include: 
    *   Id; primary key, int, auto increment, Number will offset from where House Id has ended
    *   Party Id; int
    *   First Name; varchar(20)
    *   Last Name; varchar(20)
    *   State; varchar(2)
    *   City; varchar(20)

Table 4: House of Representatives Committees



*   Potential Attributes/Columns Could Include: 
    *   Committee Id; primary key
    *   Committee Name; varchar(20)
    *   Chair/Ranking Member; int or bool (0,1)
    *   First Name; varchar(20)
    *   Name; varchar(20)
    *   Party Id; int
    *   State; varchar(2)

Table 5: U.S Chambers of Commerce (CCC100)



*   Potential Attributes/Columns Could Include: 
    *   CCC100 Id; int, primary key, auto increment
    *   First Name; varchar(20)
    *   Last Name; varchar(20)

Table 6: Contact Info



*   Potential Attributes/Columns Could Include: 
    *   Id; int
    *   Party Id; int
    *   Phone Number; Varchar(20)
    *   Url; varchar(20)
    *   Mailing address; varchar(20)

Table 7: [miscellaneous] Bills



*   Potential Attributes/Columns Could Include: 
    *   Bill Id; primary key, int
    *   Bill Name; varchar(20)
    *   Date introduced; date
    *   Committee; foreign key, int 
    *   Bill description; varchar(200)

Table 7: Lobbyists



*   Potential Attributes/Columns Could Include: 
    *   Lobbyist Id; primary key, int
    *   First Name; varchar(20)
    *   Last Name; varchar(20)
    *   Door Profile; ENUM (Yes or No)
    *   Clients; int

**Entities/tables that’s not included in the database**

Our database is more focused on the legislative side of the U.S government which deals with the U.S congress. We do not plan to add data that relates to the other branches of government. This includes data pertaining to the executive branch or legislative branch. Tables we would not include would be data on Cabinet such as their names, contacts, state, etc. We will not have tables that have data on members of the supreme court or any other federal court.

**Possible question/answers for the database**



1. How many votes did a member have?
    1. This would return 2 columns from our database: the name of the individual and the number of votes (an aggregate number).
2. Who are my state’s senators and how can I contact them?
    2. This would return multiple columns. It would return two rows with their name, state, phone number, office location, and address.
3. Who are my state’s representatives and how can I contact them?
    3. Similar to question 2 however this would return more rows depending on which state you are looking for.
4. Who in the House of Representatives are in the Republican Party?
    4. This could return multiple columns that include their party id, name, maybe state as well.
5. Who are the individuals that are in the Agriculture subcommittee and are Democrat?
    5. This could return multiple columns and rows. Such as their chair/ranking member id, name, party id, committee id, etc.
6. Which committee passed/approved ‘(Insert Bill Name Here)’?
    6. This could return the committee id, bill id, name, names of individuals in that committee, etc.
7. What is the average age of the currently serving representatives in the Senate, House of Representatives, or both combined?
    7. The answer could be obtained as the average value(aggregate) of the difference between current system date and dates of birth for each representative.
8. Does the representative have a website, twitter, or youtube account where I could find out more about them?
    8. The answer would be a list of character values each of which would be the the link to any of these accounts.
9. Is there any background knowledge that can be provided regarding the representatives?
    9. This could return multiple columns and rows. Such as their first, middle, and last name, their date of birth (in the format of “month/date/year”, their age, and where they are from initially (before being elected into office). 
10. What is a gender breakdown for all representatives in the current Congressional session?
1. The answer would be two aggregate counts corresponding to each gender (male, female, or other). 
1. How many voting sessions did the representative miss?
    1. The answer to this question would be a value from one cell in a table for member profiles.
