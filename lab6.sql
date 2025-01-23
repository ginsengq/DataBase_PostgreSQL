create database lab_courses;

create table courses (
    course_id serial primary key,
    course_name varchar(50),
    course_code varchar(10),
    credits integer
);

create table professors (
    professor_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    department varchar(50)
);

create table students (
    student_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    major varchar(50),
    year_enrolled integer
);

create table enrollments (
    enrollment_id serial primary key,
    student_id integer references students,
    course_id integer references courses,
    professor_id integer references professors,
    enrollment_date date
);

select s.first_name, s.last_name, c.course_name, p.last_name as professor_last_name
from students s
join enrollments e on s.student_id = e.student_id
join courses c on e.course_id = c.course_id
join professors p on e.professor_id = p.professor_id;

select s.first_name, s.last_name
from students s
join enrollments e on s.student_id = e.student_id
join courses c on e.course_id = c.course_id
where c.credits > 3;

select c.course_name, count(e.student_id) as number_of_students
from courses c
left join enrollments e on c.course_id = e.course_id
group by c.course_name;

select distinct p.first_name, p.last_name
from professors p
join enrollments e on p.professor_id = e.professor_id;

select distinct s.first_name, s.last_name
from students s
join enrollments e on s.student_id = e.student_id
join professors p on e.professor_id = p.professor_id
where p.department = 'Computer Science';

select c.course_name, p.last_name as professor_last_name, c.credits
from courses c
join enrollments e on c.course_id = e.course_id
join professors p on e.professor_id = p.professor_id
where p.last_name like 'S%';

select distinct s.first_name, s.last_name
from students s
join enrollments e on s.student_id = e.student_id
where e.enrollment_date < '2022-01-01';

select c.course_name
from courses c
left join enrollments e on c.course_id = e.course_id
where e.student_id is null;
