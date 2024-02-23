USE amsdb;
DESCRIBE EMPLOYEE;			# 사용중인 DB의 TABLE 속성 확인

-- 삭제할 테이블이 있을 경우에만 사용
drop table admin;
drop table document;
drop table attendance;
drop table employee;
drop table job;
drop table vacant;

-- ADMIN(관리 직책 테이블 생성)
CREATE TABLE ADMIN
(
    ADMIN_CODE    INTEGER NOT NULL,
    ADMIN_NAME    VARCHAR(255) NOT NULL,
 PRIMARY KEY (ADMIN_CODE)
);

-- ADMIN 
INSERT INTO ADMIN
	(ADMIN_CODE, ADMIN_NAME) VALUES
    ('0', '관리자'),
	('1', '일반사원');

-- JOB(직급 테이블 생성)
CREATE TABLE JOB
(
    JOB_CODE    INTEGER NOT NULL,
    JOB_NAME    VARCHAR(255) NOT NULL,
 PRIMARY KEY ( JOB_CODE )
);

-- JOB 테이블에 직책 코드 , 직책 이름 생성
INSERT INTO JOB
	(JOB_CODE, JOB_NAME) VALUES
    ('1', '사원'),
    ('2', '대리'),
    ('3', '과장'),
    ('4', '차장'),
    ('5', '부장'),
    ('6', '사장');

-- EMPLOYEE(사원정보 테이블 생성)
CREATE TABLE EMPLOYEE
(
    EMP_NO    INTEGER NOT NULL,
    EMP_ID    VARCHAR(20) NOT NULL,
    EMP_PW    VARCHAR(20) NOT NULL,
    EMP_NAME    VARCHAR(20) NOT NULL,
    JOB_CODE    INTEGER NOT NULL,
    EMP_HIREDATE    DATE NOT NULL,
    PHONE    VARCHAR(20) NOT NULL,
    EMAIL    VARCHAR(255) NOT NULL,
    ADMIN_CODE    INTEGER NOT NULL,
 PRIMARY KEY ( EMP_NO ),
 FOREIGN KEY(ADMIN_CODE) REFERENCES ADMIN(ADMIN_CODE),
 FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE)
);
-- EMP_ID 열에 중복을 방지하는 UNIQUE 제약 조건 추가
ALTER TABLE EMPLOYEE ADD CONSTRAINT UNIQUE (EMP_ID);

INSERT INTO EMPLOYEE (		# TABLE(컬럼)에 VALUES(값) 추가
						EMP_NO
					,   EMP_ID
                    ,   EMP_PW
                    ,   EMP_NAME
                    ,   JOB_CODE
                    , 	EMP_HIREDATE
                    ,   PHONE
                    ,   EMAIL
                    ,   ADMIN_CODE
                    	)
VALUES ('1', 'eunSung', '1234', '조은성', '6', STR_TO_DATE('20230201','%Y%m%d'), '010-1234-1234', '은성@gamil.com', '0')
	  ,  ('2', 'sooBin', '5678', '윤수빈', '4', STR_TO_DATE('20230210','%Y%m%d'), '010-1234-5678', '수빈@gamil.com', '0')
	  ,  ('3', 'youngSang', '1357', '고영상', '3', STR_TO_DATE('20230215','%Y%m%d'), '010-1357-1357', '영상@gamil.com', '1')
      ,  ('4', 'chanWool', '8520', '임찬울', '2', STR_TO_DATE('20230217','%Y%m%d'), '010-8520-1234', '찬울@gamil.com', '1')
      ,  ('5', 'jinHyun', '0258', '박진현', '1', STR_TO_DATE('20230220','%Y%m%d'), '010-0258-1234', '진현@gamil.com', '1'); 


-- ATTENDANCE(근태 테이블 생성)
CREATE TABLE ATTENDANCE
(
    ONTIME_COUNT    INTEGER NOT NULL,
    LATE_COUNT    INTEGER NOT NULL,
    ABSENT_COUNT    INTEGER NOT NULL,
    ATTENDANCE_TOTALSCORE    INTEGER NOT NULL,
    OFFTIME_STATUS    VARCHAR(4) NOT NULL,
    EMP_NO    INTEGER NOT NULL,
    FOREIGN KEY(EMP_NO) REFERENCES EMPLOYEE(EMP_NO)
);
-- OFFTIME_STATUS에서 CHECK 제약조건을 추가하여 '예', '아니오' 만 입력할 수 있게끔 지정해놓는다.
ALTER TABLE ATTENDANCE
	ADD CONSTRAINT
    CHECK (OFFTIME_STATUS IN ('YES', 'NO'));

CREATE TABLE VACANT
(
    EMP_NO    INTEGER NOT NULL,
    VACANT_CATEGORY    INTEGER NOT NULL,
    VACANT_NAME    VARCHAR(20) NOT NULL,
    VACANT_DATE    DATE NOT NULL,
    VACANT_CAUSE    VARCHAR(255),
 PRIMARY KEY ( VACANT_CATEGORY ),
 FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO)
);
-- EMP_DATE 열에 중복을 방지하는 UNIQUE 제약 조건 추가
ALTER TABLE VACANT ADD CONSTRAINT UNIQUE (VACANT_DATE);

-- DOCUMENT(증빙서류)테이블 생성
CREATE TABLE DOCUMENT
(
    DOCUMENT_CODE  INT NOT NULL,
    EMP_NO INT NOT NULL,
    VACANT_CATEGORY INT NOT NULL,
 PRIMARY KEY ( DOCUMENT_CODE ),
 FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE(EMP_NO),
 FOREIGN KEY (VACANT_CATEGORY) REFERENCES VACANT(VACANT_CATEGORY)
);

commit;