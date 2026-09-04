CREATE DATABASE RACEDAY;

USE RACEDAY;

-- 1. USERS
CREATE TABLE Users
(
    User_ID INT IDENTITY(1,1) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    SURNAME VARCHAR(50) NOT NULL,
    
    Role VARCHAR(20) NOT NULL,
   CONSTRAINT CK_Users_Role
    CHECK (Role IN ('Organiser', 'Participant'))
);

--  EVENTS
CREATE TABLE Events
(
    Event_ID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    Description VARCHAR(500),
    User_ID INT NOT NULL,
    CONSTRAINT FK_Events_Users
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
);
select*from Events;

-- databaser CATEGORIES
CREATE TABLE Categories
(
    Category_ID INT IDENTITY(1,1) PRIMARY KEY,
    Event_ID INT NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Categories_Events
        FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),
 CONSTRAINT UQ_Categories_Event_Category
        UNIQUE (Event_ID, CategoryName)
);

select*from Categories;

-- 4. ENROLMENTS
CREATE TABLE Enrolments
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    Category_ID INT NOT NULL,
    EnrolmentDate DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Enrolments_Participant
        FOREIGN KEY (UserID) REFERENCES Users(User_ID),

    CONSTRAINT FK_Enrolments_Category
        FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID),

    CONSTRAINT UQ_Enrolment
        UNIQUE (UserID, Category_ID)
);
SELECT*FROM Enrolments;

--  RESULTS
CREATE TABLE Results
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    FinishTime TIME NOT NULL,
    Position INT,
    
CONSTRAINT FK_Results_Enrolment
        FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID),

CONSTRAINT CK_Results_Position
        CHECK (Position IS NULL OR Position > 0)
);

SELECT*FROM Results;

--  ROUTE
CREATE TABLE Route
(
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    Event_ID INT NOT NULL UNIQUE,
    DistanceKM DECIMAL(6,2) NOT NULL,
    

    CONSTRAINT FK_Route_Event
        FOREIGN KEY (Event_ID) REFERENCES Events(Event_ID),

    CONSTRAINT CK_Route_Distance
        CHECK (DistanceKM > 0)
);
SELECT*FROM Route;

INSERT INTO Users
(NAME, SURNAME, Role)
VALUES
('Thabo', 'khoza',  'Organiser'),
('Lerato', 'Tshivula', 'Organiser'),
('Sipho', 'mavone', 'Participant'),
('Amahle', 'mambana', 'Participant');

select*from Users;

INSERT INTO Events
(name, Description, User_ID)
VALUES
('Johannesburg City Run',
 'A road running event through Johannesburg.',1),

('Pretoria Spring Cycle',
 'A community cycling event around Pretoria.',2),

('Soweto Community Marathon',
 'A road running and walking event in Soweto.',3);

 SELECT*FROM Events;

 INSERT INTO Categories
(Event_ID, CategoryName )
VALUES
(1, '5 KM Fun Run'),
(1, '10 KM Road Race'),
(1, '21 KM Half Marathon'),

(2, '20 KM Cycle'),
(2, '40 KM Cycle'),
(2, '80 KM Cycle'),

(3, '5 KM Walk'),
(3, '10 KM Run'),
(3, '42.20 KM Marathon');
SELECT*FROM Categories;

INSERT INTO Route
(Event_ID,  DistanceKM )
VALUES
(1, 21.10),
(2,  80.00),
(3, 42.20);
SELECT*FROM Route;