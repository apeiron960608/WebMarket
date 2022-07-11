create table board (
	num int not null auto_increment, 
	id varchar(10) not null,
	name varchar(10) not null,
	subject varchar(100) not null,
	content text not null,
	regist_day varchar(30),
	hit int,
	ip varchar(20),
	PRIMARY KEY (num)
)default charset=utf8;

desc board;
select * from board;

insert into board(num, id, name, subject, content) values(
	'1', 'test', '테스트', '테스트로 입력하는 글', '테스트 글입니다.');  