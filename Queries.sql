--11

--Sa se afiseze toti moderatorii care au intervenit la comentariile utilizatorului cu numele de familie Robertson
select m.first_name, m.last_name
from moderator_ana m join intervention_ana i on m.id_moderator = i.id_moderator
                     join comment_ana c on c.id_post = i.id_comment
                     join account_ana a on a.id_account = c.id_account
                     join user_ana u on u.id_user = a.id_user
where lower(u.last_name) = 'robertson';


--Sa se afiseze de cate luni nu s-a mai postat pe reteaua ce contine 'Face' in denumirea sa.
select distinct round(months_between(sysdate, p.post_date), 2) as "Numar luni"
from post_ana p join account_ana a on p.id_account = a.id_account join network_ana n on n.id_network = a.id_network
where instr(upper(n.network_name), 'FACE') <> 0;


--Sa se afiseze orasul unde au avut loc cele mai multe interventii asupra postarilor
select v_main.city
from(
    select v.city city
    from (select count(i.id_intervention) numar, l.city city from location_ana l join user_ana u on l.id_location = u.id_location 
                                                                                 join account_ana a on a.id_user = u.id_user
                                                                                 join post_ana p on a.id_account = p.id_account
                                                                                 join intervention_ana i on i.id_post = p.id_post
                                                                                 group by l.city) v
    order by v.numar
) v_main
where rownum < 2;


--Sa se afiseze cele mai recente postari pentru utilizatorul 3 si cele mai recente comentarii pentru 6. 
--Daca utilizatorul nu are nicio postare/comentariu, se va afisa 'Nu exista'
with comment_table as (select c.comment_date, c.id_account, a.id_user, c.comment_text from comment_ana c join account_ana a on c.id_account = a.id_account)
select decode(u.id_user, 
3, nvl((select p.post_text from post_ana p join account_ana a on p.id_account = a.id_account where a.id_user = u.id_user 
        and p.post_date = (select max(post_date) from post_ana p join account_ana a on p.id_account = a.id_account where a.id_user = u.id_user) ), 'Nu exista'), 
6, nvl((select a.comment_text from comment_table a where a.id_user = u.id_user
        and a.comment_date = (select max(comment_date) from comment_table a where a.id_user = u.id_user)), 'Nu exista')
) as "Continut"
from user_ana u
where u.id_user = 3 or u.id_user = 6;


--Sa se afiseze numele complet al fiecarui utilizator care a fost tinta la mai mult de o interventie
select u.last_name || ' ' || u.first_name as "Nume complet"
from intervention_ana i join comment_ana c on c.id_post = i.id_comment
                        join account_ana a on a.id_account = c.id_account
                        join user_ana u on u.id_user = a.id_user
group by u.last_name, u.first_name
having count(id_intervention) > 1;


--12
update administrator_ana
set (last_name, first_name) = (select last_name, first_name from programmer_ana where id_programmer = 6)
where lower(last_name) = 'popescu';


update intervention_ana i
set (i.details) = (select 'Utilizatorul ' || u.last_name || ' a produs o neregula' from user_ana u join account_ana a on a.id_user = u.id_user
                                                                                                   join comment_ana c on a.id_account = c.id_account
                                                                                                   join intervention_ana i2 on i2.id_comment = c.id_post
                                                                                                   where i2.id_intervention = i.id_intervention)
where i.id_intervention = 17;


update intervention_ana i
set (i.results) = (select 'Se recomanda stergerea elementului ' || p.id_post from post_ana p where i.id_post = p.id_post)
where i.results is null;


delete from administrator_ana
where last_name in (select last_name from programmer_ana);
rollback;


delete from post_ana
where id_account in (select id_account from account_ana where id_user = 2);
rollback;


delete from post_ana
where id_post in (select id_post from intervention_ana);
rollback;


--14
create or replace view active_users_ana
as (select u.id_user, u.first_name, u.last_name, count(a.id_account) as "Numar conturi" from user_ana u join account_ana a on a.id_user = u.id_user 
    where a.id_account in (select a.id_account from account_ana a join comment_ana c on c.id_account = a.id_account) group by u.id_user,  u.first_name, u.last_name);
    
select * from active_users_ana;

--O operatie LMD permisa este SELECT, aceasta fiind permisa in orice vizualizare compusa
--Nicio alta operatie LMD (UPDATE, INSERT, DELETE) nu este permisa in vizualizarea de fata, deoarece nu avem niciun tabel key-preserved
--Utilizam in aceasta vizualizare si operatia de join si group by, ceea ce o face o vizualizare compusa

--15
create index index_name_ana
on user_ana (first_name, last_name);
 
select first_name, last_name 
from user_ana
where last_name = 'Borris' and first_name = 'Arnold';

--Utilizez un index pentru tabelul utilizator pentru nume si prenume, deoarece acestea sunt cele mai folosite 
--coloane si, in acelasi timp, este improbabil sa fie modificate.
--Index-ul sorteaza in ordine lexicografica, asigurand cautarea eficienta prin toate randurile.

--16 

--Pentru fiecare retea vreau sa aflu numele administratorului, daca are sau nu actualizari, daca are sau nu feedback-uri si numarul de conturi
select n.network_name, ad.last_name, decode(u.id_network, null, 'Nu', 'Da') as "Este actualizata", 
       decode(f.id_network, null, 'Nu', 'Da') as "Are feedback", count(a.id_account)
from network_ana n left outer join administrator_ana ad on ad.id_admin = n.id_admin
                   left outer join feedback_ana f on n.id_network = f.id_network
                   left outer join account_ana a on a.id_network = n.id_network
                   left outer join update_ana u on u.id_network = n.id_network
group by n.id_network,n.network_name, ad.last_name, f.id_network, u.id_network;

--Afisati toate titlurile de postari care au acelasi text si data cu un comentariu.

update comment_ana
set comment_text = (select post_text from post_ana where id_post = 11), comment_date = (select post_date from post_ana where id_post = 11)
where id_post = 3;

select title
from post_ana
where (post_text, post_date) in (select comment_text, comment_date from comment_ana);

--Afisati datele de contact ale administratorilor care sunt si programatori.

update administrator_ana
set last_name = (select last_name from programmer_ana where id_programmer = 4), first_name = (select first_name from programmer_ana where id_programmer = 4)
where id_admin = 5;

select contact
from administrator_ana
where (last_name, first_name) in (select last_name, first_name from programmer_ana);

--17

--Sa se afiseze date despre toate retelele care au primit un update pe partea de frontend

select n.network_name, n.contact
from network_ana n join update_ana u using (id_network) join programmer_ana p using (id_programmer)
where lower(p.job_title) = 'frontend';







