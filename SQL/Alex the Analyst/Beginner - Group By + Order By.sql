-- Group By
-- When you use the GROUP BY clause in a MySQL query, it groups together rows that have the same values in the specified column or columns.
-- GROUP BY is going to allow us to group rows that have the same data and run aggregate functions on them
-- Ketika Anda menggunakan klausa GROUP BY dalam kueri MySQL, klausa ini mengelompokkan baris-baris yang memiliki nilai yang sama dalam satu atau beberapa kolom yang ditentukan.
-- GROUP BY akan memungkinkan kita untuk mengelompokkan baris-baris yang memiliki data yang sama dan menjalankan fungsi agregat pada baris-baris tersebut.
SELECT *
FROM employee_demographics;

-- when you use group by  you have to have the same columns you're grouping on in the group by statement
-- ketika Anda menggunakan group by Anda harus memiliki kolom yang sama dengan yang Anda kelompokkan dalam pernyataan group by
SELECT gender
FROM employee_demographics
GROUP BY gender
;


SELECT first_name
FROM employee_demographics
GROUP BY gender
;





SELECT occupation
FROM employee_salary
GROUP BY occupation
;

-- notice there is only one office manager row
-- perhatikan hanya ada satu baris manajer kantor
-- when we group by 2 columns we now have a row for both occupation and salary because salary is different
-- ketika kita mengelompokkan berdasarkan 2 kolom, kita sekarang memiliki baris untuk pekerjaan dan gaji karena gaji berbeda
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

-- now the most useful reason we use group by is so we can perform out aggregate functions on them
-- sekarang alasan paling berguna kita menggunakan group by adalah agar kita dapat menjalankan fungsi agregat pada mereka
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;

SELECT gender, MIN(age), MAX(age), COUNT(age),AVG(age)
FROM employee_demographics
GROUP BY gender
;



#10 - The ORDER BY clause:
-------------------------
#The ORDER BY keyword is used to sort the result-set in ascending or descending order.
#Kata kunci ORDER BY digunakan untuk mengurutkan kumpulan hasil dalam urutan menaik atau menurun.

#The ORDER BY keyword sorts the records in ascending order by default. To sort the records in descending order, use the DESC keyword.
#Kata kunci ORDER BY mengurutkan data dalam urutan menaik secara default. Untuk mengurutkan data dalam urutan menurun, gunakan kata kunci DESC.

#So let's try it out with our customer table
#First let's start simple with just ordering by one column
#Jadi, mari kita coba dengan tabel pelanggan kita.
#Pertama, mari kita mulai dengan sederhana, cukup mengurutkan berdasarkan satu kolom.
SELECT *
FROM customers
ORDER BY first_name;

#You can see that first name is ordered from a - z or Ascending.
#Anda dapat melihat bahwa nama depan diurutkan dari a - z atau Ascending.

#We can change that by specifying DESC after it
#Kita dapat mengubahnya dengan menentukan DESC setelahnya
SELECT *
FROM employee_demographics;

-- if we use order by it goes a to z by default (ascending order)
-- jika kita menggunakan order by maka urutannya adalah a sampai z secara default (urutan menaik)
SELECT *
FROM employee_demographics
ORDER BY first_name;

-- we can manually change the order by saying desc
-- kita dapat mengubah urutannya secara manual dengan mengatakan desc
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

#Now we can also do multiple columns like this:
#Sekarang kita juga dapat membuat beberapa kolom seperti ini:
SELECT *
FROM employee_demographics
ORDER BY gender, age;

SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC;



#now we don't actually have to spell out the column names. We can actually just use their column position
#Sekarang kita tidak perlu lagi mengeja nama kolom. Kita bisa langsung menggunakan posisi kolomnya.

#State ada di posisi 8 dan money ada di posisi 9, kita juga bisa menggunakannya.
#State is in position 8 and money is in 9, we can use those as well.
SELECT *
FROM employee_demographics
ORDER BY 5 DESC, 4 DESC;

#Now best practice is to use the column names as it's more overt and if columns are added or replaced or something in this table it will still use the right columns to order on.
#Sekarang, praktik terbaiknya adalah menggunakan nama kolom karena lebih jelas dan jika kolom ditambahkan atau diganti atau sesuatu di tabel ini, kolom yang tepat akan tetap digunakan untuk mengurutkan.

#Jadi, hanya itu yang perlu diurutkan - cukup mudah, tetapi sesuatu yang saya gunakan untuk sebagian besar kueri yang saya gunakan di SQL.
#So that's all there is to order by - fairly straight forward, but something I use for most queries I use in SQL










