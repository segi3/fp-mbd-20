-- Soal 1: Menampilkan kelas dengan urutan rating terbesar > terkecil
SELECT course_name, rating
FROM courses, reviews
WHERE courses.course_id = reviews.course_id
ORDER BY rating DESC;
/

--Soal 2: Menampilkan kelas, jumlah pembeli, diurut berdasarkan kelas dengan pembeli terbanyak dalam 1 bulan tertentu
SELECT course_name, COUNT(*) AS jumlah_pembeli
FROM courses, invoice
WHERE courses.course_id = invoice.course_id
AND EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM invoice.created_at)
AND EXTRACT(YEAR FROM SYSDATE) = EXTRACT(YEAR FROM invoice.created_at)
GROUP BY course_name
ORDER BY jumlah_pembeli DESC;
/

--Soal 3: Sequence Invoice (Auto ID Numbering)
DROP SEQUENCE seq_invoice;
CREATE SEQUENCE seq_invoice
    START WITH 73788600001
    MAXVALUE 73788699999
    INCREMENT BY 1;
/

-- Soal 4: Trigger Insert Invoice
CREATE OR REPLACE TRIGGER insert_invoice
    BEFORE INSERT
    ON invoice FOR EACH ROW
DECLARE
    x varchar(100);
    final_id char(8);
BEGIN
    SELECT TO_CHAR(seq_invoice.NEXTVAL) INTO x FROM DUAL;
    
    final_id := CHR(TO_NUMBER(SUBSTR(x, 1, 2))) || CHR(TO_NUMBER(SUBSTR(x, 3, 2))) || CHR(TO_NUMBER(SUBSTR(x, 5, 2))) || SUBSTR(x, 7);
    :new.invoice_id := final_id;
END;
/

--Soal 5: Procedure Discount
-- Rumus Discount = ([harga course]/[total pembelian]*[jumlah kelas]*[jumlah kelas]) / ([harga course]*2/[total pembelian]);
-- Additional Discount 5% kalau merupakan course yang di return
CREATE OR REPLACE PROCEDURE set_discount
AS
    CURSOR d_id
    IS
    SELECT course_id, total_price AS harga_course
    FROM invoice;
        
    dummy d_id%ROWTYPE;
    cur_disc NUMBER;
    discount FLOAT;
    idcourse CHAR(5);
    cur_month NUMBER;
    cur_year NUMBER;
    harga_after NUMBER;
BEGIN
    OPEN d_id;
    LOOP
        FETCH d_id INTO dummy;
        EXIT WHEN d_id%NOTFOUND;
        
        idcourse := dummy.course_id;
        cur_month := EXTRACT(MONTH FROM SYSDATE);
        cur_year := EXTRACT(YEAR FROM SYSDATE);
        cur_disc := 0.25;
        
        IF ( idcourse = fav_course(cur_month, cur_year) ) THEN
            harga_after := (dummy.harga_course - (dummy.harga_course * cur_disc)) * 0.95;
            discount := 1 - (harga_after / dummy.harga_course);
        ELSE
            harga_after := dummy.harga_course - (dummy.harga_course * cur_disc);
            discount := cur_disc;
        END IF;
        
        UPDATE invoice
        SET invoice.diskon = TO_BINARY_FLOAT(discount), invoice.total_price = harga_after
        WHERE invoice.course_id = idcourse;
    END LOOP;
    
    CLOSE d_id;
END;
/

--Soal 6: Function mereturn course dengan harga termurah dari course dgn peserta terbanyak dalam jangka waktu tertentu (Input per bulan)
CREATE OR REPLACE FUNCTION fav_course(bulan IN NUMBER, tahun IN NUMBER)
RETURN VARCHAR2
AS
    id_course VARCHAR2(8);
BEGIN
    SELECT course_id INTO id_course
    FROM
        (SELECT course_id, jumlah_pembeli, harga
         FROM
             (SELECT invoice.course_id AS course_id, COUNT(*) AS jumlah_pembeli, courses.price AS harga
              FROM courses, invoice
              WHERE courses.course_id = invoice.course_id
              GROUP BY invoice.course_id, courses.price
              ORDER BY jumlah_pembeli DESC)
         WHERE ROWNUM <= 5
         ORDER BY harga ASC)
    WHERE ROWNUM = 1;

    RETURN id_course;
END;
/