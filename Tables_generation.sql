--ADMINISTRATOR
create table administrator_ana(
    id_admin int not null primary key,
    last_name varchar(100) not null,
    first_name varchar(100) not null, 
    contact varchar(100) not null unique
);

create sequence administrator_ana_seq start with 1 increment by 1 nocache nocycle;

insert into administrator_ana
values (administrator_ana_seq.nextval, 'Leclerc', 'Pierre', '031443224');

insert into administrator_ana
values (administrator_ana_seq.nextval, 'Popescu', 'George', 'george19483@gmail.com');

insert into administrator_ana
values (administrator_ana_seq.nextval, 'Tommy', 'Maguire', '031443221');

insert into administrator_ana
values (administrator_ana_seq.nextval, 'Robert', 'Higgins', '06333293');

insert into administrator_ana
values (administrator_ana_seq.nextval, 'Sonya', 'Alvarez', 'alva3030@gmail.com');


--NETWORK
create table network_ana(
    id_network int not null primary key,
    network_name varchar(100) not null,
    contact varchar(100) not null unique,
    id_admin int not null, 
    foreign key (id_admin) references administrator_ana(id_admin) on delete cascade
);

create sequence network_ana_seq start with 1 increment by 1 nocache nocycle;

insert into network_ana
values (network_ana_seq.nextval, 'FaceMaybeBook', 'FaceMaybeBook@gmail.com', 3);

insert into network_ana
values (network_ana_seq.nextval, 'StarBiz', 'starbiz@gmail.com', 2);

insert into network_ana
values (network_ana_seq.nextval, 'ROsport', 'rosport@gmail.com', 4);

insert into network_ana
values (network_ana_seq.nextval, 'instantShow', 'instantshow@gmail.com', 5);

insert into network_ana
values (network_ana_seq.nextval, 'CreatorsMedium', 'creatorsmedium@gmail.com', 2);

--LOCATION
create table location_ana(
    id_location int not null primary key, 
    state varchar(100) not null,
    city varchar(100)
);

create sequence location_ana_seq start with 1 increment by 1 nocache nocycle;

insert into location_ana
values (location_ana_seq.nextval, 'Romania', 'Bucuresti');

insert into location_ana
values (location_ana_seq.nextval, 'France', 'Lyon');

insert into location_ana
values (location_ana_seq.nextval, 'UK', null);

insert into location_ana
values (location_ana_seq.nextval, 'Canada', 'Toronto');

insert into location_ana
values (location_ana_seq.nextval, 'Romania', 'Cluj');

--USER
create table user_ana(
    id_user int not null primary key,
    last_name varchar(100) not null,
    first_name varchar(100) not null,
    id_friend int,
    id_location int,
    foreign key(id_friend) references user_ana(id_user) on delete cascade,
    foreign key (id_location) references location_ana(id_location) on delete cascade
);

create sequence user_ana_seq start with 1 increment by 1 nocache nocycle;

insert into user_ana
values (user_ana_seq.nextval, 'Lee', 'Albert', null, 10);

insert into user_ana
values (user_ana_seq.nextval, 'Robertson', 'Bill', 2, 10);

insert into user_ana
values (user_ana_seq.nextval, 'Adrian', 'Silva', 3, null);

insert into user_ana
values (user_ana_seq.nextval, 'Cristian', 'Matei', 3, 9);

insert into user_ana
values (user_ana_seq.nextval, 'Borris', 'Arnold', null, null);

--FEEDBACK
create table feedback_ana(
    id_feedback int not null primary key,
    feedback_text varchar(100) not null,
    id_network int not null,
    id_user int not null,
    foreign key (id_network) references network_ana(id_network) on delete cascade,
    foreign key (id_user) references user_ana(id_user) on delete cascade
);

create sequence feedback_ana_seq start with 1 increment by 1 nocache nocycle;

insert into feedback_ana
values (feedback_ana_seq.nextval, 'O retea sociala perfecta', 6, 5);

insert into feedback_ana
values (feedback_ana_seq.nextval, 'Needs more updates', 4, 2);

insert into feedback_ana
values (feedback_ana_seq.nextval, 'Up for the challenge', 7, 2);

insert into feedback_ana
values (feedback_ana_seq.nextval, 'Great stuff!', 7, 3);

insert into feedback_ana
values (feedback_ana_seq.nextval, 'Extrem de multumit', 6, 6);

--ACCOUNT
create table account_ana(
    id_account int not null primary key,
    username varchar(100) not null,
    email varchar(100) not null unique,
    id_network int not null,
    id_user int not null,
    foreign key (id_network) references network_ana(id_network) on delete cascade,
    foreign key (id_user) references user_ana(id_user) on delete cascade
);

create sequence account_ana_seq start with 1 increment by 1 nocache nocycle;

insert into account_ana
values (account_ana_seq.nextval, 'ruben1', 'ruben1@gmail.com', 6, 5);

insert into account_ana
values (account_ana_seq.nextval, 'frenzy2', 'frenzy2@gmail.com', 4, 2);

insert into account_ana
values (account_ana_seq.nextval, 'olof3', 'olof3@gmail.com', 8, 6);

insert into account_ana
values (account_ana_seq.nextval, 'carlos4', 'carlos4@gmail.com', 8, 4);

insert into account_ana
values (account_ana_seq.nextval, 'benny5', 'benny5@gmail.com', 6, 3);

insert into account_ana
values (account_ana_seq.nextval, 'cristiano6', 'cristiano6@gmail.com', 5, 2);

insert into account_ana
values (account_ana_seq.nextval, 'benito7', 'benito7@gmail.com', 7, 6);

insert into account_ana
values (account_ana_seq.nextval, 'alvaro8', 'alvaro8@gmail.com', 7, 6);

insert into account_ana
values (account_ana_seq.nextval, 'scott9', 'scott9@gmail.com', 8, 3);

insert into account_ana
values (account_ana_seq.nextval, 'ioana', 'ioana@gmail.com', 8, 4);
select * from account_ana;

--PROGRAMMER
create table programmer_ana(
    id_programmer int not null primary key,
    last_name varchar(100) not null,
    first_name varchar(100) not null,
    job_title varchar(10) default 'frontend' check (lower(job_title) = 'frontend' or lower(job_title) = 'backend')
);

create sequence programmer_ana_seq start with 1 increment by 1 nocache nocycle;

insert into programmer_ana
values (programmer_ana_seq.nextval, 'Ragazzi', 'Giovanni', 'Frontend');

insert into programmer_ana
values (programmer_ana_seq.nextval, 'Silva', 'Raul', 'Backend');

insert into programmer_ana
values (programmer_ana_seq.nextval, 'Brown', 'Phil', 'Frontend');

insert into programmer_ana
values (programmer_ana_seq.nextval, 'Trump', 'John', 'Frontend');

insert into programmer_ana
values (programmer_ana_seq.nextval, 'Ionescu', 'Ion', 'Backend');

--UPDATE
create table update_ana(
    id_update int not null primary key,
    details varchar(100) not null,
    id_network int not null,
    id_programmer int not null,
    foreign key (id_network) references network_ana(id_network) on delete cascade,
    foreign key (id_programmer) references programmer_ana(id_programmer) on delete cascade
);

create sequence update_ana_seq start with 1 increment by 1 nocache nocycle;

insert into update_ana
values (update_ana_seq.nextval, 'Comments fixed', 5, 3);

insert into update_ana
values (update_ana_seq.nextval, 'New amazing feature', 6, 4);

insert into update_ana
values (update_ana_seq.nextval, 'Inbox refactored', 7, 6);

insert into update_ana
values (update_ana_seq.nextval, 'Other amazing feature', 6, 5);

insert into update_ana
values (update_ana_seq.nextval, 'Posts fixed', 4, 3);

insert into update_ana
values (update_ana_seq.nextval, 'Remodel(l)ing of data', 4, 7);

insert into update_ana
values (update_ana_seq.nextval, 'Another stunning design', 4, 6);

insert into update_ana
values (update_ana_seq.nextval, 'New contact page', 8, 5);

insert into update_ana
values (update_ana_seq.nextval, 'Comments fixed', 6, 6);

insert into update_ana
values (update_ana_seq.nextval, 'Posts fixed', 6, 6);

--POST
create table post_ana(
    id_post int not null primary key,
    title varchar(100) not null,
    post_text varchar(100) not null,
    id_account int not null,
    post_date date default sysdate,
    foreign key (id_account) references account_ana(id_account) on delete cascade
);

create sequence post_ana_seq start with 1 increment by 1 nocache nocycle;

insert into post_ana (id_post, title, post_text, id_account)
values (post_ana_seq.nextval, 'Despre sport', 'Sportul aduce numeroase beneficii la nivel fizic si mental', 21);

insert into post_ana (id_post, title, post_text, id_account)
values (post_ana_seq.nextval, 'Despre cunoastere', 'Pur si simplu importanta', 21);

insert into post_ana (id_post, title, post_text, id_account)
values (post_ana_seq.nextval, 'Pe la scoala', 'Invat si atat', 25);

insert into post_ana (id_post, title, post_text, id_account)
values (post_ana_seq.nextval, 'Despre sport', 'Sportul este de baza', 26);

insert into post_ana (id_post, title, post_text, id_account)
values (post_ana_seq.nextval, 'Pe afara', 'Alerg', 24);

--COMMENT
create table comment_ana(
    id_post int not null primary key,
    comment_text varchar(100) not null,
    id_account int not null,
    comment_date date default sysdate,
    foreign key (id_account) references account_ana(id_account) on delete cascade
);

create sequence comment_ana_seq start with 1 increment by 1 nocache nocycle;

insert into comment_ana (id_post, comment_text, id_account)
values (comment_ana_seq.nextval, 'Nu zici rau', 24);

insert into comment_ana (id_post, comment_text, id_account)
values (comment_ana_seq.nextval, 'Sportul nu e bun de nimic', 27);

insert into comment_ana (id_post, comment_text, id_account)
values (comment_ana_seq.nextval, 'Cunoasterea nu e chiar asa importanta', 27);

insert into comment_ana (id_post, comment_text, id_account)
values (comment_ana_seq.nextval, 'Hai Real!', 24);

insert into comment_ana (id_post, comment_text, id_account)
values (comment_ana_seq.nextval, 'Cam asa', 26);

--MODERATOR
create table moderator_ana(
    id_moderator int not null primary key,
    last_name varchar(100) not null,
    first_name varchar(100) not null,
    id_location int not null,
    foreign key (id_location) references location_ana(id_location) on delete cascade
);

create sequence moderator_ana_seq start with 1 increment by 1 nocache nocycle;

insert into moderator_ana
values (moderator_ana_seq.nextval, 'James', 'Inna', 12);

insert into moderator_ana
values (moderator_ana_seq.nextval, 'Williams', 'Marcel', 11);

insert into moderator_ana
values (moderator_ana_seq.nextval, 'Popescu', 'Vasile', 9);

insert into moderator_ana
values (moderator_ana_seq.nextval, 'Lacroix', 'Bennoit', 10);

insert into moderator_ana
values (moderator_ana_seq.nextval, 'Stan', 'Cristian', 13);

--INTERVENTION
create table intervention_ana(
    id_intervention int not null primary key,
    details varchar(100) not null,
    results varchar(100),
    id_moderator int not null,
    id_post int,
    id_comment int,
    foreign key (id_moderator) references moderator_ana(id_moderator) on delete cascade,
    foreign key (id_post) references post_ana(id_post) on delete cascade,
    foreign key (id_comment) references comment_ana(id_post) on delete cascade,
    check (id_post is not null or id_comment is not null)
);

create sequence intervention_ana_seq start with 1 increment by 1 nocache nocycle;

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Lipsa de respect', 'Se recomanda un avertisment', 2, null, 3);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Plagiata', null, 2, 11, null);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Irelevant', null, 2, 12, null);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Subiectiv', null, 6, null, 5);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Promoveaza ignoranta', null, 3, null, 4);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Promoveaza lipsa de activitate', null, 5, null, 3);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Lipsa de respect', 'Se recomanda inchiderea contului', 4, null, 3);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Hai Real!', null, 2, null, 5);

insert into intervention_ana
values (intervention_ana_seq.nextval, 'Extrem de pertinent', null, 6, null, 6);