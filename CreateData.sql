use Company;

INSERT INTO dbo.Company(NameCompany,DateCreate,Founder)
VALUES
('Salesforce','1999-02-18','Марк Бениофф')

GO

INSERT INTO Employee(CompanyId,FullName,Age,Email,Phone)
VALUES
(1,'Басенко Иван Игоревич',22,'djbasenko@gmail.com','067-160-57-37'),
(1,'Демченко Иван Герасимович',20,'yanadek@mail.ru','067-236-30-86'),
(1,'Бартов Андрей Валерьевич',18,'doll_0001@mail.ru','067-248-02-04'),
(1,'Нэкрасов Максим Бедросович',30,'protakopych1976@mail.ru','067-248-66-37'),
(1,'Карвер Раймонд Степанович',35,'kukuruzerzer@mail.ru','067-270-22-51'),
(1,'Ким Чи Хин',19,'areoh25@list.ru','098-275-62-90	'),
(1,'Каспаров Гарри Кимович',27,'pkaravae.anisecq1986f@inbox.ru','067-276-78-27'),
(1,'Баранов Петр Олексеевич',26,'bocha-844@mail.ru','067-279-65-41'),
(1,'Шарко Олександа Метросиповна',25,'ushatkina_valentina@mail.ru','098-160-57-37'),
(1,'Шарко Карина Олександрова',28,'sakavichanka@mail.ru','067-285-59-23'),
(1,'Шолуденко Андрей Иванович',25,'efimova-lera@list.ru','063-160-57-37'),
(1,'Киркоров Сигизмунд Петрович',29,'ushatkina_ventina@mail.ru','067-1460-84-34'),
(1,'Пасечник Валерия Азеровна',21,'satellit_bug@mail.ru','068-452-79-01'),
(1,'Гордиенко Екатерина Степановна',37,'kbezboro.tamaran1989k@inbox.ru','067-450-59-39'),
(1,'Пастушенко Рома Романович',45,'tatyanaaleksandrovna@mail.ru','067-449-14-61')

GO
--0--Project open
--1--Project close
INSERT INTO Project(NameProject,DateCreate,StatusProject,DateClose)
VALUES
('Smart House','2019-01-16',0,'2019-03-16'),
('Village','2019-01-16',0,'2019-04-16'),
('Fantom','2018-12-12',1,'2019-03-16'),
('Dom','2018-12-16',0,'2019-05-16'),
('GameForce','2019-01-18',0,'2019-03-14'),
('Lepist','2019-01-19',0,'2019-03-19'),
('Mento','2019-01-18',1,'2019-03-12'),
('Restoraunt','2019-01-16',1,'2019-04-08'),
('Cinema Cimulation','2018-11-15',1,'2019-03-16'),
('Fruits Ninject','2018-10-16',1,'2019-05-16'),
('Vegetables House','2018-12-12',1,'2019-04-25')

GO


INSERT INTO Position(NamePosition)
VALUES
('Front-end Developer'),
('.NET Junior Developer'),
('.NET Senior Developer'),
('.NET Middle Developer'),
('.NET Architect'),
('.NET Development Team Lead'),
('Java Junior Developer'),
('Java Senior Developer'),
('Java Middle Developer'),
('System Administrators'),
('Systems Analyst')

GO

INSERT INTO EmployeeProject(EmployeeId,ProjectId,PositionId)
VALUES
(1,1,1),
(1,2,1),
(1,5,2),
(2,4,3),
(3,4,5),
(5,4,1),
(4,2,5),
(5,2,5),
(5,6,1),
(7,4,6),
(7,5,5),
(8,4,1)

GO

INSERT INTO Task(NameTask,Dedline,EmployeeId,ProjectId)
VALUES
('creating ','2019-03-16',1,1),
('workflows  ','2019-01-12',1,2),
('programming  ','2019-02-15',1,5),
('library  ','2018-12-12',2,4),
('Foundation  ','2018-12-16',3,4),
('updating  ','2019-01-16',4,2),
('sites ','2019-01-19',5,6),
('ribbon ','2018-12-16',7,4),
('MILKshake','2019-02-17',5,6)


GO

INSERT INTO TaskStatus(IdTask,NameStatus,DateChange,IdEmployeeCheckStatus)
VALUES
(1,'completed','2019-03-12',7),
(2,'closed','2019-01-12',7),
(3,'needs some work','2019-02-12',7),
(4,'open','2018-12-12',7),
(5,'completed','2018-12-12',7),
(6,'needs some work','2018-12-29',7),
(7,'closed','2019-01-19',7),
(8,NULL,'2018-12-15',NULL),
(9,'closed','2019-02-15',7)	



