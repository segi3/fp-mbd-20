-- Reihan Nanda Ramadhan
-- 05111840000132

-- 1.a Select Siswa yang memberikan rating 5 ke course dan tampilkan id review, id siswa, nama, siswa, id course, kata kata review, dan tanggal pembuatan review tersebut
Query: 
select rv.review_id, rv.student_id, st.student_name, rv.course_id ,rv.review_text,rv.created_at 
from reviews rv, students st
where rv.student_id = st.student_id
and rv.rating = 5



-- 1.b Select payment_methods yang paling sering digunakan setiap bulannya
Query:

select method_name, total_use
from payment_methods pm
inner join(
    select method_id m_id, count(*) as total_use 
    from invoice inv
    group by method_id
    ) on m_id = method_id
order by total_use desc


-- 2. Sequence untuk men-'generate' ID Review secara otomatis
create sequence review_seq 
minvalue 1   
maxvalue 9999   
start with 1   
increment by 1   
cache 20

-- 3. Trigger untuk melakukan concatenate ID menggunakan kode khusus diikuti oleh nomor urutan
CREATE OR REPLACE TRIGGER next_review_trigger  
BEFORE INSERT ON    Reviews
FOR EACH ROW  
BEGIN  
    IF :new.review_id IS NULL THEN  
        :new.review_id := ('REV' || TO_CHAR(review_seq.nextval, 'FM0000'));  
    END IF;  
END;  

                                   
-- 4. Procedure untuk mengganti rating yang error dalam database
-- Ketika rating yang masuk ke dalam database < 1
Query:
                                            
create or replace procedure rating_update_up
as
    cursor c_rating
    is
        select rev.review_id, rev.rating
        from reviews rev
        where rating < 1;
    
begin
    for val in c_rating
        loop
                update reviews
                set rating = 1
                where review_id = val.review_id;
                DBMS_OUTPUT.PUT_LINE ( 'Review ID: ' || val.review_id || ' - Old Rating: ' || val.rating || ' - New Rating : 1');
        end loop;
end;   
                                            
-- Ketika rating yang masuk ke dalam database > 5
Query:
                                            
create or replace procedure rating_update_down
as
    cursor c_rating
    is
        select rev.review_id, rev.rating
        from reviews rev
        where rating > 5;
    
begin
    for val in c_rating
        loop
                update reviews
                set rating = 5
                where review_id = val.review_id;
                DBMS_OUTPUT.PUT_LINE ( 'Review ID: ' || val.review_id || ' - Old Rating: ' || val.rating || ' - New Rating : 1');
        end loop;
end;     
                                            

-- 5. Function untuk mengetahui jumlah course yang diambil setiap bulannya
Query:                                           
create or replace function monthly_course(bulan IN NUMBER, tahun IN NUMBER)
return varchar2
as
    c_id varchar2(10);
begin
    select ID_Course into c_id
    from 
        (select invoice.course_id AS ID_Course, count(*) AS course_diambil
         from courses, invoice
         where invoice.course_id = courses.course_id
         group by invoice.course_id
         order by course_diambil desc)
    where rownum = 1;
    
    return c_id;
end;           
/
SELECT monthly_course(3,2020) FROM dual;                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
