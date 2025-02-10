create database hackathon;
use hackathon;

 -- Câu 2 - Tạo bảng và chỉnh sửa CSDL 
create table tbl_authors(
	author_id int primary key auto_increment,
    author_name varchar(100) not null,
    birth_year year
);

create table tbl_books(
	book_id int primary key auto_increment,
    title varchar(255) not null,
    author_id int,
    foreign key (author_id ) references tbl_authors(author_id),
    category varchar(100),
    published_year year,
    available_copies int
);

create table tbl_members(
	member_id int primary key auto_increment,
    member_name varchar(100) not null,
    phone varchar(20) not null unique,
    email varchar(100) unique not null,
    address varchar(255)
);

create table tbl_member_info(
	member_id int primary key,
    foreign key(member_id) references tbl_members(member_id),
    membership_type enum('Standard', 'Premium'),
    registration_date date,
    expiry_date date
);

create table tbl_borrow_records(
	borrow_id int primary key auto_increment,
    member_id int,
    book_id int,
    foreign key(member_id) references tbl_members(member_id),
    foreign key(book_id) references tbl_books(book_id),
    borrow_date date,
    return_date date 
);


alter table tbl_borrow_records
add column fine_amount decimal(10,2);

alter table tbl_members
modify column phone varchar(15);

-- alter table tbl_member_info
-- drop column expiry_date;

-- Câu 3 - Chèn dữ liệu

insert into tbl_books(title, author_id, category, published_year, available_copies)
values('Đất rừng phương Nam',1,'Tiểu Thuyết',1954,10),
('Tắt đèn',2,'Tiểu Thuyết',1940,5),
('Đời Thừa',3,'Tiểu Thuyết',1943,8),
('Số đỏ',4,'Tiểu Thuyết',1940,12),
('Đế mèm phiêu lưu ký',5,'Truyện thiếu nhi',1941,7);

insert into tbl_authors(author_name,birth_year)
values('Đoàn Giỏi',1917),
('Ngô Tất Tố',1991),
('Nam Cao',1917),
('Vũ Trọng Phụng',1903),
('Tô Hoài',1920);

insert into tbl_members(member_name, phone, email, address)
values('Nguyễn Văn A','0932767326','anv@gmail.com','Hà Nội'),
('Trần Thị B','0992378636','btt@gmail.com','Hồ Chí Minh'),
('Lê Văn C','0932767365','clv@gmail.com','Đà Nẵng'),
('Phạm Thị D','0973265632','dpt@gmail.com','Hà Nội'),
('Nguyễn Thị E','0923865633','ent@gmail.com','Hồ Chí Minh');

insert into tbl_member_info(member_id,membership_type, registration_date, expiry_date)
values(1,'Premium','2023-01-01','2024-01-01'),
(2,'Standard','2023-04-05','2024-04-05'),
(3,'Premium','2023-03-10','2024-03-10'),
(4,'Premium','2023-02-15','2024-02-15'),
(5,'Standard','2023-05-20','2024-05-20');

insert into tbl_borrow_records(member_id, book_id, borrow_date, return_date)
values(1,1,'2023-01-10','2023-01-20'),
(2,2,'2023-02-05','2023-02-15'),
(3,3,'2023-03-15',NUll),
(4,4,'2023-04-10','2023-04-25'),
(5,5,'2023-05-05','2023-05-15');

 -- Câu 4 Truy vấn cơ bản
 -- Câu 4a
 select book_id as 'Mã sách',title as 'Tên sách', category as 'Thể loại',published_year as 'Năm suất bản',available_copies as 'Số bản sách có sẵn'
 from tbl_books;
 -- Câu 4b
 select b.member_id,m.member_name from tbl_borrow_records b
 join tbl_members m on b.member_id = m.member_id
 group by b.member_id;

-- Câu 5 - Truy vấn nhiều bảng
-- Câu 5a 
select a.author_name as 'Tên tác giả',count(b.author_id) as 'Số lượng sách đã suất bản' from tbl_books b
join tbl_authors a on b.author_id = a.author_id
group by b.author_id;
-- Câu 5b
select b.title, count(s.book_id) as 'Số lần được mượn' from tbl_borrow_records s
join tbl_books b on s.book_id = b.book_id
group by s.book_id;

-- Câu 6 - Truy vấn có nhóm dữ liệu
-- Câu 6a
select m.member_name as 'Tên bạn đọc',count(b.member_id) as 'Số lượng sách đã mượn' from tbl_borrow_records b
join tbl_members m on b.member_id = m.member_id
group by b.member_id;
-- Câu 6 b
select m.member_name as 'Tên bạn đọc',count(b.member_id) as 'Số lượng sách đã mượn' from tbl_borrow_records b
join tbl_members m on b.member_id = m.member_id
group by b.member_id
having count(b.member_id) >= 3;

-- Câu 7 Truy vấn nâng cao
select b.title, count(s.book_id) as 'Tổng số lượt mượn' from tbl_borrow_records s
join tbl_books b on s.book_id = b.book_id
group by s.book_id
order by count(s.book_id) desc
limit 5;
-- Câu 8 Truy vấn nâng cao
select m.member_name as 'Tên bạn đọc',
case 
	when count(b.member_id) = 0 then 0
    else count(b.member_id)
    end as 'Tổng số sách đã mượn'
from tbl_borrow_records b
join tbl_members m on b.member_id = m.member_id
group by m.member_name;