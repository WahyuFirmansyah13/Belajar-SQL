-- LIMIT and ALIASING

-- Limit is just going to specify how many rows you want in the output
-- Limit hanya akan menentukan berapa banyak baris yang Anda inginkan dalam output

SELECT *
FROM employee_demographics
LIMIT 3;

-- if we change something like the order or use a group by it would change the output
-- jika kita mengubah sesuatu seperti urutan atau menggunakan grup, itu akan mengubah output
SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3;

-- now there is an additional paramater in limit which we can access using a comma that specifies the starting place
-- sekarang ada parameter tambahan dalam limit yang dapat kita akses menggunakan koma yang menentukan tempat awal
SELECT *
FROM employee_demographics
ORDER BY first_name;

SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3,2;

-- this now says start at position 3 and take 2 rows after that
-- this is not used a lot in my opinion
-- sekarang ini mengatakan mulai dari posisi 3 dan ambil 2 baris setelahnya
-- menurut saya ini tidak banyak digunakan

-- you could us it if you wanted to select the third oldest person by doing this:
-- Anda dapat menggunakannya jika Anda ingin memilih orang tertua ketiga dengan melakukan ini:
SELECT *
FROM employee_demographics
ORDER BY age desc;
-- we can see it's Donna - let's try to select her
SELECT *
FROM employee_demographics
ORDER BY age desc
LIMIT 2,1;


-- ALIASING

-- aliasing is just a way to change the name of the column (for the most part)
-- it can also be used in joins, but we will look at that in the intermediate series
-- aliasing hanyalah cara untuk mengubah nama kolom (sebagian besar)
-- aliasing juga dapat digunakan dalam gabungan, tetapi kita akan membahasnya dalam seri perantara

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;
-- we can use the keyword AS to specify we are using an Alias
-- kita dapat menggunakan kata kunci AS untuk menentukan bahwa kita menggunakan Alias
SELECT gender, AVG(age) AS Avg_age
FROM employee_demographics
GROUP BY gender
;

-- although we don't actually need it, but it's more explicit which I usually like
-- meskipun kita sebenarnya tidak membutuhkannya, tapi ini lebih eksplisit yang biasanya saya suka
SELECT gender, AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender
;









