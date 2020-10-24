CREATE DATABASE IF NOT EXISTS covidTracker;
USE covidTracker;

CREATE TABLE IF NOT EXISTS Person (
	id VARCHAR(20) NOT NULL,
	fName VARCHAR(14) NOT NULL,
	mInit VARCHAR(14),
	lName VARCHAR(14) NOT NULL,
	lastTested DATETIME(6),
	cutStatus VARCHAR(10) DEFAULT 'Normal',
	PRIMARY KEY(id)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Student (
	id VARCHAR(20) NOT NULL UNIQUE,
	major VARCHAR(20) DEFAULT 'Undeclared',
	classYear VARCHAR(14) NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY (id)
      REFERENCES Person(id)
      ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Employee (
	id VARCHAR(20) NOT NULL UNIQUE,
	major VARCHAR(20),
	PRIMARY KEY(id),
	FOREIGN KEY (id)
      REFERENCES Person(id)
      ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Building (
	name VARCHAR(20) NOT NULL ,
	covidStatue VARCHAR(20) DEFAULT 'Safe',
	PRIMARY KEY(name)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS SpecificLocation (
	name VARCHAR(20) NOT NULL UNIQUE,
	buildingName VARCHAR(20),
	room VARCHAR(20),
	PRIMARY KEY(name,buildingName,room),
	FOREIGN KEY (buildingName)
      REFERENCES Building(name)
      ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Course (
	courseNumber VARCHAR(20) NOT NULL UNIQUE,
	classTime VARCHAR(20) NOT NULL,
	name VARCHAR(20) NOT NULL,
	inPerson VARCHAR(20) NOT NULL,
	specificLocName VARCHAR(20),
	employeeID VARCHAR(20),
	PRIMARY KEY(courseNumber, classTime, specificLocName, employeeID),
	FOREIGN KEY (specificLocName)
      REFERENCES SpecificLocation(name)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (employeeID)
      REFERENCES Employee(id)
      ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Takes (
	studentID VARCHAR(20) NOT NULL,
	courseNumber VARCHAR(20) NOT NULL,
	courseTime VARCHAR(20) NOT NULL,
	PRIMARY KEY(studentID,courseNumber,courseTime),
	FOREIGN KEY (courseNumber,courseTime)
      REFERENCES Course(courseNumber,classTime)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (studentID)
      REFERENCES Student(id)
      ON UPDATE CASCADE ON DELETE CASCADE 
)ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS WorksIn (
	employeeID VARCHAR(20) NOT NULL,
	specificLocName VARCHAR(20) NOT NULL,
	PRIMARY KEY(employeeID,specificLocName),
	FOREIGN KEY (employeeID)
      REFERENCES Employee(id)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (specificLocName)
      REFERENCES SpecificLocation(name)
      ON UPDATE CASCADE ON DELETE CASCADE 
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS RoomMates (
	studentID VARCHAR(20) NOT NULL,
	studentID2 VARCHAR(20) NOT NULL,
	PRIMARY KEY(studentID,studentID2),
	FOREIGN KEY (studentID)
      REFERENCES Student(id)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (studentID2)
      REFERENCES Student(id)
      ON UPDATE CASCADE ON DELETE CASCADE 
)ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS Visited (
	locationName VARCHAR(20) NOT NULL,
	personID VARCHAR(20) NOT NULL,
	endTime DATETIME(6),
	entryTIme DATETIME(6),
	PRIMARY KEY(locationName,personID,endTime,entryTIme),
	FOREIGN KEY (locationName)
      REFERENCES SpecificLocation(name)
      ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (personID)
      REFERENCES Person(id)
      ON UPDATE CASCADE ON DELETE CASCADE 
)ENGINE=INNODB;



