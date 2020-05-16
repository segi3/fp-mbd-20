-- Patrick Cipta Winata
-- 05111840000098

-- Select : Select 5 nama teacher, nama course, jumlah student dengan jumlah student terbanyak pada course
SELECT TEACHER_NAME, COURSE_NAME, TOTAL_STUDENT 
FROM COURSES 
INNER JOIN (  
	SELECT COURSE_ID C_ID, COUNT(*) AS TOTAL_STUDENT FROM INVOICE  
	GROUP BY COURSE_ID  
    	) ON C_ID = COURSE_ID 
INNER JOIN TEACHERS ON COURSES.TEACHER_ID=TEACHERS.TEACHER_ID
ORDER BY TOTAL_STUDENT DESC
FETCH FIRST 5 ROWS ONLY;


-- Select : Select 5 nama student, jumlah course dibeli pembeli course terbanyak.
SELECT STUDENT_ID,STUDENT_NAME,TOTAL_BELI 
FROM STUDENTS
INNER JOIN (  
        SELECT STUDENT_ID S_ID, COUNT(*) AS TOTAL_BELI FROM INVOICE
        GROUP BY STUDENT_ID 
    	) ON S_ID=STUDENT_ID
ORDER BY TOTAL_BELI DESC
FETCH FIRST 5 ROWS ONLY;


-- Sequence : Sequence untuk penomoran Id teacher.
//Keterangan: Karena sebelumnya sudah insert data sebanyak 100 teacher, maka sequence dimulai dari 101
CREATE SEQUENCE tcid_seq
    MINVALUE 1
    MAXVALUE 9999
    START WITH 100
    INCREMENT BY 1
    CACHE 20;


-- Trigger : Penomoran Id teacher secara otomatis ketika ada data baru
CREATE OR REPLACE TRIGGER tcid_trig  
BEFORE INSERT ON teachers
FOR EACH ROW  
BEGIN  
    IF :new.teacher_id IS NULL THEN  
        :new.teacher_id := ('C' || TO_CHAR(tcid_seq.nextval, 'FM000'));  
    END IF;  
END;



-- Procedure : Mengubah job atau tempat kerja beserta negara teacher.
//Procedure untuk mengubah job dari teacher
CREATE OR REPLACE PROCEDURE CHGJ_P(
	   p_job IN teachers.job%type,
	   p_teacher_id IN teachers.teacher_id %type)
IS
BEGIN
  UPDATE teachers 
  SET job = p_job 
  where teacher_id = p_teacher_id;
END;

//Procedure untuk mengubah tempat kerja serta negara dari teacher
CREATE OR REPLACE PROCEDURE CHGCC_P(
	   p_company IN teachers.company%type,
 	   p_country IN teachers.country%type,
	   p_teacher_id IN teachers.teacher_id %type)
IS
BEGIN
  UPDATE teachers 
  SET company = p_company 
  where teacher_id = p_teacher_id;
END;

//Untuk menjalankan Procedure
EXECUTE CHGJ_P('Data Analyst','TC101')
EXECUTE CHGCC_P('Tokopedia','Indonesia','TC101')


-- Function : Menampilkan teacher dengan jumlah course terbanyak
CREATE OR REPLACE FUNCTION MOSTCOURSE_F 
RETURN varchar 
AS 
    MOST_COURSE VARCHAR(128);
BEGIN 
    SELECT TEACHER_NAME||' | '|| TOTAL_COURSE INTO MOST_COURSE FROM TEACHERS 
        INNER JOIN (  
            SELECT TEACHER_ID T_ID, COUNT(*) AS TOTAL_COURSE FROM COURSES  
            GROUP BY TEACHER_ID  
            ) ON T_ID = TEACHER_ID 
        ORDER BY TOTAL_COURSE DESC
        FETCH FIRST 1 ROWS ONLY;
    RETURN MOST_COURSE;
END;

//Untuk menjalankan Function
SELECT MOSTCOURSE_F() FROM DUAL;