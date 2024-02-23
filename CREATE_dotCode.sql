USE AMSDB;					# AMSDB 사용함
DESCRIBE EMPLOYEE;			# 사용중인 DB의 TABLE 속성 확인

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

DESCRIBE ATTENDANCE;
SELECT * FROM ATTENDANCE;
INSERT INTO ATTENDANCE (		# TABLE(컬럼)에 VALUES(값) 추가
						ONTIME_COUNT
					,   LATE_COUNT
                    ,   ABSENT_COUNT
                    ,   ATTENDANCE_SCORE
                    ,   OFFTIME_STATUS
                    ,   EMP_NO )
VALUES (1, 0, 0, 0, true, '001');

DELETE FROM ATTENDANCE A WHERE A.EMP_NO = '002';

INSERT INTO ATTENDANCE (		# TABLE(컬럼)에 VALUES(값) 추가
						ONTIME_COUNT
					,   LATE_COUNT
                    ,   ABSENT_COUNT
                    ,   ATTENDANCE_SCORE
                    ,   OFFTIME_STATUS
                    ,   EMP_NO )
VALUES (2, 1, 2, 3, true, '002')
	  ,(1, 2, 3, 4, true, '003')
      ,(2, 2, 3, 2, true, '004')
      ,(3, 1, 2, 2, true, '005');
      
SELECT * FROM ATTENDANCE;

SELECT E.EMP_NO, E.EMP_ID, E.EMP_NAME, E.JOB_ID
	FROM EMPLOYEE E
    JOIN ATTENDANCE A ON E.EMP_NO = A.EMP_NO
    WHERE A.ONTIME_COUNT = 2;
    
SELECT 
		E.EMP_NAME, E.JOB_ID
	FROM EMPLOYEE E
    LEFT JOIN ATTENDANCE A ON E.EMP_NO = A.EMP_NO;
    
    







