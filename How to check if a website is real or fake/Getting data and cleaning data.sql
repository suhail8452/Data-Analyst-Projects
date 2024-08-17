# Create database
CREATE DATABASE IF NOT EXISTS webpage_phishing;

USE webpage_phishing;

# Create table to load data from csv file into table
# quicker than using table data import wizard
CREATE TABLE IF NOT EXISTS info
( 
url_length INT,
n_dots INT,
n_hyphen INT,
n_underline INT,
n_slash INT,
n_questionmark INT,
n_equal INT,
n_at INT,
n_and INT,
n_exclamation INT,
n_space INT,
n_tilde INT,
n_comma INT,
n_plus INT,
n_asterisk INT,
n_hashtag INT,
n_dollar INT,
n_percent INT,
n_redirection INT,
phishing INT
);

# Make sure the table is as expected
#SELECT * from info;
# Make  sure the file is located where the secure-file-priv path is. This will allow the file to load without an error.
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/web-page-phishing.csv"
INTO TABLE info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# Create two tables to split up table "info"
CREATE TABLE IF NOT EXISTS web_page_phishing (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    url_length VARCHAR(300) NOT NULL,
    n_redirection INT NOT NULL,
    phishing INT NOT NULL
);

INSERT INTO web_page_phishing (url_length, n_redirection, phishing)
SELECT url_length, n_redirection, phishing
FROM info;

select * from web_page_phishing;

CREATE TABLE IF NOT EXISTS phishing_dataset
( 
user_id INT AUTO_INCREMENT PRIMARY KEY,
n_dots INT NOT NULL,
n_hyphen INT NOT NULL,
n_underline INT NOT NULL,
n_slash INT NOT NULL,
n_questionmark INT NOT NULL,
n_equal INT NOT NULL,
n_at INT NOT NULL,
n_and INT NOT NULL,
n_exclamation INT NOT NULL,
n_space INT NOT NULL,
n_tilde INT NOT NULL,
n_comma INT NOT NULL,
n_plus INT NOT NULL,
n_asterisk INT NOT NULL,
n_hashtag INT NOT NULL,
n_dollar INT NOT NULL,
n_percent INT NOT NULL
);

INSERT INTO phishing_dataset (n_dots, n_hyphen, n_underline, n_slash, n_questionmark, n_equal, n_at, n_and, n_exclamation, n_space, n_tilde, n_comma, n_plus, n_asterisk, n_hashtag, n_dollar, n_percent)
SELECT n_dots, n_hyphen, n_underline, n_slash, n_questionmark, n_equal, n_at, n_and, n_exclamation, n_space, n_tilde, n_comma, n_plus, n_asterisk, n_hashtag, n_dollar, n_percent
FROM info;

select * from phishing_dataset;

# check to see if both datasets are clean and no null results.
SELECT *
FROM web_page_phishing
WHERE
    url_length IS NULL
    OR n_redirection IS NULL
    OR phishing IS NULL;

SELECT *
FROM phishing_dataset
WHERE COALESCE(n_dots, n_hyphen,  n_underline,  n_slash, n_questionmark,  n_equal,  n_at,  n_and, 
n_exclamation,  n_space,  n_tilde,  n_comma,  n_plus, n_asterisk,  n_hashtag,  
n_dollar, n_percent) IS NULL;
