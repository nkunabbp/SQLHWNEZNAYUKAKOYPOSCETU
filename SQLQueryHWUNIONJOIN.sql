USE Library
-- 1
SELECT P.Name
FROM Books AS B
JOIN Press AS P ON B.Id_Press = P. Id
GROUP BY P.Name
HAVING AVG(B.Pages) > 100

-- 2
SELECT SUM(Pages) AS SumOfBooks
FROM Books AS B
JOIN Press AS P
ON B.Id_Press = P.Id 
WHERE P.Name IN (N'BHV',N'Binom')

-- 3 студентов с этой книгой не было поэтому я взяла другую книгу
SELECT S.FirstName , SC.DateOut , B.Name , A.FirstName + N' ' + A.LastName AS Author
FROM Students AS S
JOIN S_Cards AS SC 
ON S.Id = SC.Id_Student
JOIN Books AS B    
ON B.Id = SC.Id_Book 
JOIN Authors AS A 
ON A.Id = B.Id_Author
WHERE S.Id = SC.Id_Student AND B.Name = 'Mathcad 2000' AND SC.DateIn IS NULL

-- 4
SELECT S.FirstName AS ClientName ,  B.Name AS BookName
FROM Students AS S
JOIN S_Cards AS SC 
ON S.Id = SC.Id_Student
JOIN Books AS B
ON B.Id = SC.Id_Book 

UNION

SELECT T.FirstName AS ClientName ,  B.Name AS BookName
FROM Teachers AS T
JOIN T_Cards AS TC 
ON T.Id = TC.Id_Teacher
JOIN Books AS B
ON B.Id = TC.Id_Book 

-- 5 vibrala top 5 potomu cto u nix odinalovoe kolicesto dlya samogo pervogo bilo bi SELECT TOP(1)
SELECT TOP(5) A.FirstName + ' ' + A.LastName AS AuthorsName, COUNT(B.Id) AS TakenBooks
FROM S_Cards AS SC
JOIN Books AS B ON SC.Id_Book = B.Id
JOIN Authors AS A ON B.Id_Author = A.Id
JOIN Students AS S ON SC.Id_Student = S.Id
GROUP BY A.FirstName + ' ' + A.LastName
ORDER BY TakenBooks DESC;

-- 6
SELECT TOP(1) A.FirstName + ' ' + A.LastName AS AuthorsName, COUNT(B.Id) AS TakenBooks
FROM T_Cards AS TC
JOIN Books AS B ON TC.Id_Book = B.Id
JOIN Authors AS A ON B.Id_Author = A.Id
JOIN Teachers AS T ON TC.Id_Teacher = T.Id
GROUP BY A.FirstName + ' ' + A.LastName
ORDER BY TakenBooks DESC;

-- 7
SELECT S.FirstName AS Name, F.Name AS Work
FROM Students AS S
JOIN Groups AS G
ON S.Id_Group = G.Id
JOIN Faculties AS F
ON F.Id = G.Id_Faculty
WHERE F.Name LIKE N'Web Design'

UNION

SELECT T.FirstName AS Name , D.Name AS Work
FROM Teachers AS T
JOIN Departments AS D
ON T.Id_Dep = D.Id
WHERE D.Name LIKE N'Graphics and Designs'
ORDER BY Work

-- 7
SELECT L.Id , L.FirstName + ' ' + L.LastName AS Librarian, COUNT(*) AS BooksIssued
FROM Libs AS L
JOIN dbo.S_Cards AS SC 
ON L.Id = SC.Id_Lib
JOIN dbo.T_Cards AS TC 
ON L.Id = TC.Id_Lib
GROUP BY L.Id, L.FirstName, L.LastName