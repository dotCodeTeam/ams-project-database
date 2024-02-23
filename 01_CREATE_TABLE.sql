USE amsdb;
DESCRIBE EMPLOYEE;			# 사용중인 DB의 TABLE 속성 확인

CREATE TABLE `ADMIN`
(
    `ADMIN_ID`    VARCHAR(20) NOT NULL,
 PRIMARY KEY ( `ADMIN_ID` )
);

INSERT INTO ADMIN
	(ADMIN_ID) VALUES
    ('0'),
	('1');

CREATE TABLE `ATTENDANCE`
(
    `ONTIME_COUNT`    INTEGER NOT NULL,
    `LATE_COUNT`    INTEGER NOT NULL,
    `ABSENT_COUNT`    INTEGER NOT NULL,
    `ATTENDANCE_TOTALSCORE`    INTEGER NOT NULL,
    `OFFTIME_STATUS`    VARCHAR(4) NOT NULL,
    `EMP_NO`    INT NOT NULL,
    FOREIGN KEY(EMP_NO) REFERENCES EMPLOYEE(EMP_NO)
);

-- OFFTIME_STATUS에서 CHECK 제약조건을 추가하여 '예', '아니오' 만 입력할 수 있게끔 지정해놓는다.
ALTER TABLE ATTENDANCE
	ADD CONSTRAINT
    CHECK (OFFTIME_STATUS IN ('예', '아니오'));

DESCRIBE ATTENDANCE;
SELECT * FROM ATTENDANCE;
INSERT INTO ATTENDANCE (		# TABLE(컬럼)에 VALUES(값) 추가
						ONTIME_COUNT
					,   LATE_COUNT
                    ,   ABSENT_COUNT
                    ,   ATTENDANCE_TOTALSCORE
                    ,   OFFTIME_STATUS
                    ,   EMP_NO )
VALUES (1, 0, 0, 0, '예', '001');

DELETE FROM ATTENDANCE A WHERE A.EMP_NO = '002';

INSERT INTO ATTENDANCE (		# TABLE(컬럼)에 VALUES(값) 추가
						ONTIME_COUNT
					,   LATE_COUNT
                    ,   ABSENT_COUNT
                    ,   ATTENDANCE_SCORE
                    ,   OFFTIME_STATUS
                    ,   EMP_NO )
VALUES (2, 1, 2, 3, '예', '002')
	  ,(1, 2, 3, 4, '아니오', '003')
      ,(2, 2, 3, 2, '예', '004')
      ,(3, 1, 2, 2, '아니오', '005');

CREATE TABLE `VACANT`
(
    `EMP_NO`    INT NOT NULL,
    `VACANT_CATEGORY`    VARCHAR(20) NOT NULL,
    `VACANT_NAME`    VARCHAR(20) NOT NULL,
    `VACANT_DATE`    DATE NOT NULL,
    `VACANT_CAUSE`    VARCHAR(255),
 PRIMARY KEY ( `VACANT_CATEGORY` ),
 FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)
);

-- EMP_DATE 열에 중복을 방지하는 UNIQUE 제약 조건 추가
ALTER TABLE VACANT ADD CONSTRAINT UNIQUE (VACANT_DATE);

CREATE TABLE `JOB`
(
    `JOB_ID`    INT NOT NULL,
    `JOB_NAME`    VARCHAR(20) NOT NULL,
 PRIMARY KEY ( `JOB_ID` )
);

INSERT INTO JOB
	(JOB_ID, JOB_NAME) VALUES
    ('1' , '사장'),
    ('2' , '부장'),
    ('3' , '차장'),
    ('4' , '과장'),
    ('5' , '대리'),
    ('6' , '사원');

CREATE TABLE `EMPLOYEE`
(
    `EMP_NO`    INT NOT NULL,
    `EMP_ID`    VARCHAR(20) NOT NULL,
    `EMP_PW`    VARCHAR(20) NOT NULL,
    `EMP_NAME`    VARCHAR(20) NOT NULL,
    `PHONE`    VARCHAR(20) NOT NULL,
    `EMAIL`    VARCHAR(255) NOT NULL,
    `ADMIN_ID`    VARCHAR(20) NOT NULL,
    `JOB_ID`    int NOT NULL,
 PRIMARY KEY ( `EMP_NO` )
);

-- ADMIN_ID 와 POSITION_ID 외래키 지정
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (ADMIN_ID) REFERENCES ADMIN(ADMIN_ID);
ALTER TABLE EMPLOYEE ADD FOREIGN KEY (JOB_ID) REFERENCES JOB(JOB_ID);

-- EMP_ID 열에 중복을 방지하는 UNIQUE 제약 조건 추가
ALTER TABLE EMPLOYEE ADD CONSTRAINT UNIQUE (EMP_ID);

SELECT * FROM EMPLOYEE;		# TABLE 조회
INSERT INTO EMPLOYEE (		# TABLE(컬럼)에 VALUES(값) 추가
						EMP_NO
					,   EMP_ID
                    ,   EMP_PW
                    ,   EMP_NAME
                    ,   PHONE
                    ,   EMAIL
                    ,   ADMIN_ID
                    ,   JOB_ID	)
VALUES ('001', 'eunSung', '1234', '조은성', '010-1234-1234', '은성@gamil.com', '0', '1')
	,  ('002', 'sooBin', '5678', '윤수빈', '010-1234-5678', '수빈@gamil.com', '0', '2')
    ,  ('003', 'youngSang', '1357', '고영상', '010-1357-1357', '영상@gamil.com', '1', '3')
    ,  ('004', 'chanWool', '8520', '임찬운', '010-8520-1234', '찬울@gamil.com', '0', '4')
    ,  ('005', 'jinHyun', '0258', '박진현', '010-0258-1234', '진현@gamil.com', '0', '5');

UPDATE EMPLOYEE E			# EMPLOYEE TABLE 별칭 E 에 SET 값으로 WHERE에 있는 값 변경
	SET E.EMP_NO = '002', E.EMP_ID = 'cloud1', E.EMAIL = 'cloud222@gamil.com'
	WHERE E.EMP_NO = '001';			
    
DELETE FROM EMPLOYEE E WHERE E.EMP_NO = '002';	# EMPLOYEE TABLE에 WHERE 조건에 있는 값의 행 삭제

-- join문 사용
SELECT E.EMP_NO, E.EMP_ID, E.EMP_NAME, E.JOB_ID
	FROM EMPLOYEE E
    JOIN ATTENDANCE A ON E.EMP_NO = A.EMP_NO
    WHERE A.ONTIME_COUNT = 2;
    
SELECT 
		E.EMP_NAME, E.JOB_ID
	FROM EMPLOYEE E
    LEFT JOIN ATTENDANCE A ON E.EMP_NO = A.EMP_NO;

commit;