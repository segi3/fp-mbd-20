
/*==============================================================*/
/* Table: TEACHERS                                              */
/*==============================================================*/
create table TEACHERS
(
   TEACHER_ID           char(5) not null,
   TEACHER_NAME         varchar2(128) not null,
   EMAIL                varchar2(64) not null,
   PASSWORD             varchar2(32) not null,
   JOB                  varchar2(256),
   COMPANY              varchar2(256),
   COUNTRY              varchar2(64) not null,
   CREATED_AT           timestamp not null,
   primary key (TEACHER_ID)
);

/*==============================================================*/
/* Table: SUBJECTS                                              */
/*==============================================================*/
create table SUBJECTS
(
   SUBJECT_ID           number(3) not null,
   SUBJECT_NAME         varchar2(64),
   primary key (SUBJECT_ID)
);

/*==============================================================*/
/* Table: COURSES                                               */
/*==============================================================*/
create table COURSES
(
   COURSE_ID            char(5) not null,
   TEACHER_ID           char(5) not null,
   SUBJECT_ID           number(3) not null,
   DESCRIPTION          varchar2(256) not null,
   PRICE                real not null,
   COURSE_NAME          varchar2(64) not null,
   CREATED_AT           timestamp not null,
   primary key (COURSE_ID),
   constraint FK_COURSES_RELATIONS_TEACHERS foreign key (TEACHER_ID)
      references TEACHERS (TEACHER_ID),
   constraint FK_COURSES_RELATIONS_SUBJECTS foreign key (SUBJECT_ID)
      references SUBJECTS (SUBJECT_ID)
);

/*==============================================================*/
/* Table: CLASSES                                               */
/*==============================================================*/
create table CLASSES
(
   COURSE_ID            char(5) not null,
   CLASS_ID             char(6) not null,
   CLASS_NAME           varchar2(256) not null,
   primary key (CLASS_ID),
   constraint FK_CLASSES_RELATIONS_COURSES foreign key (COURSE_ID)
      references COURSES (COURSE_ID)
);

/*==============================================================*/
/* Table: STUDENTS                                              */
/*==============================================================*/
create table STUDENTS
(
   STUDENT_ID           char(5) not null,
   STUDENT_NAME         varchar2(256) not null,
   EMAIL                varchar2(256) not null,
   PASSWORD             varchar2(32) not null,
   COUNTRY              varchar2(64) not null,
   SCHOOL               varchar2(256),
   CREATED_AT           timestamp not null,
   primary key (STUDENT_ID)
);

/*==============================================================*/
/* Table: CLASSES_STUDENTS                                      */
/*==============================================================*/
create table CLASSES_STUDENTS
(
   CLASS_ID             char(6) not null,
   STUDENT_ID           char(5) not null,
   SCORE                real,
   constraint FK_CLASSES__RELATIONS_CLASSES foreign key (CLASS_ID)
      references CLASSES (CLASS_ID),
   constraint FK_CLASSES__RELATIONS_STUDENTS foreign key (STUDENT_ID)
      references STUDENTS (STUDENT_ID)
);

/*==============================================================*/
/* Table: PAYMENT_METHODS                                       */
/*==============================================================*/
create table PAYMENT_METHODS
(
   METHOD_ID            number(3) not null,
   METHOD_NAME          varchar2(128) not null,
   primary key (METHOD_ID)
);

/*==============================================================*/
/* Table: INVOICE                                               */
/*==============================================================*/
create table INVOICE
(
   COURSE_ID            char(5) not null,
   STUDENT_ID           char(5) not null,
   METHOD_ID            number(3) not null,
   INVOICE_ID           char(8) not null,
   TOTAL_PRICE          real not null,
   DISKON               real,
   CREATED_AT           timestamp not null,
   primary key (INVOICE_ID),
   constraint FK_INVOICE_RELATIONS_COURSES foreign key (COURSE_ID)
      references COURSES (COURSE_ID),
   constraint FK_INVOICE_RELATIONS_STUDENTS foreign key (STUDENT_ID)
      references STUDENTS (STUDENT_ID),
   constraint FK_INVOICE_RELATIONS_PAYMENT_ foreign key (METHOD_ID)
      references PAYMENT_METHODS (METHOD_ID)
);

/*==============================================================*/
/* Table: REVIEWS                                               */
/*==============================================================*/
create table REVIEWS
(
   STUDENT_ID           char(5) not null,
   REVIEW_ID            char(7) not null,
   COURSE_ID            char(5) not null,
   RATING               number(1) not null,
   REVIEW_TEXT          varchar2(256) not null,
   CREATED_AT           timestamp not null,
   primary key (REVIEW_ID),
   constraint FK_REVIEWS_RELATIONS_COURSES foreign key (COURSE_ID)
      references COURSES (COURSE_ID),
   constraint FK_REVIEWS_RELATIONS_STUDENTS foreign key (STUDENT_ID)
      references STUDENTS (STUDENT_ID)
);

/*==============================================================*/
/* Table: SHOPPING_CARTS                                        */
/*==============================================================*/
create table SHOPPING_CARTS
(
   STUDENT_ID           char(5) not null,
   COURSE_ID            char(5),
   constraint FK_SHOPPING_RELATIONS_COURSES foreign key (COURSE_ID)
      references COURSES (COURSE_ID),
   constraint FK_SHOPPING_RELATIONS_STUDENTS foreign key (STUDENT_ID)
      references STUDENTS (STUDENT_ID)
);
