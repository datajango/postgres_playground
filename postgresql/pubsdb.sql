drop database if exists pubsdb;
create database pubsdb;
\c pubsdb;

drop table if exists author;
create table if not exists author (
  author_id int primary key,
  first_name varchar(16) not null,
  last_name varchar(16) not null
);

drop table if exists book;
create table if not exists book (
  book_id int primary key not null,
  book_title varchar(16),
  month varchar(16) not null,
  year int not null,
  editor int,
  FOREIGN KEY (editor) references author(author_id)
    ON DELETE SET NULL
);

drop table if exists publication;
CREATE TABLE publication (
  pub_id INT PRIMARY KEY,
  title VARCHAR(16) NOT NULL,
  book_id INT,
  FOREIGN KEY (book_id) REFERENCES book(book_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

drop table if exists author_publication;
create table if not exists author_publication (
  author_id int not null references author(author_id),
  pub_id int not null references publication(pub_id),
  author_position int not null, -- first author, second, etc?

  primary key (author_id, pub_id)
);

BEGIN;
insert into author values (1, 'John', 'McCarthy');
insert into author values (2, 'Dennis', 'Ritchie');
insert into author values (3, 'Ken', 'Thompson');
insert into author values (4, 'Claude', 'Shannon');
insert into author values (5, 'Alan', 'Turing');
insert into author values (6, 'Alonzo', 'Church');
insert into author values (7, 'Perry', 'White');
insert into author values (8, 'Moshe', 'Vardi');
insert into author values (9, 'Roy', 'Batty');

insert into book values(1, 'CACM', 'April', 1960, 8);
insert into book values(2, 'CACM', 'July', 1974, 8);
insert into book values(3, 'BST', 'July', 1948, 2);
insert into book values(4, 'LMS', 'November', 1936, 7);
insert into book values(5, 'Mind', 'October', 1950, null);
insert into book values(6, 'AMS', 'Month', 1941, null);
insert into book values(7, 'AAAI', 'July', 2012, 9);
insert into book values(8, 'NIPS', 'July', 2012, 9);

insert into publication values(1, 'LISP', 1);
insert into publication values(2, 'Unix', 2);
insert into publication values(3, 'Info Theory', 3);
insert into publication values(4, 'Turing Machines', 4);
insert into publication values(5, 'Turing Test', 5);
insert into publication values(6, 'Lambda Calculus', 6);

insert into author_publication values(1, 1, 1);
insert into author_publication values(2, 2, 1);
insert into author_publication values(3, 2, 2);
insert into author_publication values(4, 3, 1);
insert into author_publication values(5, 4, 1);
insert into author_publication values(5, 5, 1);
insert into author_publication values(6, 6, 1);
COMMIT;