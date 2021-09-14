
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS view_account;
CREATE VIEW view_account AS 
	SELECT *
	FROM `Account`
	JOIN Department USING(DepartmentID)
    WHERE DepartmentName = 'Sale';
	
SELECT *
FROM view_account;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS					 Account_nangNo;
CREATE OR REPLACE VIEW 				 Account_nangNo
AS
SELECT 		A.*, COUNT(B.AccountID) ,GROUP_CONCAT(GroupID)
FROM		`Account`		AS  A 
JOIN 	`GroupAccount` 	AS	B		 USING (AccountID )
GROUP BY	A.AccountID
HAVING		COUNT(B.AccountID) = (
									SELECT 		COUNT(B.AccountID) 
									FROM		`Account` 		AS 		A 
									JOIN 	`GroupAccount` 	AS		B		 USING	 (AccountID)
									GROUP BY	A.AccountID
									ORDER BY	COUNT(B.AccountID) DESC
									LIMIT		1
								  );
SELECT 	*
FROM  	 Account_nangNo;
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 20 từ được coi là quá dài) và xóa nó đi

CREATE VIEW view_content 
AS
SELECT *
FROM Content
WHERE length(Content)>20;

SELECT * FROM view_Content;

delete FROM view_Content;


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất






-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
CREATE OR REPLACE VIEW view_Question
AS
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator FROM question Q
JOIN `account` A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn';
SELECT * FROM view_Question;

-- CTE
-- Question 1: Tạo CTE có chứa danh sách nhân viên thuộc phòng ban sale

WITH CTE_sale AS(
SELECT A.*, B.DepartmentName
FROM account A
JOIN department B ON A.DepartmentID = B.DepartmentID
WHERE B.DepartmentName = 'Sale'
)
SELECT * FROM CTE_Sale;

-- Question 2: Tạo CTE có chứa thông tin các account tham gia vào nhiều group nhất
WITH CTE(AccountID,Emai,FullName,GroupName) AS (
	SELECT AccountID,Emai,FullName,GroupName
    FROM	AccountID
)
SELECT * FROM CTE;






-- Question 3: Tạo CTE có chứa câu hỏi có những content quá dài (content quá 20 từ được coi là quá dài) và xóa nó đi
WITH CTE_content AS (
SELECT *
FROM Question
WHERE length(Content)>20
)
SELECT * FROM CTE_Content;

delete FROM CTE_Content;

-- Question 4: Tạo CTE có chứa danh sách các phòng ban có nhiều nhân viên nhất
WITH CTE_DepartmentName AS (
SELECT count(A.DepartmentID) AS countDepartmentID FROM Account A
GROUP BY A.DepartmentID)
SELECT C.DepartmentName,count(A.DepartmentID) AS sl
FROM Account A
JOIN Department C ON C.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING count(a.DepartmentID) = (SELECT max(DepartmentID) FROM CTE_Department );
SELECT * FROM CTE_maxDepartmentName



-- Question 5: Tạo CTE có chứa tất các các câu hỏi do user họ Nguyễn tạo

WITH CTE_Question AS(
SELECT B.CategoryID, B.Content, A.FullName AS Creator FROM question B
JOIN `account` A ON A.AccountID = B.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn'
)
SELECT * FROM CTE_Question;

