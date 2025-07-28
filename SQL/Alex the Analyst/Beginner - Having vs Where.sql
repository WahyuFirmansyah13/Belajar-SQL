-- Having vs Where

-- Both were created to filter rows of data, but they filter 2 separate things
-- Where is going to filters rows based off columns of data
-- Having is going to filter rows based off aggregated columns when grouped
-- Keduanya dibuat untuk memfilter baris data, tetapi keduanya memfilter 2 hal yang berbeda
-- Di mana akan memfilter baris berdasarkan kolom data
-- Setelah akan memfilter baris berdasarkan kolom agregat saat dikelompokkan
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;


-- let's try to filter on the avg age using where
-- mari kita coba untuk memfilter berdasarkan usia rata-rata menggunakan where

SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender
;
-- this doesn't work because of order of operations. On the backend Where comes before the group by. So you can't filter on data that hasn't been grouped yet
-- this is why Having was created
-- ini tidak berfungsi karena urutan operasi. Di backend, Where muncul sebelum group by. Jadi, Anda tidak dapat memfilter data yang belum dikelompokkan.
-- inilah alasan diciptakannya Having.
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT gender, AVG(age) as AVG_age
FROM employee_demographics
GROUP BY gender
HAVING AVG_age > 40
;
































