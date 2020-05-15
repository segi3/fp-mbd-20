-- trigger : yaboi

create or replace trigger trigger_insert_classes
    before insert on classes
    for each row
    begin
        if :new.class_id is null then
            select next_class_sequence into :new.class_id from dual;
        end if;
    end;
/

-- sequence : yaboi
create sequence class_sequence
    minvalue 1
    maxvalue 9999
    start with 1
    increment by 1
    cache 20;
/
create or replace function next_class_sequence
    return varchar2
    as
    begin
        return('CL' || to_char(class_sequence.nextval, 'fm0000'));
    end;


insert into classes (COURSE_ID, CLASS_NAME) values ('C0001', 'Life coaching - Class 1');
insert into classes (COURSE_ID, CLASS_NAME) values ('C0001', 'Life coaching - Class 2');
insert into classes (COURSE_ID, CLASS_NAME) values ('C0002', 'Machine Learning w/ python - Class 1');
insert into classes (COURSE_ID, CLASS_NAME) values ('C0002', 'Machine Learning w/ python - Class 2');