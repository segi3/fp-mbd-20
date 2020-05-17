-- select Menampilikan student pada suatu kelas yang memilki score > 85
select cl.class_name, student_name, cstd.score
from students std
inner join classes_students cstd on cstd.student_id = std.student_id
inner join classes cl on cl.class_id = cstd.class_id
where cstd.class_id = 'CL0003'
AND cstd.score > 85;

-- select Menampilkan nilai rata rata dari semua kelas
select class_name, avg(cstd.score)
from classes_students cstd
inner join classes c on cstd.class_id = c.class_id
group by class_name;

-- trigger Memasukkan student id secara otomatis saat dilakukan operasi insert

create or replace trigger trigger_insert_student_id
    before insert on students
    for each row
    begin
        if :new.student_id is null then
            :new.student_id := ('ST' || TO_CHAR(students_sequence.nextval, 'FM000'));
        end if;
    end;


-- sequence Memberikan penomoran pada student id
create sequence students_sequence
    minvalue 1
    maxvalue 9999
    start with 1
    increment by 1
    cache 20;

-- Procedure untuk menampilkan 10 student yang memiliki score rata rata tertinggi
create or replace procedure student_tertinggi
is
    o_name varchar(128);
    o_score number;
    counter number;
    cursor c1 is
    SELECT st.student_name as nama, avg(cstd.score) as score
    from students st inner join classes_students cstd on cstd.student_id = st.student_id
    group by st.student_name
    order by avg(cstd.score) desc;
begin
    counter:=0;
    FOR pointer IN c1
    LOOP
     o_name:=pointer.nama;
     o_score:=pointer.score;
     dbms_output.put_line( 'name : ' || o_name || ' score: ' || o_score );
     counter:=counter+1;
     exit when counter = 10;
   END LOOP;
end;

-- function Menampilkan student dengan nilai tertinggi dari suatu kelas
create or replace function tertinggi_di_kelas (in_class_id in varchar2)
return varchar2
as
    o_name varchar(128);
begin
    select std.student_name into o_name
    from students std
    inner join classes_students cstd on cstd.student_id = std.student_id
    where cstd.class_id = in_class_id
    order by cstd.score desc
    fetch first 1 rows only;
    return o_name;
end;
--untuk mengetes fungsi
select c.class_id, tertinggi_di_kelas(c.class_id), cstd.score
from classes c
inner join classes_students cstd on cstd.class_id = c.class_id
inner join students std on std.student_id = cstd.student_id
where std.student_name = tertinggi_di_kelas(c.class_id);
