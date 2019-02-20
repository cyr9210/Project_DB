--기존 테이블 제거

DROP TABLE LABEL CASCADE CONSTRAINTS PURGE;
DROP TABLE LIST CASCADE CONSTRAINTS PURGE;
DROP TABLE CHECKLIST CASCADE CONSTRAINTS PURGE;
--DROP TABLE INTERLINKED_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE NOTICE CASCADE CONSTRAINTS PURGE;
DROP TABLE TAG CASCADE CONSTRAINTS PURGE;
DROP TABLE REPLY CASCADE CONSTRAINTS PURGE;
DROP TABLE POST CASCADE CONSTRAINTS PURGE;
DROP TABLE PRJ_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE INTER_M_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE CARD CASCADE CONSTRAINTS PURGE;
DROP TABLE INVITE CASCADE CONSTRAINTS PURGE;
DROP TABLE EXTERNAL_M_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE PROJECT CASCADE CONSTRAINTS PURGE;
DROP TABLE LABEL_INFO CASCADE CONSTRAINTS PURGE;
DROP TABLE CHARGE_INFO CASCADE CONSTRAINTS PURGE;



CREATE TABLE CARD
(
	C_NO  NUMBER  NOT NULL ,
	C_TITLE  VARCHAR2(500)  NOT NULL ,
	C_POSITION  NUMBER  NOT NULL ,
	PJT_NO  NUMBER  NOT NULL 
);


ALTER TABLE CARD
	ADD CONSTRAINT  XPK카드 PRIMARY KEY (C_NO);



CREATE TABLE CHECKLIST
(
	CHECKLIST_NO  NUMBER  NOT NULL ,
	CHECK_TITLE  VARCHAR2(600)  NULL ,
	P_NO  NUMBER  NOT NULL 
);


ALTER TABLE CHECKLIST
	ADD CONSTRAINT  XPK체크리스트 PRIMARY KEY (CHECKLIST_NO);





CREATE TABLE EXTERNAL_M_INFO
(
	EXTER_M_NO  NUMBER  NOT NULL ,
	EXTER_MEM_NAME  VARCHAR2(200)  NOT NULL ,
	EXTER_M_EMAIL  VARCHAR2(100)  NOT NULL ,
	INTERLINKED_INFO_TYPE  VARCHAR2(20)  NOT NULL,
	INTERLINKED_INFO NUMBER NOT NULL,
	ACCESS_TOKEN VARCHAR2(200) NOT NULL
);


ALTER TABLE EXTERNAL_M_INFO
	ADD CONSTRAINT  XPK외부회원정보 PRIMARY KEY (EXTER_M_NO);


CREATE TABLE INTER_M_INFO
(
	MEMBER_NO  NUMBER  NOT NULL ,
	PASSWORD  VARCHAR2(70)  NOT NULL ,
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
ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT FK_EXTER_M_INFO FOREIGN KEY(EXTER_M_NO) REFERENCES EXTERNAL_M_INFO(EXTER_M_NO)on DELETE CASCADE;
ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT FK_INTER_M_INFO FOREIGN KEY(MEMBER_NO) REFERENCES INTER_M_INFO(MEMBER_NO)on DELETE CASCADE;

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
	COLOR_NO  NUMBER  NOT NULL ,
    PJT_NO NUMBER NOT NULL
);


ALTER TABLE LABEL
	ADD CONSTRAINT  XPK라벨 PRIMARY KEY (LABEL_NO);



CREATE TABLE LIST
(
	LIST_NO  NUMBER  NOT NULL ,
	LIST_INFO  VARCHAR2(1024)  NOT NULL ,
	CHECKED  NUMBER DEFAULT(0) NOT NULL,
	CHECKLIST_NO  NUMBER  NOT NULL 
);


ALTER TABLE LIST
	ADD CONSTRAINT  XPK리스트 PRIMARY KEY (LIST_NO);


CREATE TABLE NOTICE
(
   NOTICE_NO  NUMBER  NOT NULL ,
   INVITE_NO  NUMBER  NULL ,
   TAG_NO  NUMBER NULL ,
   NTC_CONT  VARCHAR2(1000)  NULL ,
   NTC_DATE DATE NULL,
   TOTAL_M_NO  NUMBER  NOT NULL 
);


ALTER TABLE NOTICE
	ADD CONSTRAINT  XPK알림 PRIMARY KEY (NOTICE_NO);


CREATE TABLE POST
(
	P_NO  NUMBER  NOT NULL ,
	P_TITLE  VARCHAR2(500)  NOT NULL ,
	P_POSITION  NUMBER  NOT NULL ,
	C_NO  NUMBER  NOT NULL,
    P_DESCRIPTION VARCHAR2(1000) NULL,
    P_DDAY DATE NULL
);


ALTER TABLE POST
	ADD CONSTRAINT  XPK포스트 PRIMARY KEY (P_NO);


CREATE TABLE LABEL_INFO
(LABEL_INFO_NO NUMBER NOT NULL,
LABEL_NO NUMBER NOT NULL,
P_NO NUMBER NOT NULL);

ALTER TABLE LABEL_INFO
    ADD CONSTRAINT LABEL_INFO_NO_PK PRIMARY KEY(LABEL_INFO_NO);
    
ALTER TABLE LABEL_INFO
    ADD CONSTRAINT LABEL_NO_FK FOREIGN KEY(LABEL_NO)
    REFERENCES LABEL(LABEL_NO)on DELETE CASCADE;
    
ALTER TABLE LABEL_INFO
    ADD CONSTRAINT P_NO_FK FOREIGN KEY(P_NO)
    REFERENCES POST(P_NO)on DELETE CASCADE;
    
ALTER TABLE LABEL_INFO
    ADD CONSTRAINT PNO_LNO_UNIQUE UNIQUE(P_NO, LABEL_NO);
    
CREATE TABLE PRJ_INFO
(
	INFO_NO NUMBER NOT NULL,
	INVITE_NO NUMBER NOT NULL
);

ALTER TABLE PRJ_INFO
	ADD CONSTRAINT  PK_PRJ_INFO PRIMARY KEY (INFO_NO);
	
ALTER TABLE PRJ_INFO
	ADD CONSTRAINT FK_INVITE_NO FOREIGN KEY(INVITE_NO)
	REFERENCES INVITE(INVITE_NO)on DELETE CASCADE;
    
    
    
CREATE TABLE CHARGE_INFO
(CHARGE_INFO_NO NUMBER NOT NULL,
INFO_NO NUMBER NOT NULL,
P_NO NUMBER NOT NULL
);

ALTER TABLE CHARGE_INFO
    ADD CONSTRAINT CHARGE_INFO_PK PRIMARY KEY(CHARGE_INFO_NO);
    
ALTER TABLE CHARGE_INFO
    ADD CONSTRAINT INFO_NO_FK FOREIGN KEY(INFO_NO)
    REFERENCES PRJ_INFO(INFO_NO)on DELETE CASCADE;
    
ALTER TABLE CHARGE_INFO
    ADD CONSTRAINT CHARGE_P_NO_FK FOREIGN KEY(P_NO)
    REFERENCES POST(P_NO)on DELETE CASCADE;
    
ALTER TABLE CHARGE_INFO
    ADD CONSTRAINT INO_PNO_UNIQUE UNIQUE(INFO_NO, P_NO);


CREATE TABLE PROJECT
(
	PJT_NO  NUMBER  NOT NULL ,
	PJT_DATE  DATE  NOT NULL ,
	PJT_TITLE  VARCHAR2(500)  NOT NULL 
);


ALTER TABLE PROJECT
	ADD CONSTRAINT  XPK프로젝트 PRIMARY KEY (PJT_NO);

--윤병록 20190114
alter table project
add (total_m_no number not null);

alter table project
add constraint pjt_total_m_no_fk foreign key(total_m_no)
references total_member(total_m_no) on delete cascade;

alter table project 
add (pjt_contents varchar2(200));

CREATE TABLE REPLY
(
	R_NO  NUMBER  NOT NULL ,
	R_CONTENTS  VARCHAR2(2000)  NOT NULL ,
	R_DATE  DATE  NOT NULL ,
    P_NO  NUMBER  NOT NULL ,	
    INFO_NO  NUMBER  NOT NULL ,
    TAGED_NAME VARCHAR2(50)
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
	ADD (CONSTRAINT  R_57 FOREIGN KEY (PJT_NO) REFERENCES PROJECT(PJT_NO)on DELETE CASCADE);


ALTER TABLE CHECKLIST
	ADD (CONSTRAINT  R_12 FOREIGN KEY (P_NO) REFERENCES POST(P_NO)on DELETE CASCADE);


--ALTER TABLE INTERLINKED_INFO
--	ADD (CONSTRAINT  R_21 FOREIGN KEY (EXTER_M_NO) REFERENCES EXTERNAL_M_INFO(EXTER_M_NO));
								 
ALTER TABLE EXTERNAL_M_INFO ADD CONSTRAINT interlinked_info_unique UNIQUE (INTERLINKED_INFO);
								 
ALTER TABLE INVITE
	ADD (CONSTRAINT  R_34 FOREIGN KEY (PJT_NO) REFERENCES PROJECT(PJT_NO)on DELETE CASCADE);

ALTER TABLE INVITE
	ADD (CONSTRAINT  R_44 FOREIGN KEY (TOTAL_M_NO) REFERENCES TOTAL_MEMBER(TOTAL_M_NO)on DELETE CASCADE);


ALTER TABLE LIST
	ADD (CONSTRAINT  R_13 FOREIGN KEY (CHECKLIST_NO) REFERENCES CHECKLIST(CHECKLIST_NO)on DELETE CASCADE);

ALTER TABLE NOTICE
	ADD (CONSTRAINT  R_36 FOREIGN KEY (INVITE_NO) REFERENCES INVITE(INVITE_NO) ON DELETE CASCADE);

ALTER TABLE NOTICE
	ADD (CONSTRAINT  R_37 FOREIGN KEY (TAG_NO) REFERENCES TAG(TAG_NO)on DELETE CASCADE);

ALTER TABLE NOTICE
	ADD (CONSTRAINT  R_60 FOREIGN KEY (TOTAL_M_NO) REFERENCES TOTAL_MEMBER(TOTAL_M_NO)on DELETE CASCADE);

ALTER TABLE POST
	ADD (CONSTRAINT  R_5 FOREIGN KEY (C_NO) REFERENCES CARD(C_NO) ON DELETE CASCADE);

ALTER TABLE REPLY
	ADD (CONSTRAINT  R_7 FOREIGN KEY (P_NO) REFERENCES POST(P_NO)on DELETE CASCADE);

ALTER TABLE REPLY
	ADD (CONSTRAINT  R_51 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO)on DELETE CASCADE);

ALTER TABLE TAG
	ADD (CONSTRAINT  R_9 FOREIGN KEY (R_NO) REFERENCES REPLY(R_NO)on DELETE CASCADE);

ALTER TABLE TAG
	ADD (CONSTRAINT  R_52 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO)on DELETE CASCADE);
    
ALTER TABLE LABEL
    ADD CONSTRAINT PJT_NO_FK FOREIGN KEY(PJT_NO)
    REFERENCES PROJECT(PJT_NO)on DELETE CASCADE;
    
--drop seq
DROP SEQUENCE CARD_SEQ;
									
DROP SEQUENCE POST_SEQ;
									
DROP SEQUENCE REPLY_SEQ;
									
DROP SEQUENCE TAG_SEQ;

DROP SEQUENCE EXTER_M_NO_SEQ;

DROP SEQUENCE MEM_NO_SEQ;

--DROP SEQUENCE INTERLINKED_SEQ;

DROP SEQUENCE invite_seq;

DROP SEQUENCE notice_seq;

DROP SEQUENCE PJT_NO;

DROP SEQUENCE checklist_seq;

DROP SEQUENCE list_seq;

DROP SEQUENCE LABEL_NO_SEQ;

DROP SEQUENCE TOTAL_M_NO_SEQ;

DROP SEQUENCE INFO_NO_SEQ;

DROP SEQUENCE LABEL_INFO_NO_SEQ;

DROP SEQUENCE CHARGE_INFO_NO_SEQ;

--정철희
CREATE SEQUENCE CARD_SEQ INCREMENT BY 4;
									
									
CREATE SEQUENCE POST_SEQ;
									
CREATE SEQUENCE REPLY_SEQ;
									
CREATE SEQUENCE TAG_SEQ;

                                                                  
--윤병록					
CREATE SEQUENCE PJT_NO INCREMENT BY 1 START WITH 1 MAXVALUE 100 MINVALUE 1;

--김근열
  
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
CREATE SEQUENCE CHARGE_INFO_NO_SEQ;
CREATE SEQUENCE LABEL_INFO_NO_SEQ;
CREATE SEQUENCE LABEL_NO_SEQ;
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
INSERT INTO EXTERNAL_M_INFO VALUES(EXTER_M_NO_SEQ.nextval, '회원1', 'sohee@naver.com', 'naver', 343434343, 'gg');
INSERT INTO EXTERNAL_M_INFO VALUES(EXTER_M_NO_SEQ.nextval, '회원2', 'sohyun@google.com', 'google', 3434343, 'gg');
INSERT INTO EXTERNAL_M_INFO VALUES(EXTER_M_NO_SEQ.nextval, '회원3', 'ppoppy@kakao.co.kr', 'kakao', 43434343, 'gg');

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
INSERT INTO PROJECT VALUES (pjt_no.nextval, sysdate , 'kostaProject', 1, 'fff');
INSERT INTO PROJECT VALUES (pjt_no.nextval, sysdate , 'kepcoProject', 1, 'fff');
INSERT INTO PROJECT VALUES (pjt_no.nextval, sysdate , 'motorshowProject', 1, 'fff');



--INVITE
INSERT INTO INVITE VALUES(INVITE_SEQ.nextval, 'master', 1, 1);
INSERT INTO INVITE VALUES(INVITE_SEQ.nextval, 'normal', 1, 2);
INSERT INTO INVITE VALUES(INVITE_SEQ.nextval, 'normal', 1, 3);



--CARD
insert all
into card values(card_seq.nextval, 'To Do', 1, 1)
into card values(card_seq.nextval+1, 'Doing', 2, 1)
into card values(card_seq.nextval+2, 'Done', 3, 1)
into card values(card_seq.nextval+3,'Close', 4, 1)
select * from dual;



--PRJ_INFO
INSERT INTO PRJ_INFO VALUES(INFO_NO_SEQ.NEXTVAL,1);
INSERT INTO PRJ_INFO VALUES(INFO_NO_SEQ.NEXTVAL,2);
INSERT INTO PRJ_INFO VALUES(INFO_NO_SEQ.NEXTVAL,3);



--POST
INSERT INTO post VALUES (post_seq.nextval,'포스트1-1',1,1,'포스트1-1에 대한 설명',TO_DATE('20190220', 'YYYYMMDD'));
INSERT INTO post VALUES (post_seq.nextval,'포스트2-1',1,2,'포스트2-1에 대한 설명', TO_DATE('20190220', 'YYYYMMDD'));
INSERT INTO post VALUES (post_seq.nextval,'포스트3-1',1,3, '포스트3-1에 대한 설명', TO_DATE('20190320', 'YYYYMMDD'));
INSERT INTO post VALUES (post_seq.nextval,'포스트4-1',1,4, '포스트4-1에 대한 설명', TO_DATE('20190520', 'YYYYMMDD'));
INSERT INTO post VALUES (post_seq.nextval,'포스트1-2',2,1, '포스트1-2에 대한 설명', TO_DATE('20190620', 'YYYYMMDD'));
INSERT INTO post VALUES (post_seq.nextval,'포스트2-2',2,2, '포스트2-2에 대한 설명', TO_DATE('20190820', 'YYYYMMDD'));
INSERT INTO post VALUES (post_seq.nextval,'포스트3-2',2,3, '포스트3-2에 대한 설명', TO_DATE('20190720', 'YYYYMMDD'));
INSERT INTO post VALUES (post_seq.nextval,'포스트4-2',2,4, '포스트4-2에 대한 설명', TO_DATE('20190920', 'YYYYMMDD'));





--reply
INSERT INTO reply VALUES (reply_seq.nextval,'포스트1-1에 대한 설명의 댓글',sysdate,1,1,'회원2');
INSERT INTO reply VALUES (reply_seq.nextval,'포스트2-1에 대한 설명의 댓글',sysdate,2,2,'회원1');
INSERT INTO reply VALUES (reply_seq.nextval,'포스트3-1에 대한 설명의 댓글',sysdate,3,1,'회원2');
INSERT INTO reply VALUES (reply_seq.nextval,'포스트4-1에 대한 설명의 댓글',sysdate,4,2,'회원1');
INSERT INTO reply VALUES (reply_seq.nextval,'포스트1-2에 대한 설명의 댓글',sysdate,5,1,null);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트2-2에 대한 설명의 댓글',sysdate,6,2,null);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트3-2에 대한 설명의 댓글',sysdate,7,1,null);
INSERT INTO reply VALUES (reply_seq.nextval,'포스트4-2에 대한 설명의 댓글',sysdate,8,2,null);






--TAG
INSERT INTO tag VALUES (TAG_SEQ.nextval,1,2);
INSERT INTO tag VALUES (TAG_SEQ.nextval,2,1);
INSERT INTO tag VALUES (TAG_SEQ.nextval,3,2);
INSERT INTO tag VALUES (TAG_SEQ.nextval,4,1);






--LABEL
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'빨강',1,1);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'주황',2,1);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'노랑',3,1);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'초록',4,1);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'빨강',1,2);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'주황',2,2);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'노랑',3,2);
INSERT INTO label VALUES (LABEL_NO_SEQ.nextval,'초록',4,2);









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
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명1',0,1);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명2',0,2);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명3',0,3);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명4',0,4);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명5',0,5);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명6',0,6);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명7',0,7);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명8',0,8);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명9',0,9);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명10',0,10);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명11',0,11);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명12',0,12);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명13',0,13);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명14',0,14);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명15',0,15);
INSERT INTO list VALUES (LIST_SEQ.nextval,'리스트설명16',0,16);





--NOTICE
INSERT INTO NOTICE(NOTICE_NO, INVITE_NO, NTC_CONT, NTC_DATE, TOTAL_M_NO) VALUES(NOTICE_SEQ.NEXTVAL, 1, '초대됐음!', SYSDATE, 1);
INSERT INTO NOTICE(NOTICE_NO, TAG_NO, NTC_CONT, NTC_DATE, TOTAL_M_NO) VALUES(NOTICE_SEQ.NEXTVAL, 2, '태그됐음!', SYSDATE, 2);

INSERT INTO NOTICE(NOTICE_NO, INVITE_NO, NTC_CONT, NTC_DATE, TOTAL_M_NO) VALUES(NOTICE_SEQ.NEXTVAL, 3, '초대됐음!', SYSDATE, 5);

--LABEL_INFO
INSERT INTO LABEL_INFO VALUES(LABEL_INFO_NO_SEQ.NEXTVAL,1,1);
INSERT INTO LABEL_INFO VALUES(LABEL_INFO_NO_SEQ.NEXTVAL,1,2);
INSERT INTO LABEL_INFO VALUES(LABEL_INFO_NO_SEQ.NEXTVAL,3,1);

--CHARGE_INFO
INSERT INTO CHARGE_INFO VALUES(CHARGE_INFO_NO_SEQ.NEXTVAL,1,1);
INSERT INTO CHARGE_INFO VALUES(CHARGE_INFO_NO_SEQ.NEXTVAL,2,1);
INSERT INTO CHARGE_INFO VALUES(CHARGE_INFO_NO_SEQ.NEXTVAL,3,1);

			   
--최용락 20190116
ALTER TABLE LABEL
    ADD CONSTRAINT PJTNO_LTEXT_CNO_UNIQUE UNIQUE(LABEL_TEXT, COLOR_NO, PJT_NO);
			   
--김준형 20190116
INSERT INTO INVITE VALUES (INVITE_SEQ.NEXTVAL, 'NORMAL', 1, 4);
INSERT INTO INVITE VALUES (INVITE_SEQ.NEXTVAL, 'NORMAL', 1, 5);
INSERT INTO INVITE VALUES (INVITE_SEQ.NEXTVAL, 'NORMAL', 1, 6);
			   
INSERT INTO PRJ_INFO VALUES (INFO_NO_SEQ.NEXTVAL,4);
INSERT INTO PRJ_INFO VALUES (INFO_NO_SEQ.NEXTVAL,5);
INSERT INTO PRJ_INFO VALUES (INFO_NO_SEQ.NEXTVAL,6);

--최용락 20190120
insert all
into card values(card_seq.nextval, 'To Do', 1, 2)
into card values(card_seq.nextval+1, 'Doing', 2, 2)
into card values(card_seq.nextval+2, 'Done', 3, 2)
into card values(card_seq.nextval+3,'Close', 4, 2)
select * from dual;

insert all
into card values(card_seq.nextval, 'To Do', 1, 3)
into card values(card_seq.nextval+1, 'Doing', 2, 3)
into card values(card_seq.nextval+2, 'Done', 3, 3)
into card values(card_seq.nextval+3,'Close', 4, 3)
select * from dual;
			   
--김근열 20190122
alter table invite
add constraint pno_ino_unique unique(pjt_no, total_m_no);

--20190207 DB수정
/*DROP SEQUENCE DESCRIPTION_SEQ;
drop table description cascade constraints purge;
DROP SEQUENCE D_DAY_NO_SEQ;
DROP TABLE CHAT CASCADE CONSTRAINTS PURGE;
DROP TABLE CHAT_HISTORY CASCADE CONSTRAINTS PURGE;
DROP TABLE CHAT_HISTORY CASCADE CONSTRAINTS PURGE;
DROP TABLE CHAT CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE CHAT_NO;							
DROP SEQUENCE CHAT_HIS_NO;*/
		
--공지사항게시판 테이블 20190208
DROP TABLE BOARD CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE BOARD_SEQ;

CREATE SEQUENCE BOARD_SEQ;

CREATE TABLE BOARD(
B_NO NUMBER NOT NULL,
B_TITLE VARCHAR2(100) NOT NULL,
B_CONTENT VARCHAR2(1000) NOT NULL,
INFO_NO NUMBER NOT NULL,
FNAME VARCHAR2(400) NULL,
REGDATE DATE DEFAULT SYSDATE NOT NULL,
UPDATE_DATE DATE DEFAULT SYSDATE NOT NULL);

ALTER TABLE BOARD
ADD CONSTRAINT BOARD_BNO_PK PRIMARY KEY(B_NO);

ALTER TABLE BOARD
ADD CONSTRAINT BOARD_INFONO_FK FOREIGN KEY(INFO_NO)
REFERENCES PRJ_INFO(INFO_NO) ON DELETE CASCADE;

---- 두개의 테이블에서 name, email가져오는 쿼리 예제
-- where절 없으면 전체 멤버 조회하게됨
/*(SELECT
memberno, email, name
FROM
INTERNAL_M_INFO
WHERE memberno = 2)
UNION
(SELECT
memberno, email, name
FROM
EXTERNAL_M_INFO
WHERE memberno = 2
);*/

-- 2019 02 08 황소희 채팅내역 테이블
DROP TABLE tbl_chat CASCADE CONSTRAINTS PURGE;
CREATE TABLE tbl_chat(
        chat_no number,
        pjt_no number,
	total_m_no number,
        writer varchar2(20),
        chatContents varchar2(2000),
        regDate date
        );
DROP SEQUENCE chat_no_seq;
CREATE SEQUENCE chat_no_seq;

/*ALTER TABLE tbl_chat DROP CONSTRAINT tbl_chat_pk;
ALTER TABLE tbl_chat DROP CONSTRAINT tbl_chat_fk;*/

ALTER TABLE tbl_chat add CONSTRAINT tbl_chat_pk PRIMARY KEY (chat_no);
ALTER TABLE tbl_chat ADD CONSTRAINT tbl_chat_fk FOREIGN KEY (pjt_no) REFERENCES project(pjt_no)on delete cascade;

-- 2019 02 08 황소희 프로젝트별 채팅 개수 관리 테이블
DROP TABLE tbl_chat_cnt;
CREATE TABLE tbl_chat_cnt(
  pjt_no number,
  chat_cnt number
);

/*ALTER TABLE tbl_chat_cnt DROP CONSTRAINT tbl_chatCnt_pk;
ALTER TABLE tbl_chat_cnt DROP CONSTRAINT tbl_chatCnt_fk;*/

ALTER TABLE tbl_chat_cnt add CONSTRAINT tbl_chatCnt_pk PRIMARY KEY (pjt_no);
ALTER TABLE tbl_chat_cnt ADD CONSTRAINT tbl_chatCnt_fk FOREIGN KEY (pjt_no) REFERENCES project(pjt_no)on delete cascade;
