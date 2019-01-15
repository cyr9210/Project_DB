--기존 테이블 제거

DROP TABLE LABEL CASCADE CONSTRAINTS PURGE;
DROP TABLE LIST CASCADE CONSTRAINTS PURGE;
DROP TABLE CHECKLIST CASCADE CONSTRAINTS PURGE;
DROP TABLE D_DAY CASCADE CONSTRAINTS PURGE;
--DROP TABLE INTERLINKED_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE CHAT_HISTORY CASCADE CONSTRAINTS PURGE;
DROP TABLE CHAT CASCADE CONSTRAINTS PURGE;
DROP TABLE NOTICE CASCADE CONSTRAINTS PURGE;
DROP TABLE TAG CASCADE CONSTRAINTS PURGE;
DROP TABLE REPLY CASCADE CONSTRAINTS PURGE;
DROP TABLE DESCRIPTION CASCADE CONSTRAINTS PURGE;
DROP TABLE POST CASCADE CONSTRAINTS PURGE;
DROP TABLE PRJ_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE INTER_M_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE CARD CASCADE CONSTRAINTS PURGE;
DROP TABLE INVITE CASCADE CONSTRAINTS PURGE;
DROP TABLE EXTERNAL_M_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE PROJECT CASCADE CONSTRAINTS PURGE;


CREATE TABLE CARD
(
	C_NO  NUMBER  NOT NULL ,
	C_TITLE  VARCHAR2(500)  NOT NULL ,
	C_POSITION  NUMBER  NOT NULL ,
	PJT_NO  NUMBER  NOT NULL 
);


ALTER TABLE CARD
	ADD CONSTRAINT  XPK카드 PRIMARY KEY (C_NO);


CREATE TABLE CHAT
(
	CHAT_NO  NUMBER  NOT NULL ,
	CHAT_TITLE  VARCHAR2(500)  NULL ,
	INFO_NO  NUMBER  NOT NULL 
);


ALTER TABLE CHAT
	ADD CONSTRAINT  XPK채팅 PRIMARY KEY (CHAT_NO);


CREATE TABLE CHAT_HISTORY
(
	CHAT_NO  NUMBER  NOT NULL ,
	CHAT_HIS_NO  NUMBER  NOT NULL ,
	CHAT_CONTENTS  VARCHAR2(3000)  NULL 
);


ALTER TABLE CHAT_HISTORY
	ADD CONSTRAINT  XPK대화기록 PRIMARY KEY (CHAT_HIS_NO);


CREATE TABLE CHECKLIST
(
	CHECKLIST_NO  NUMBER  NOT NULL ,
	CHECK_TITLE  VARCHAR2(600)  NULL ,
	P_NO  NUMBER  NOT NULL 
);


ALTER TABLE CHECKLIST
	ADD CONSTRAINT  XPK체크리스트 PRIMARY KEY (CHECKLIST_NO);


CREATE TABLE D_DAY
(
	D_DAY_NO  NUMBER  NOT NULL ,
	D_DATE  DATE  NOT NULL ,
	P_NO  NUMBER  NOT NULL 
);


ALTER TABLE D_DAY
	ADD CONSTRAINT  XPK마감일 PRIMARY KEY (D_DAY_NO);


CREATE TABLE DESCRIPTION
(
	D_NO  NUMBER  NOT NULL ,
	D_CONTENTS  VARCHAR2(3000)  NOT NULL ,
	P_NO  NUMBER  NOT NULL 
);


ALTER TABLE DESCRIPTION
	ADD CONSTRAINT  XPK세부내용 PRIMARY KEY (D_NO);


CREATE TABLE EXTERNAL_M_INFO
(
	EXTER_M_NO  NUMBER  NOT NULL ,
	EXTER_MEM_NAME  VARCHAR2(200)  NOT NULL ,
	EXTER_M_EMAIL  VARCHAR2(100)  NOT NULL ,
	INTERLINKED_INFO_TYPE  VARCHAR2(20)  NOT NULL,
	INTERLINKED_INFO NUMBER NOT NULL
);


ALTER TABLE EXTERNAL_M_INFO
	ADD CONSTRAINT  XPK외부회원정보 PRIMARY KEY (EXTER_M_NO);


CREATE TABLE INTER_M_INFO
(
	MEMBER_NO  NUMBER  NOT NULL ,
	PASSWORD  VARCHAR2(40)  NOT NULL ,
	MEMBER_NAME  VARCHAR2(200)  NOT NULL ,
	EMAIL  VARCHAR2(100)  NOT NULL 
);


ALTER TABLE INTER_M_INFO
	ADD CONSTRAINT  XPK일반회원정보 PRIMARY KEY (MEMBER_NO);


--CREATE TABLE INTERLINKED_INFO
--(
--	INTERLINKED_INFORMATION_NUMBER  CHAR(18)  NOT NULL ,
--	ACCESS_TOKEN  VARCHAR2(200)  NOT NULL ,
--	EXTER_M_NO  NUMBER  NOT NULL ,
--	INTERLINKED_NUMBER  VARCHAR2(20)  NOT NULL 
--);

--ALTER TABLE INTERLINKED_INFO
--	ADD CONSTRAINT  XPK연동정보 PRIMARY KEY (INTERLINKED_NUMBER,EXTER_M_NO);
DROP TABLE TOTAL_MEMBER;

CREATE TABLE TOTAL_MEMBER(TOTAL_M_NO NUMBER, EXTER_M_NO NUMBER, MEMBER_NO NUMBER);

ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT PK_TOTAL_MEM PRIMARY KEY (TOTAL_M_NO);
ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT FK_EXTER_M_INFO FOREIGN KEY(EXTER_M_NO) REFERENCES EXTERNAL_M_INFO(EXTER_M_NO);
ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT FK_INTER_M_INFO FOREIGN KEY(MEMBER_NO) REFERENCES INTER_M_INFO(MEMBER_NO);

GRANT SELECT, INSERT, DELETE, UPDATE ON TOTAL_MEMBER TO kogile ;

CREATE TABLE INVITE
(
	INVITE_NO  NUMBER  NOT NULL ,
	GRADE  VARCHAR2(30) NOT NULL ,
	PJT_NO  NUMBER  NOT NULL ,
	TOTAL_M_NO  NUMBER  NOT NULL 
);


ALTER TABLE INVITE
	ADD CONSTRAINT  XPK초대 PRIMARY KEY (INVITE_NO);


CREATE TABLE LABEL
(
	LABEL_NO  NUMBER  NOT NULL ,
	LABEL_TEXT  VARCHAR2(80)  NULL ,
	COLOR_NO  NUMBER  NOT NULL
);


ALTER TABLE LABEL
	ADD CONSTRAINT  XPK라벨 PRIMARY KEY (LABEL_NO);


CREATE TABLE LIST
(
	LIST_NO  NUMBER  NOT NULL ,
	LIST_INFO  VARCHAR2(1024)  NOT NULL ,
	CHECKED  NUMBER NULL ,
	CHECKLIST_NO  NUMBER  NOT NULL 
);


ALTER TABLE LIST
	ADD CONSTRAINT  XPK리스트 PRIMARY KEY (LIST_NO);


CREATE TABLE NOTICE
(
	NOTICE_NO  NUMBER  NOT NULL ,
	INVITE_NO  NUMBER  NULL ,
	TAG_NO  NUMBER  NOT NULL ,
	NOTICE_CONT  VARCHAR2(1000)  NULL ,
	NOTICE_LIST  VARCHAR2(1000)  NULL ,
	TOTAL_M_NO  NUMBER  NOT NULL 
);


ALTER TABLE NOTICE
	ADD CONSTRAINT  XPK알림 PRIMARY KEY (NOTICE_NO);


CREATE TABLE POST
(
	P_NO  NUMBER  NOT NULL ,
	P_TITLE  VARCHAR2(500)  NOT NULL ,
	P_POSITION  NUMBER  NOT NULL ,
	C_NO  NUMBER  NOT NULL ,
	INFO_NO  NUMBER  NULL,
    LABEL_NO NUMBER NULL
);


ALTER TABLE POST
	ADD CONSTRAINT  XPK포스트 PRIMARY KEY (P_NO);
    
ALTER TABLE POST
    ADD CONSTRAINT LABEL_NO_FK FOREIGN KEY(LABEL_NO)
    REFERENCES LABEL(LABEL_NO);


CREATE TABLE PRJ_INFO
(
	INFO_NO NUMBER NOT NULL,
	INVITE_NO NUMBER NOT NULL
);


ALTER TABLE PRJ_INFO
	ADD CONSTRAINT  PK_PRJ_INFO PRIMARY KEY (INFO_NO);
	
ALTER TABLE PRJ_INFO
	ADD CONSTRAINT FK_INVITE_NO FOREIGN KEY(INVITE_NO)
	REFERENCES INVITE(INVITE_NO);

CREATE TABLE PROJECT
(
	PJT_NO  NUMBER  NOT NULL ,
	PJT_DATE  DATE  NOT NULL ,
	PJT_TITLE  VARCHAR2(500)  NOT NULL 
);


ALTER TABLE PROJECT
	ADD CONSTRAINT  XPK프로젝트 PRIMARY KEY (PJT_NO);


CREATE TABLE REPLY
(
	R_NO  NUMBER  NOT NULL ,
	R_CONTENTS  VARCHAR2(2000)  NOT NULL ,
	R_DATE  DATE  NOT NULL ,
    P_NO  NUMBER  NOT NULL ,	
    INFO_NO  NUMBER  NOT NULL 
);


ALTER TABLE REPLY
	ADD CONSTRAINT  XPK댓글 PRIMARY KEY (R_NO);


CREATE TABLE TAG
(
	TAG_NO  NUMBER  NOT NULL ,
	R_NO  NUMBER  NOT NULL ,
	INFO_NO  NUMBER  NOT NULL 
);


ALTER TABLE TAG
	ADD CONSTRAINT  XPK태그 PRIMARY KEY (TAG_NO);

ALTER TABLE CARD
	ADD (CONSTRAINT  R_57 FOREIGN KEY (PJT_NO) REFERENCES PROJECT(PJT_NO));

ALTER TABLE CHAT
	ADD (CONSTRAINT  R_31 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO));

ALTER TABLE CHAT_HISTORY
	ADD (CONSTRAINT  R_26 FOREIGN KEY (CHAT_NO) REFERENCES CHAT(CHAT_NO));

ALTER TABLE CHECKLIST
	ADD (CONSTRAINT  R_12 FOREIGN KEY (P_NO) REFERENCES POST(P_NO));

ALTER TABLE D_DAY
	ADD (CONSTRAINT  R_14 FOREIGN KEY (P_NO) REFERENCES POST(P_NO));

ALTER TABLE DESCRIPTION
	ADD (CONSTRAINT  R_10 FOREIGN KEY (P_NO) REFERENCES POST(P_NO));

--ALTER TABLE INTERLINKED_INFO
--	ADD (CONSTRAINT  R_21 FOREIGN KEY (EXTER_M_NO) REFERENCES EXTERNAL_M_INFO(EXTER_M_NO));
								 
ALTER TABLE EXTERNAL_M_INFO ADD CONSTRAINT interlinked_info_unique UNIQUE (INTERLINKED_INFO);
								 
ALTER TABLE INVITE
	ADD (CONSTRAINT  R_34 FOREIGN KEY (PJT_NO) REFERENCES PROJECT(PJT_NO));

ALTER TABLE INVITE
	ADD (CONSTRAINT  R_44 FOREIGN KEY (TOTAL_M_NO) REFERENCES TOTAL_MEMBER(TOTAL_M_NO));

ALTER TABLE LIST
	ADD (CONSTRAINT  R_13 FOREIGN KEY (CHECKLIST_NO) REFERENCES CHECKLIST(CHECKLIST_NO));

ALTER TABLE NOTICE
	ADD (CONSTRAINT  R_36 FOREIGN KEY (INVITE_NO) REFERENCES INVITE(INVITE_NO) ON DELETE SET NULL);

ALTER TABLE NOTICE
	ADD (CONSTRAINT  R_37 FOREIGN KEY (TAG_NO) REFERENCES TAG(TAG_NO));

ALTER TABLE NOTICE
	ADD (CONSTRAINT  R_60 FOREIGN KEY (TOTAL_M_NO) REFERENCES TOTAL_MEMBER(TOTAL_M_NO));

ALTER TABLE POST
	ADD (CONSTRAINT  R_5 FOREIGN KEY (C_NO) REFERENCES CARD(C_NO) ON DELETE SET NULL);

ALTER TABLE POST
	ADD (CONSTRAINT  R_50 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO) ON DELETE SET NULL);

ALTER TABLE REPLY
	ADD (CONSTRAINT  R_7 FOREIGN KEY (P_NO) REFERENCES POST(P_NO));

ALTER TABLE REPLY
	ADD (CONSTRAINT  R_51 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO));

ALTER TABLE TAG
	ADD (CONSTRAINT  R_9 FOREIGN KEY (R_NO) REFERENCES REPLY(R_NO));

ALTER TABLE TAG
	ADD (CONSTRAINT  R_52 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO));
    
--drop seq
DROP SEQUENCE CARD_SEQ;
									
DROP SEQUENCE DESCRIPTION_SEQ;
									
DROP SEQUENCE POST_SEQ;
									
DROP SEQUENCE REPLY_SEQ;
									
DROP SEQUENCE TAG_SEQ;

DROP SEQUENCE EXTER_M_NO_SEQ;

DROP SEQUENCE MEM_NO_SEQ;

--DROP SEQUENCE INTERLINKED_SEQ;

DROP SEQUENCE invite_seq;

DROP SEQUENCE notice_seq;

DROP SEQUENCE PJT_NO;

DROP SEQUENCE CHAT_NO;
									
DROP SEQUENCE CHAT_HIS_NO;

DROP SEQUENCE checklist_seq;

DROP SEQUENCE list_seq;

DROP SEQUENCE LABEL_NO_SEQ;

DROP SEQUENCE D_DAY_NO_SEQ;

DROP SEQUENCE TOTAL_M_NO_SEQ;

DROP SEQUENCE INFO_NO_SEQ;

--정철희
CREATE SEQUENCE CARD_SEQ;
									
CREATE SEQUENCE DESCRIPTION_SEQ;
									
CREATE SEQUENCE POST_SEQ;
									
CREATE SEQUENCE REPLY_SEQ;
									
CREATE SEQUENCE TAG_SEQ;

                                                                  
--윤병록					
CREATE SEQUENCE PJT_NO INCREMENT BY 1 START WITH 1 MAXVALUE 100 MINVALUE 1;

CREATE SEQUENCE CHAT_NO INCREMENT BY 1 START WITH 1 MAXVALUE 100 MINVALUE 1;
									
CREATE SEQUENCE CHAT_HIS_NO INCREMENT BY 1 START WITH 1 MAXVALUE 100 MINVALUE 1 ;

--김근열
alter table notice 
  modify invite_no not null;    
  
create sequence invite_seq 
start with 1 increment BY 1 maxvalue 100000;

create sequence notice_seq 
start with 1 increment BY 1 maxvalue 100000;

--황소희
CREATE SEQUENCE EXTER_M_NO_SEQ INCREMENT BY 1;
CREATE SEQUENCE MEM_NO_SEQ INCREMENT BY 1;
--CREATE SEQUENCE INTERLINKED_SEQ INCREMENT BY 1;
									
--TOTAL_NUMBER로 외부회원/내부회원 여부를 확인 후 정보를 가져온다.

create or replace PROCEDURE VIEW_MEMBER_INFORMATION
(
  member_num IN TOTAL_MEMBER.TOTAL_M_NO%TYPE,
  member_email OUT VARCHAR2,
  member_name OUT VARCHAR2
)
IS
  general_member NUMBER;
  external_member NUMBER;
BEGIN
  -- member_num을 받아서 TOTAL_MEMBER테이블에서 external_member, general_member 가져오기.
  SELECT EXTER_M_NO, MEMBER_NO INTO external_member, general_member FROM TOTAL_MEMBER
  WHERE TOTAL_M_NO = member_num;
  
  --TOTAL_NUMBER테이블에서 가져온 external_member로 외부회원정보 조회
  IF external_member IS NOT NULL THEN
    SELECT EXTER_MEM_NAME, EXTER_M_EMAIL INTO member_name, member_email 
    FROM EXTERNAL_M_INFO
    WHERE EXTER_M_NO = external_member;
    
  --TOTAL_NUMBER테이블에서 가져온 general_member로 외부회원정보 조회 
  ELSIF general_member IS NOT NULL THEN
    SELECT MEMBER_NAME, EMAIL INTO member_email, member_name
    FROM INTER_M_INFO
    WHERE MEMBER_NO = general_member;
  END IF;

END VIEW_MEMBER_INFORMATION;
/

--최수춘
create SEQUENCE checklist_seq;
create SEQUENCE list_seq;

--최용락
CREATE SEQUENCE LABEL_NO_SEQ;
CREATE SEQUENCE D_DAY_NO_SEQ;
CREATE SEQUENCE TOTAL_M_NO_SEQ;
CREATE SEQUENCE INFO_NO_SEQ;

--황소희 트리거 추가 19-01-12
-- insert 될때마다 total_member 테이블에도 새 멤버를 insert 해주는 트리거
CREATE OR REPLACE TRIGGER total_m_inst_trg_ext
AFTER
INSERT ON EXTERNAL_M_INFO
FOR EACH ROW
BEGIN
  insert into TOTAL_MEMBER values(TOTAL_M_NO_SEQ.nextval,:new.exter_m_no, null);
END;
/

-- INTER_M_INFO 테이블에 해당
CREATE OR REPLACE TRIGGER total_m_inst_trg_int
AFTER
INSERT ON INTER_M_INFO
FOR EACH ROW
BEGIN
  insert into TOTAL_MEMBER values(TOTAL_M_NO_SEQ.nextval,null, :new.member_no);
END;
/

--TOTAL_M_NO를 받아서 내부회원인지 외부회원인지 판단하는 프로시저
CREATE OR REPLACE PROCEDURE IS_INTER_MEM 
(
  member_num IN NUMBER 
, RET OUT BOOLEAN
) 
IS
  general_member NUMBER;
  external_member NUMBER;
BEGIN
  -- member_num을 받아서 TOTAL_MEMBER테이블에서 external_member, general_member 가져오기.
  SELECT EXTER_M_NO, MEMBER_NO INTO external_member, general_member FROM TOTAL_MEMBER
  WHERE TOTAL_M_NO = member_num;
  
  --외부회원
  IF external_member IS NOT NULL THEN
  ret := false;    
  --내부회원 
  ELSIF general_member IS NOT NULL THEN
  ret := true;
  ELSE
  DBMS_OUTPUT.PUT_LINE('error!');
  END IF;
END IS_INTER_MEM;
/
-- 외부회원 정보
INSERT INTO EXTERNAL_M_INFO VALUES(EXTER_M_NO_SEQ.nextval, '회원1', 'sohee@naver.com', 'naver', 343434343);
INSERT INTO EXTERNAL_M_INFO VALUES(EXTER_M_NO_SEQ.nextval, '회원2', 'sohyun@google.com', 'google', 3434343);
INSERT INTO EXTERNAL_M_INFO VALUES(EXTER_M_NO_SEQ.nextval, '회원3', 'ppoppy@kakao.co.kr', 'kakao', 43434343);

-- 내부회원 정보 
INSERT INTO INTER_M_INFO VALUES(MEM_NO_SEQ.nextval, 'qlalfqjsgh3#', '회원4', 'sohyun@kogile.com');
INSERT INTO INTER_M_INFO VALUES(MEM_NO_SEQ.nextval, '21341234', '회원5', 'ppoppy@kogile.com');
INSERT INTO INTER_M_INFO VALUES(MEM_NO_SEQ.nextval, 'ghkdthgus', '회원6', 'Hwang_bee@kogile.com');

-- 연동정보 <!-- 시퀀스 넣기! -->
-- 연동정보와 회원번호는 PK가 된다. 
--INSERT INTO INTERLINKED_INFO VALUES(INTERLINKED_SEQ.nextval, 'fjdhejfkdekfndkenfkFEFDEFFFd', 1, 'naver');
--INSERT INTO INTERLINKED_INFO VALUES(INTERLINKED_SEQ.nextval, 'fGfEfdfdEEfDFFEFDFEFDFkenfkd', 2, 'google');
--INSERT INTO INTERLINKED_INFO VALUES(INTERLINKED_SEQ.nextval, 'fjdhejfkdEJNFJENKekfndkenfkd', 3, 'kakao');

-- 전체회원 정보 <후에 자동으로 넣어줘야함.>
--INSERT INTO TOTAL_MEMBER VALUES(TOTAL_M_NO_SEQ.nextval, 1, null);
--INSERT INTO TOTAL_MEMBER VALUES(TOTAL_M_NO_SEQ.nextval, 2, null);
--INSERT INTO TOTAL_MEMBER VALUES(TOTAL_M_NO_SEQ.nextval, 3, null);
--INSERT INTO TOTAL_MEMBER VALUES(TOTAL_M_NO_SEQ.nextval, null, 1);
--INSERT INTO TOTAL_MEMBER VALUES(TOTAL_M_NO_SEQ.nextval, null, 2);
--INSERT INTO TOTAL_MEMBER VALUES(TOTAL_M_NO_SEQ.nextval, null, 3);



--PROJECT
INSERT INTO PROJECT VALUES (pjt_no.nextval, sysdate , 'kostaProject');
INSERT INTO PROJECT VALUES (pjt_no.nextval, sysdate , 'kepcoProject');
INSERT INTO PROJECT VALUES (pjt_no.nextval, sysdate , 'motorshowProject');



--INVITE
INSERT INTO INVITE VALUES(INVITE_SEQ.nextval, 'master', 1, 1);
INSERT INTO INVITE VALUES(INVITE_SEQ.nextval, 'manager', 1, 2);
INSERT INTO INVITE VALUES(INVITE_SEQ.nextval, 'nomal', 1, 3);



--CARD
INSERT INTO card VALUES (card_seq.nextval,'To Do',1,1);
INSERT INTO card VALUES (card_seq.nextval,'Doing',2,1);
INSERT INTO card VALUES (card_seq.nextval,'Done',3,1);
INSERT INTO card VALUES (card_seq.nextval,'Close',4,1);



--PRJ_INFO
INSERT INTO PRJ_INFO VALUES(INFO_NO_SEQ.NEXTVAL,1);
INSERT INTO PRJ_INFO VALUES(INFO_NO_SEQ.NEXTVAL,2);
INSERT INTO PRJ_INFO VALUES(INFO_NO_SEQ.NEXTVAL,3);

--LABEL
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'빨강',1);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'주황',2);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'노랑',3);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'초록',4);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'빨강',1);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'주황',2);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'노랑',3);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'초록',4);



--POST
INSERT INTO post VALUES (post_seq.nextval,'포스트1-1',1,1,1,1);
INSERT INTO post VALUES (post_seq.nextval,'포스트2-1',1,2,2,2);
INSERT INTO post VALUES (post_seq.nextval,'포스트3-1',1,3,1,3);
INSERT INTO post VALUES (post_seq.nextval,'포스트4-1',1,4,2,4);
INSERT INTO post VALUES (post_seq.nextval,'포스트1-2',2,1,1,1);
INSERT INTO post VALUES (post_seq.nextval,'포스트2-2',2,2,2,2);
INSERT INTO post VALUES (post_seq.nextval,'포스트3-2',2,3,1,3);
INSERT INTO post VALUES (post_seq.nextval,'포스트4-2',2,4,2,4);




--DESCRIPTION
INSERT INTO description VALUES (description_seq.nextval,'포스트1-1에 대한 설명',1);
INSERT INTO description VALUES (description_seq.nextval,'포스트2-1에 대한 설명',2);
INSERT INTO description VALUES (description_seq.nextval,'포스트3-1에 대한 설명',3);
INSERT INTO description VALUES (description_seq.nextval,'포스트4-1에 대한 설명',4);
INSERT INTO description VALUES (description_seq.nextval,'포스트1-2에 대한 설명',5);
INSERT INTO description VALUES (description_seq.nextval,'포스트2-2에 대한 설명',6);
INSERT INTO description VALUES (description_seq.nextval,'포스트3-2에 대한 설명',7);
INSERT INTO description VALUES (description_seq.nextval,'포스트4-2에 대한 설명',8);




--reply
INSERT INTO reply VALUES (reply_seq.nextval,'포스트1-1에 대한 설명의 댓글',sysdate,1,1);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트2-1에 대한 설명의 댓글',sysdate,2,2);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트3-1에 대한 설명의 댓글',sysdate,3,1);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트4-1에 대한 설명의 댓글',sysdate,4,2);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트1-2에 대한 설명의 댓글',sysdate,5,1);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트2-2에 대한 설명의 댓글',sysdate,6,2);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트3-2에 대한 설명의 댓글',sysdate,7,1);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트4-2에 대한 설명의 댓글',sysdate,8,2);






--TAG
INSERT INTO tag VALUES (TAG_SEQ.nextval,'1',1);
INSERT INTO tag VALUES (TAG_SEQ.nextval,'2',2);
INSERT INTO tag VALUES (TAG_SEQ.nextval,'3',1);
INSERT INTO tag VALUES (TAG_SEQ.nextval,'4',2);
INSERT INTO tag VALUES (TAG_SEQ.nextval,'5',1);
INSERT INTO tag VALUES (TAG_SEQ.nextval,'6',2);
INSERT INTO tag VALUES (TAG_SEQ.nextval,'7',1);
INSERT INTO tag VALUES (TAG_SEQ.nextval,'8',2);



--D-DAY
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190220', 'YYYYMMDD'),1);
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190320', 'YYYYMMDD'),2);
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190420', 'YYYYMMDD'),3);
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190520', 'YYYYMMDD'),4);
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190620', 'YYYYMMDD'),5);
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190720', 'YYYYMMDD'),6);
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190820', 'YYYYMMDD'),7);
INSERT INTO d_day VALUES (D_DAY_NO_SEQ.nextval,TO_DATE('20190920', 'YYYYMMDD'),8);






--CHECKLIST
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트1-1 체크리스트1',1);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트1-1 체크리스트2',1);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트2-1 체크리스트1',2);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트2-1 체크리스트2',2);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트3-1 체크리스트1',3);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트3-1 체크리스트2',3);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트4-1 체크리스트1',4);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트4-1 체크리스트2',4);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트1-2 체크리스트1',5);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트1-2 체크리스트2',5);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트2-2 체크리스트1',6);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트2-2 체크리스트2',6);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트3-2 체크리스트1',7);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트3-2 체크리스트2',7);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트4-2 체크리스트1',8);
INSERT INTO checklist VALUES (CHECKLIST_SEQ.nextval,'포스트4-2 체크리스트2',8);






--LIST
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명1',null,1);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명2',null,2);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명3',null,3);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명4',null,4);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명5',null,5);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명6',null,6);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명7',null,7);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명8',null,8);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명9',null,9);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명10',null,10);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명11',null,11);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명12',null,12);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명13',null,13);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명14',null,14);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명15',null,15);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명16',null,16);





--NOTICE
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,1,1,'빨리','뭔데이거',1);
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,1,1,'초대알림','ㅇㅇㅇ',2);
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,1,1,'알림미','식단알리미',3);
INSERT INTO NOTICE VALUES(NOTICE_SEQ.NEXTVAL,1,1,'ㄱㄱ','렛잇거',4);

--윤병록 20190114
alter table project
add (pjt_writer varchar2(20));

alter table project 
add (pjt_contents varchar2(200));
