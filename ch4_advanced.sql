-- sqldb 데이터베이스에서 다음 조건을 처리하세요
-- 사용자별로 구매 이력을 출력함
-- 모든 컬럼을 출력함
-- 구매 이력이 없는 정보는 출력하지 않음
SELECT *
FROM buytbl b JOIN usertbl u
ON b.userID = u.userID;

-- 앞의 결과에서 userID가 'JYP'인 데이터만 출력하세요
SELECT *
FROM buytbl b JOIN usertbl u
ON b.userID = u.userID
WHERE b.userID = 'JYP';

-- sqldb 데이터베이스에서 다음 조건을 처리하세요. 
-- 각 사용자 별로 구매 이력을 출력하세요.
-- 연결 컬럼은 userID로 함 
-- 결과를 userID를 기준으로 오름차순으로 정렬함 
-- 구매 이력이 없는 사용자도 출력하세요.
-- userID, name, prodName, addr, 연락처를 다음과 같이 출력함
SELECT u.userID, u.name, b.prodName, u.addr, CONCAT(u.mobile1, u.mobile2) as 연락처
FROM usertbl u LEFT OUTER JOIN buytbl b
ON u.userID = b.userID
ORDER BY u.userID;

USE sqldb;
CREATE TABLE stdtbl(
	stdName VARCHAR(10) NOT NULL PRIMARY KEY,
    addr CHAR(4) NOT NULL
);

CREATE TABLE clubtbl (
	clubName VARCHAR(10) NOT NULL PRIMARY KEY,
    roomNo CHAR(4) NOT NULL
);

CREATE TABLE stdclubtbl(
	num int AUTO_INCREMENT NOT NULL PRIMARY KEY,
    stdName VARCHAR(10) NOT NULL,
    clubName VARCHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
    FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);

INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'),('바비킴','서울'); 
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호'); 
INSERT INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

-- 학생 테이블,동아리 테이블,학생 동아리 테이블을 이용해서 학생을 기준으로 학생 이름/지역/가입한 동아리/동아리방을 출력하세요.
SELECT s.stdName, s.addr, sc.clubName, c.roomNo
FROM stdtbl s 
INNER JOIN stdclubtbl sc ON s.stdName = sc.stdName
INNER JOIN clubtbl c ON sc.clubName = c.clubName
ORDER BY s.stdName;

-- 동아리를 기준으로 가입한 학생의 목록을 출력하세요.
SELECT c.clubName, c.roomNo, s.stdName, s.addr
FROM stdtbl s 
INNER JOIN stdclubtbl sc ON s.stdName = sc.stdName
INNER JOIN clubtbl c ON sc.clubName = c.clubName
ORDER BY c.clubName;

USE sqldb; 
CREATE TABLE empTbl(
	emp CHAR(3), 
    manager CHAR(3), 
    empTel VARCHAR(8)
); 
INSERT INTO empTbl VALUES('나사장', NULL, '0000'); 
INSERT INTO empTbl VALUES('김재무', '나사장', '2222'); 
INSERT INTO empTbl VALUES('김부장', '김재무', '2222-1'); 
INSERT INTO empTbl VALUES('이부장', '김재무', '2222-2'); 
INSERT INTO empTbl VALUES('우대리', '이부장', '2222-2-1'); 
INSERT INTO empTbl VALUES('지사원', '이부장', '2222-2-2'); 
INSERT INTO empTbl VALUES('이영업', '나사장', '1111'); 
INSERT INTO empTbl VALUES('한과장', '이영업', '1111-1'); 
INSERT INTO empTbl VALUES('최정보', '나사장', '3333'); 
INSERT INTO empTbl VALUES('윤차장', '최정보', '3333-1'); 
INSERT INTO empTbl VALUES('이주임', '윤차장', '3333-1-1');

-- 앞에서 추가한 테이블에서 '우대리'의 상관 연락처 정보를 확인하세요.
SELECT A.emp AS '부하직원', B.emp AS '직속상관', B.empTel AS '직속상관연락처'
FROM emptbl A
INNER JOIN emptbl B
ON A.manager = B.emp
WHERE A.emp = '우대리';



-- sqldb의 사용자를 모두 조회하되 전화가 없는 사람은 제외하고 출력하세요
SELECT name, CONCAT(mobile1, mobile2) AS '전화번호'
FROM usertbl
WHERE name NOT IN 
(SELECT name FROM usertbl WHERE mobile1 IS NULL);

-- sqldb의 사용자를 모두 조회하되 전화가 없는 사람만 출력하세요.
SELECT name, CONCAT(mobile1, mobile2) AS '전화번호'
FROM usertbl
WHERE name IN 
(SELECT name FROM usertbl WHERE mobile1 IS NULL);