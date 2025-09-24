CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Genre: No dependencies. Referenced by Books_Info.
CREATE TABLE Genre (
    Genre_ID INT PRIMARY KEY AUTO_INCREMENT,
    Genre_Name VARCHAR(50) NOT NULL
);

-- Publishers: No dependencies. Not referenced by other tables in this schema.
CREATE TABLE Publishers (
    Publisher_ID INT PRIMARY KEY AUTO_INCREMENT,
    Publisher_Name VARCHAR(100) NOT NULL,
    Contact_Info VARCHAR(100)
);

-- Books_Info: References Genre. Referenced by Items and Book_Authors.
CREATE TABLE Books_Info (
    Isbn VARCHAR(13) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Publication_Year INT,
    Genre_ID INT,
    Edition VARCHAR(20),
    Synopsis VARCHAR(200),
    FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID)
);

-- Authors: No dependencies. Referenced by Book_Authors.
CREATE TABLE Authors (
    Author_id INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20)
);

-- Items: References Books_Info. Referenced by Loans and Reservations.
CREATE TABLE Items (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    Isbn VARCHAR(13),
    Item_Status VARCHAR(20) NOT NULL,
    Shelf_Location VARCHAR(50) NOT NULL,
    Purchase_Date DATE NOT NULL,
    FOREIGN KEY (Isbn) REFERENCES Books_Info(Isbn)
);

-- Members: No dependencies. Referenced by Loans, Reservations, and Fines.
CREATE TABLE Members (
    MemberId INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone_Number VARCHAR(15),
    Membership_Start_Date DATE NOT NULL,
    Membership__Status VARCHAR(20) NOT NULL
);

-- Book_Authors: Junction table. References Books_Info and Authors (many-to-many relationship).
CREATE TABLE Book_Authors (
    Isbn VARCHAR(13),
    Author_id INT,
    FOREIGN KEY (Isbn) REFERENCES Books_Info(Isbn),
    FOREIGN KEY (Author_id) REFERENCES Authors(Author_id)
);

-- Loans: References Items and Members (records borrowing events).
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    ItemID INT,
    MemberID INT,
    Loan_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Return_Date DATE,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Reservations: References Items and Members (records reservation events).
CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    ItemID INT,
    MemberID INT,
    Reservation_Date DATE NOT NULL,
    Expiration_Date DATE NOT NULL,
    Reservation_Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Fines: References Members (tracks fines for late returns/lost items).
CREATE TABLE Fines (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    MemberID INT,
    Fine_Amount DECIMAL(10, 2) NOT NULL,
    Fine_Date DATE NOT NULL,
    Paid_Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);