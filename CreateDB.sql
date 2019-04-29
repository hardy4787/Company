CREATE DATABASE Company;

GO

Use Company;

CREATE TABLE Company
(
	Id INT PRIMARY KEY IDENTITY,
	NameCompany NVARCHAR(30) NOT NULL,
	DateCreate DATE,
	Founder NVARCHAR(30)
)

CREATE TABLE Employee
(
	Id INT PRIMARY KEY IDENTITY,
	CompanyId INT NOT NULL,
	FullName NVARCHAR(30) NOT NULL,
	Age INT CONSTRAINT CK_Employee_Age CHECK(Age >=18 AND Age < 100) NOT NULL,
    Email VARCHAR(30) UNIQUE NOT NULL,
    Phone VARCHAR(20) UNIQUE,
	CONSTRAINT FK_Employee_To_Company FOREIGN KEY (CompanyId) REFERENCES Company(Id)
)

CREATE TABLE Project
(
	Id INT PRIMARY KEY IDENTITY,
	NameProject NVARCHAR(30) NOT NULL,
	DateCreate DATETIME NOT NULL,
	StatusProject BIT NOT NULL,
	DateClose DATETIME,
    CONSTRAINT UQ_Project_NameProject UNIQUE (NameProject)
)

CREATE TABLE Position
(
	Id INT PRIMARY KEY IDENTITY,
	NamePosition VARCHAR(30) NOT NULL
)

CREATE TABLE EmployeeProject
(
	EmployeeId INT REFERENCES Employee(Id),
	ProjectId INT REFERENCES Project(Id),
	PositionId INT REFERENCES Position(Id),
	CONSTRAINT PK_EmployeeProject_Id PRIMARY KEY(EmployeeId,ProjectId)
)

CREATE TABLE Task
(
	Id INT PRIMARY KEY IDENTITY,
	NameTask VARCHAR(30),
	Dedline DATETIME,
	EmployeeId INT NOT NULL,
	ProjectId INT NOT NULL,
	CONSTRAINT FK_Task_To_EmployeeProject FOREIGN KEY (EmployeeId,ProjectId)  REFERENCES EmployeeProject(EmployeeId,ProjectId)
)

CREATE TABLE TaskStatus
(
	IdTask INT PRIMARY KEY,
	NameStatus VARCHAR(20) NOT NULL,
	DateChange DATETIME NOT NULL,
	IdEmployeeCheckStatus INT NOT NULL,
	CONSTRAINT FK_TaskStatus_To_Task FOREIGN KEY (IdTask) REFERENCES Task(Id),
	CONSTRAINT FK_IdEmployeeCheckStatus_To_Employee FOREIGN KEY (IdEmployeeCheckStatus) REFERENCES Employee(Id)
)
