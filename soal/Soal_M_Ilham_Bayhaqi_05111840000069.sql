-- Nama : Muhammad Ilham Bayhaqi
-- NRP  : 05111840000069

--
-- Procedure untuk melakukan enkirpsi password
CREATE OR REPLACE PROCEDURE setEncryptPassword
    (curr_password IN OUT varchar2)
IS
    public_key varchar2(32) := 'encrypt_key';
BEGIN
    curr_password := (DBMS_CRYPTO.HASH(UTL_I18N.STRING_TO_RAW 
        (public_key || curr_password, 'AL32UTF8'),
        DBMS_CRYPTO.HASH_MD5));
END;

CREATE OR REPLACE TRIGGER encryptTeacher
BEFORE UPDATE OR INSERT
ON teachers
FOR EACH ROW
BEGIN
    setEncryptPassword(:new.password);
END;

CREATE OR REPLACE TRIGGER encrypt
BEFORE UPDATE OR INSERT
ON students
FOR EACH ROW
BEGIN
    setEncryptPassword(:new.password);
END;

-- testing  
insert into students (STUDENT_ID, STUDENT_NAME, EMAIL, PASSWORD, COUNTRY, SCHOOL, CREATED_AT)   
    values ('ST001', 'Carolyne Gooderson', 'cgooderson0@t.co', '4VUVcT', 'Germany', 'Lutherische Theologische Hochschule Oberursel', timestamp '2019-09-19 07:43:28');  

SELECT student_id, student_name, password FROM STUDENTS  
WHERE student_id = 'ST001'  

--
-- Sequence penomoran
CREATE SEQUENCE course_sequence
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 20;


--
-- Trigger penomoran course
CREATE OR REPLACE TRIGGER next_course_sequence
BEFORE INSERT ON courses
FOR EACH ROW
BEGIN
    IF :new.course_id IS NULL THEN
        :new.course_id := ('C' || TO_CHAR(course_sequence.nextval, 'FM0000'));
    END IF;
END;

-- testing untuk trigger dan sequence penomoran
insert into courses (course_id, teacher_id, subject_id, description, price, course_name, created_at)  values   
    (NULL, 'TC001', '1', 'Learn the transformational Achology Life Coaching process and become ahighly skilled, Achology certified Life Coach', '140000', 'Life Coaching', timestamp '2020-04-28 08:54:26');  

SELECT course_id, course_name FROM courses;


--
-- Fungsi untuk mengembalikan banyaknya course terjual pada sebulan (30 hari) terakhir
CREATE OR REPLACE FUNCTION course_sold
    (c_id IN varchar2)
RETURN number
IS
    course_count number;
BEGIN
    SELECT count(*) INTO course_count
    FROM invoice 
    WHERE created_at >= sysdate - 30 AND invoice.course_id = c_id;
    
    RETURN course_count;
END;

-- testing
SELECT course_id, course_name, course_sold(courses.course_id) from courses;


--
--Melakukan select kode incoice, nama course, nama student dan metode pembayaran
SELECT c_inv_id as kode_invoice, course_name, student_name, method_name FROM (  
    SELECT invoice_id as c_inv_id, course_name FROM ((SELECT invoice_id, course_id as c_id FROM invoice)  
    INNER JOIN (SELECT course_id, course_name FROM courses) ON c_id = course_id)  
    )  
INNER JOIN (  
    SELECT invoice_id AS s_inv_id, student_name FROM ((SELECT invoice_id, student_id as s_id FROM invoice)  
    INNER JOIN (SELECT student_id, student_name FROM students) ON s_id = student_id)  
) ON c_inv_id = s_inv_id  
INNER JOIN (  
    SELECT invoice_id AS m_inv_id, method_name FROM ((SELECT invoice_id, method_id as m_id FROM invoice)  
    INNER JOIN (SELECT method_id, method_name FROM payment_methods) ON m_id = method_id)  
) ON c_inv_id = m_inv_id  

-- alternate version
SELECT invoice_id, course_name, student_name, method_name FROM invoice
INNER JOIN courses ON invoice.course_id = courses.course_id
INNER JOIN students ON invoice.student_id = students.student_id
INNER JOIN payment_methods ON invoice.method_id = payment_methods.method_id  


--
--Melakukan select untuk 5 subject dengan pembelian oleh student terbanyak.
SELECT subject_id, subject_name, NVL(stCount, 0) as student_count  FROM subjects
LEFT JOIN (
    SELECT subject_id as s_id, sum(course_student) as stCount FROM courses
    INNER JOIN (
        SELECT course_id c_id, count(*) as course_student FROM INVOICE
        GROUP BY course_id
    ) ON c_id = course_id
    GROUP BY subject_id
) ON s_id = subject_id
ORDER BY student_Count DESC
FETCH FIRST 5 ROWS ONLY;
