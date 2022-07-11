CREATE TABLE IF NOT EXISTS product(
	p_id VARCHAR(10) NOT NULL,
	p_name VARCHAR(20),
	p_unitPrice INTEGER,
	p_description TEXT,
	p_category VARCHAR(20),
	p_manufacturer VARCHAR(20),
	p_unitsInStock LONG,
	p_condition VARCHAR(20),
	p_fileName VARCHAR(20),
	PRIMARY KEY (p_id)
)default CHARSET=utf8;

desc product;
drop table product;
ALTER TABLE product change p_name p_name varchar(20);
select * from product;
update product set p_fileName="P1211.jpg" where p_id="P1211";