use Company;

--(1 QUERY : �������� ������ ���� ���������� � ����������� ����������� �� ������ �� ���)
SELECT Position.NamePosition,COUNT(DISTINCT EmployeeId)
FROM EmployeeProject
JOIN Position ON PositionId = Position.Id
GROUP BY Position.NamePosition

--(2 QUERY : ���������� ������ ���������� ��������, �� ������� ��� �����������)
SELECT Position.NamePosition FROM Position
WHERE (SELECT COUNT(DISTINCT EmployeeId) FROM EmployeeProject WHERE PositionId = Position.Id) = 0

--(3 QUERY : �������� ������ �������� � ���������, ������� ����������� ������ ��������� �������� �� �������)
SELECT Project.NameProject,
 Position.NamePosition, 
 (COUNT(EmployeeProject.EmployeeId))
FROM Project
JOIN EmployeeProject ON EmployeeProject.ProjectId = Project.Id
JOIN Position ON Position.Id = EmployeeProject.PositionId
GROUP BY Position.NamePosition,Project.NameProject
	
--(4 QUERY : ��������� �� ������ �������, ����� � ������� ���������� ����� ���������� �� ������� ����������)
SELECT EmployeeProject.ProjectId, COUNT(Task.Id) / COUNT(DISTINCT EmployeeProject.EmployeeId) 
FROM EmployeeProject 
 JOIN Task ON EmployeeProject.EmployeeId = Task.EmployeeId AND EmployeeProject.ProjectId = Task.ProjectId
 GROUP BY EmployeeProject.ProjectId

--(5 QUERY : ���������� ������������ ���������� ������� �������)
SELECT Project.NameProject,DATEDIFF(day, DateCreate, DateClose) FROM Project WHERE Project.DateClose IS NOT NULL

--(6 QUERY : ���������� ����������� � ����������� ����������� ���������� �����)
SELECT EmployeeProject.EmployeeId, COUNT(Task.Id) FROM EmployeeProject
JOIN Task ON EmployeeProject.EmployeeId = Task.EmployeeId AND EmployeeProject.ProjectId = Task.ProjectId
JOIN TaskStatus ON Task.Id = TaskStatus.IdTask AND TaskStatus.NameStatus <> 'closed'
GROUP BY EmployeeProject.EmployeeId
HAVING COUNT(Task.Id) = (SELECT TOP 1 COUNT(Task.Id) FROM EmployeeProject
				JOIN Task ON EmployeeProject.EmployeeId = Task.EmployeeId AND EmployeeProject.ProjectId = Task.ProjectId
				JOIN TaskStatus ON Task.Id = TaskStatus.IdTask AND TaskStatus.NameStatus <> 'closed'
                GROUP BY EmployeeProject.EmployeeId
                ORDER BY  COUNT(Task.Id))

--(7 QUERY : ���������� ����������� � ������������ ����������� ���������� �����, ������� ������� ��� �����)
SELECT EmployeeProject.EmployeeId, COUNT(Task.Id) FROM EmployeeProject
JOIN Task ON EmployeeProject.EmployeeId = Task.EmployeeId AND EmployeeProject.ProjectId = Task.ProjectId AND DATEDIFF(day,Task.Dedline,GETDATE()) > 0
JOIN TaskStatus ON Task.Id = TaskStatus.IdTask AND TaskStatus.NameStatus <> 'closed'
GROUP BY EmployeeProject.EmployeeId
HAVING COUNT(Task.Id) = (SELECT TOP 1 COUNT(Task.Id) FROM EmployeeProject
				JOIN Task ON EmployeeProject.EmployeeId = Task.EmployeeId AND EmployeeProject.ProjectId = Task.ProjectId AND DATEDIFF(day,Task.Dedline,GETDATE()) > 0
				JOIN TaskStatus ON Task.Id = TaskStatus.IdTask AND TaskStatus.NameStatus <> 'closed'
                GROUP BY EmployeeProject.EmployeeId
                ORDER BY  COUNT(Task.Id))

--(8 QUERY : �������� ������� ���������� ����� �� 5 ����)
UPDATE Task
SET Dedline = DATEADD(day, 5, Task.Dedline)
FROM 
(SELECT * FROM TaskStatus JOIN Task ON TaskStatus.NameStatus <> 'closed') AS Selected
WHERE Selected.IdTask = Task.Id


--(9 QUERY : ��������� �� ������ ������� ���������� �����, � ������� ��� �� ����������)
SELECT EmployeeProject.ProjectId, Count(Task.Id) FROM EmployeeProject
JOIN Task ON Task.ProjectId = EmployeeProject.ProjectId AND Task.EmployeeId = EmployeeProject.EmployeeId
JOIN TaskStatus ON TaskStatus.NameStatus IS NULL AND TaskStatus.IdTask = Task.Id
GROUP BY EmployeeProject.ProjectId


--(10 QUERY : ��������� ������� � ��������� ������, ��� ������� ��� ������ ������� � ������ ����� �������� �������� �������� ������ �������, �������� ���������)
GO
CREATE PROCEDURE CloseProjectWithAllClosedTasks
AS
DECLARE @ProjId INT;
DECLARE @LastDateChangeTaskStatus DATETIME;
SET @ProjId = (SELECT DISTINCT TOP 1 ProjectId FROM Task AS e
				JOIN TaskStatus ON e.Id = TaskStatus.IdTask AND 'closed' = ALL(SELECT TaskStatus.NameStatus FROM TaskStatus
				JOIN Task ON Task.Id = TaskStatus.IdTask AND Task.ProjectId = e.ProjectId))
SET @LastDateChangeTaskStatus = (SELECT TOP 1 DateChange FROM TaskStatus
				JOIN Task ON Task.Id = TaskStatus.IdTask AND Task.ProjectId = @ProjId
				ORDER BY DateChange DESC)
UPDATE Project
SET StatusProject = 1, DateClose = @LastDateChangeTaskStatus
WHERE Project.Id = @ProjId

EXEC CloseProjectWithAllClosedTasks

SELECT * FROM Project

--(11 QUERY : �������� �� ���� ��������, ����� ���������� �� ������� �� ����� ���������� �����)
SELECT DISTINCT e.ProjectId, e.EmployeeId FROM EmployeeProject AS e
JOIN Task ON Task.ProjectId = e.ProjectId AND Task.EmployeeId = e.EmployeeId
JOIN TaskStatus ON TaskStatus.IdTask = Task.Id
AND 'closed' = ALL(SELECT TaskStatus.NameStatus FROM TaskStatus
	 JOIN Task on TaskStatus.IdTask = Task.Id
		JOIN EmployeeProject ON Task.ProjectId = EmployeeProject.ProjectId AND Task.EmployeeId = EmployeeProject.EmployeeId AND EmployeeProject.EmployeeId = e.EmployeeId)

--(12 QUERY : �������� ������ (�� ��������) ������� ��������� �� ���������� � ����������� ����������� ����������� �� �����)
GO
CREATE PROCEDURE UpdateEmployeeTask
	@taskName VARCHAR(30)
AS
	DECLARE @employeeId INT
	DECLARE @IdProject SMALLINT
	SET @IdProject = (SELECT TOP 1 ProjectId FROM Task WHERE NameTask = @taskName)
	SELECT EmployeeProject.EmployeeId AS EmpId, COUNT(Task.Id) AS CountTasks INTO MinEmployeeTavl
		FROM EmployeeProject 
		LEFT JOIN Task ON Task.EmployeeId = EmployeeProject.EmployeeId 
		LEFT JOIN TaskStatus ON Task.Id = TaskStatus.IdTask 
		WHERE EmployeeProject.ProjectId = @IdProject and
		((TaskStatus.NameStatus <> 'completed' AND TaskStatus.NameStatus <> 'closed')
		OR TaskStatus.IdTask IS NULL)
		GROUP BY EmployeeProject.EmployeeId
		ORDER BY COUNT(Task.Id)
	SET @employeeId = (SELECT TOP 1 EmpId FROM MinEmployeeTavl)
	DROP TABLE MinEmployeeTavl
	UPDATE Task
	SET EmployeeId = @employeeId
	WHERE Task.NameTask = @taskName

EXEC UpdateEmployeeTask 'updating'




