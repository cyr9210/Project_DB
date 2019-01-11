--기존 테이블 제거

DROP TABLE LABEL CASCADE CONSTRAINTS PURGE;
DROP TABLE LIST CASCADE CONSTRAINTS PURGE;
DROP TABLE CHECKLIST CASCADE CONSTRAINTS PURGE;
DROP TABLE D_DAY CASCADE CONSTRAINTS PURGE;
DROP TABLE INTERLINKED_INFO CASCADE CONSTRAINTS PURGE;
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
	INTERLINKED_INFO_NUM  VARCHAR2(20)  NULL 
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


CREATE TABLE INTERLINKED_INFO
(
	INTERLINKED_INFORMATION_NUMBER  CHAR(18)  NOT NULL ,
	ACCESS_TOKEN  VARCHAR2(200)  NOT NULL ,
	EXTER_M_NO  NUMBER  NOT NULL ,
	INTERLINKED_NUMBER  VARCHAR2(20)  NOT NULL 
);

ALTER TABLE INTERLINKED_INFO
	ADD CONSTRAINT  XPK연동정보 PRIMARY KEY (INTERLINKED_NUMBER,EXTER_M_NO);
DROP TABLE TOTAL_MEMBER;

CREATE TABLE TOTAL_MEMBER(TOTAL_M_NO NUMBER, EXTER_M_NO NUMBER, MEMBER_NO NUMBER);

ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT PK_TOTAL_MEM PRIMARY KEY (TOTAL_M_NO);
ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT FK_EXTER_M_INFO FOREIGN KEY(EXTER_M_NO) REFERENCES EXTERNAL_M_INFO(EXTER_M_NO);
ALTER TABLE TOTAL_MEMBER ADD CONSTRAINT FK_INTER_M_INFO FOREIGN KEY(MEMBER_NO) REFERENCES INTER_M_INFO(MEMBER_NO);

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
	P_NO  NUMBER  NOT NULL 
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
	INFO_NO  NUMBER  NULL 
);


ALTER TABLE POST
	ADD CONSTRAINT  XPK포스트 PRIMARY KEY (P_NO);


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
	D_NO  NUMBER  NOT NULL ,
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

ALTER TABLE INTERLINKED_INFO
	ADD (CONSTRAINT  R_21 FOREIGN KEY (EXTER_M_NO) REFERENCES EXTERNAL_M_INFO(EXTER_M_NO));

ALTER TABLE INVITE
	ADD (CONSTRAINT  R_34 FOREIGN KEY (PJT_NO) REFERENCES PROJECT(PJT_NO));

ALTER TABLE INVITE
	ADD (CONSTRAINT  R_44 FOREIGN KEY (TOTAL_M_NO) REFERENCES TOTAL_MEMBER(TOTAL_M_NO));

ALTER TABLE LABEL
	ADD (CONSTRAINT  R_11 FOREIGN KEY (P_NO) REFERENCES POST(P_NO));

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
	ADD (CONSTRAINT  R_7 FOREIGN KEY (D_NO) REFERENCES DESCRIPTION(D_NO));

ALTER TABLE REPLY
	ADD (CONSTRAINT  R_51 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO));

ALTER TABLE TAG
	ADD (CONSTRAINT  R_9 FOREIGN KEY (R_NO) REFERENCES REPLY(R_NO));

ALTER TABLE TAG
	ADD (CONSTRAINT  R_52 FOREIGN KEY (INFO_NO) REFERENCES PRJ_INFO(INFO_NO));
                                                                  
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
CREATE SEQUENCE INTERLINKED_SEQ INCREMENT BY 1;
									
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
  /

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
