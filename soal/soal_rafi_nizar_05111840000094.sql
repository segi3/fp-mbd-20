-- Rafi Nizar Abiyyi
-- 05111840000094

-- select : select semua nama dan country student serta nama kelas yang diambil dalam suatu course tertetu

kelompokkan bersararkan negara, jumlah per negara

select st.student_name, st.country, cl.class_name, count_country_query1('C0102', st.country)
from students st
inner join (
    select student_id, class_id
    from classes_students
) cstd on cstd.student_id = st.student_id
inner join (
    select class_id, class_name, course_id
    from classes
) cl on cl.class_id = cstd.class_id
inner join (
    select course_id
    from courses
) cs on cs.course_id = cl.course_id
where cs.course_id = 'C0102'
order by st.country;

create or replace function count_country_query1(id_course_param in varchar2, country_name_param in varchar2)
return number
as
    count_country number;
begin
    select count(st.country) into count_country
    from students st
    inner join (
        select student_id, class_id
        from classes_students
    ) cstd on cstd.student_id = st.student_id
    inner join (
        select class_id, class_name, course_id
        from classes
    ) cl on cl.class_id = cstd.class_id
    inner join (
        select course_id
        from courses
    ) cs on cs.course_id = cl.course_id
    where cs.course_id = id_course_param
    and st.country = country_name_param
    group by st.country;

    return count_country;
end;


select st.student_name, st.country, cl.class_name,(
    select count(st.country)
    from students st
    inner join (
        select student_id, class_id
        from classes_students
    ) cstd on cstd.student_id = st.student_id
    inner join (
        select class_id, class_name, course_id
        from classes
    ) cl on cl.class_id = cstd.class_id
    inner join (
        select course_id
        from courses
    ) cs on cs.course_id = cl.course_id
    where cs.course_id = 'C0102'
) as count_country
from students st
inner join (
    select student_id, class_id
    from classes_students
) cstd on cstd.student_id = st.student_id
inner join (
    select class_id, class_name, course_id
    from classes
) cl on cl.class_id = cstd.class_id
inner join (
    select course_id
    from courses
) cs on cs.course_id = cl.course_id
where cs.course_id = 'C0102'
order by st.country;




-- select : nama kelas, course kelas, dan subject kelas

5 course name terfavorit, count std paling banyak, jumlah, urut asc


select cl.class_name, cs.course_name, sb.subject_name, b.std_count
from classes cl
inner join (
    select course_id, course_name, subject_id
    from courses
) cs on cs.course_id = cl.course_id
inner join (
    select cl.course_id as course_id, count(cstd.student_id) as std_count
    from classes_students cstd, classes cl
    where cstd.class_id = cl.class_id
    group by cl.course_id
    order by std_count desc
) b on b.course_id = cs.course_id
inner join subjects sb on sb.subject_id = cs.subject_id
order by cs.course_name;

-- trigger : menjalankan sequence menghitung class_id saat melakukan operasi insert
--           pada tabel classes
create or replace trigger trigger_insert_classes
    before insert on classes
    for each row
    begin
        if :new.class_id is null then
            :new.class_id := ('CL' || to_char(class_sequence.nextval, 'fm0000'));
        end if;
    end;


-- sequence : menghitung class_id secara urut
create sequence class_sequence
    minvalue 1
    maxvalue 9999
    start with 1
    increment by 1
    cache 20;


-- procedure : menampilkan pendapatan setiap teacher
create or replace procedure teacher_income
    as
    cursor p_inc is
        select tc.teacher_name as teacher_name, sum(iv.total_price) as total_income
        from teachers tc
        inner join (
            select course_id, teacher_id
            from courses
        ) cs on cs.teacher_id = tc.teacher_id
        inner join (
            select course_id, total_price
            from invoice
        )iv on iv.course_id = cs.course_id
        group by tc.teacher_name
        order by total_income desc;
    begin
        for pt in p_inc
        loop
            dbms_output.put_line(RPAD(pt.teacher_name, 32) || 'RP ' || pt.total_income);
        end loop;
    end;
/
execute teacher_income;

-- function : Mendapatkan teacher dengan rating review course tertinggi dan student paling banyak
create or replace function best_teacher
    return varchar2
    as
    best_tc varchar2(128);
    cursor p_tc is
        select distinct tc.teacher_name, cs.course_name, a.course_rating, b.std_count
        from teachers tc
        inner join courses cs on cs.teacher_id = tc.teacher_id
        inner join (
            select cl.course_id as course_id, count(cstd.student_id) as std_count
            from classes_students cstd, classes cl
            where cstd.class_id = cl.class_id
            group by cl.course_id
            order by std_count desc
        ) b on b.course_id = cs.course_id
        inner join (
            select course_id, max(rating) as course_rating
            from reviews
            group by course_id
        ) a on a.course_id = cs.course_id
        order by std_count desc, course_rating desc, tc.teacher_name asc
        fetch first 1 row only;
    begin
        for pt in p_tc
        loop
            dbms_output.put_line(RPAD(pt.teacher_name, 32) || RPAD(pt.course_name, 32) || RPAD(pt.course_rating, 5) || pt.std_count);
            best_tc := pt.teacher_name;
        end loop;
        return best_tc;
    end;
/
select best_teacher() from dual;
