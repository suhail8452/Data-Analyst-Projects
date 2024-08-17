# Which field has the strongest correlation with the phishing field and which has the weakest correlation?
use webpage_phishing;

# Where 1 is a phished website and 0 is a real website
CREATE TABLE IF NOT EXISTS url
SELECT phishing, AVG(url_length) AS URL_A, STD(url_length) AS URL_S
FROM web_page_phishing
GROUP BY phishing;

# The same can be done for the number of redirections
# Can't have negative redirections
CREATE TABLE IF NOT EXISTS n_re
SELECT phishing, AVG(n_redirection) AS N_A, STD(n_redirection) AS N_S
FROM web_page_phishing
where n_redirection > 0
GROUP BY phishing;

CREATE TABLE IF NOT EXISTS COMBINED
SELECT  url.phishing, url.URL_A, url.URL_S, n_re.N_A, n_re.N_S  from url
JOIN
n_re ON url.phishing = n_re.phishing;




# Get all of the user id from the phished data
#SELECT user_id FROM web_page_phishing
#WHERE phishing = 1;
CREATE TABLE IF NOT EXISTS Fake_website AS
SELECT * FROM  phishing_dataset
WHERE user_id IN (
SELECT user_id 
FROM web_page_phishing 
WHERE phishing =1);

# Get all the user_id from the real website
CREATE TABLE IF NOT EXISTS Real_website AS
SELECT * FROM  phishing_dataset
WHERE user_id IN (
SELECT user_id 
FROM web_page_phishing 
WHERE phishing =0);

#create a table to find out how many times a symbol appears if the website is fake or real
# If the symbol doesn't appear in the phished or real website. The symbol is not counted.
CREATE TABLE IF NOT EXISTS count AS
SELECT
	"Fake" as website,
    sum(CASE WHEN n_dots <> 0 THEN 1 ELSE 0 END) AS count_n_dots,
    sum(CASE WHEN n_hyphen <> 0 THEN 1 ELSE 0 END) AS count_n_hyphen,
    sum(CASE WHEN n_underline <> 0 THEN 1 ELSE 0 END) AS count_n_underline,
    sum(CASE WHEN n_slash <> 0 THEN 1 ELSE 0 END) AS count_n_slash,
    sum(CASE WHEN n_questionmark <> 0 THEN 1 ELSE 0 END) AS count_n_questionmark,
    sum(CASE WHEN n_equal <> 0 THEN 1 ELSE 0 END) AS count_n_equal,
    sum(CASE WHEN n_at <> 0 THEN 1 ELSE 0 END) AS count_n_at,
    sum(CASE WHEN n_and <> 0 THEN 1 ELSE 0 END) AS count_n_and,
    sum(CASE WHEN n_exclamation <> 0 THEN 1 ELSE 0 END) AS count_n_exclamation,
    sum(CASE WHEN n_space <> 0 THEN 1 ELSE 0 END) AS count_n_space,
    sum(CASE WHEN n_tilde <> 0 THEN 1 ELSE 0 END) AS count_n_tilde,
    sum(CASE WHEN n_comma <> 0 THEN 1 ELSE 0 END) AS count_n_comma,
    sum(CASE WHEN n_plus <> 0 THEN 1 ELSE 0 END) AS count_n_plus,
    sum(CASE WHEN n_asterisk <> 0 THEN 1 ELSE 0 END) AS count_n_asterisk,
    sum(CASE WHEN n_hashtag <> 0 THEN 1 ELSE 0 END) AS count_n_hashtag,
    sum(CASE WHEN n_dollar <> 0 THEN 1 ELSE 0 END) AS count_n_dollar,
    sum(CASE WHEN n_percent <> 0 THEN 1 ELSE 0 END) AS count_n_percent
FROM Fake_website

UNION ALL

SELECT
	"Real" as website,
    sum(CASE WHEN n_dots <> 0 THEN 1 ELSE 0 END) AS count_n_dots,
    sum(CASE WHEN n_hyphen <> 0 THEN 1 ELSE 0 END) AS count_n_hyphen,
    sum(CASE WHEN n_underline <> 0 THEN 1 ELSE 0 END) AS count_n_underline,
    sum(CASE WHEN n_slash <> 0 THEN 1 ELSE 0 END) AS count_n_slash,
    sum(CASE WHEN n_questionmark <> 0 THEN 1 ELSE 0 END) AS count_n_questionmark,
    sum(CASE WHEN n_equal <> 0 THEN 1 ELSE 0 END) AS count_n_equal,
    sum(CASE WHEN n_at <> 0 THEN 1 ELSE 0 END) AS count_n_at,
    sum(CASE WHEN n_and <> 0 THEN 1 ELSE 0 END) AS count_n_and,
    sum(CASE WHEN n_exclamation <> 0 THEN 1 ELSE 0 END) AS count_n_exclamation,
    sum(CASE WHEN n_space <> 0 THEN 1 ELSE 0 END) AS count_n_space,
    sum(CASE WHEN n_tilde <> 0 THEN 1 ELSE 0 END) AS count_n_tilde,
    sum(CASE WHEN n_comma <> 0 THEN 1 ELSE 0 END) AS count_n_comma,
    sum(CASE WHEN n_plus <> 0 THEN 1 ELSE 0 END) AS count_n_plus,
    sum(CASE WHEN n_asterisk <> 0 THEN 1 ELSE 0 END) AS count_n_asterisk,
    sum(CASE WHEN n_hashtag <> 0 THEN 1 ELSE 0 END) AS count_n_hashtag,
    sum(CASE WHEN n_dollar <> 0 THEN 1 ELSE 0 END) AS count_n_dollar,
    sum(CASE WHEN n_percent <> 0 THEN 1 ELSE 0 END) AS count_n_percent
from Real_website;


CREATE TABLE IF NOT EXISTS average AS
SELECT
	"Fake" as website,
    AVG(CASE WHEN n_dots <> 0 THEN n_dots ELSE NULL END) AS n_dots,
    AVG(CASE WHEN n_hyphen <> 0 THEN n_hyphen ELSE NULL END) AS n_hyphen,
    AVG(CASE WHEN n_underline <> 0 THEN n_underline ELSE NULL END) AS n_underline,
    AVG(CASE WHEN n_slash <> 0 THEN n_slash ELSE NULL END) AS n_slash,
    AVG(CASE WHEN n_questionmark <> 0 THEN n_questionmark ELSE NULL END) AS n_questionmark,
    AVG(CASE WHEN n_equal <> 0 THEN n_equal ELSE NULL END) AS n_equal,
    AVG(CASE WHEN n_at <> 0 THEN n_at ELSE NULL END) AS n_at,
    AVG(CASE WHEN n_and <> 0 THEN n_and ELSE NULL END) AS n_and,
    AVG(CASE WHEN n_exclamation <> 0 THEN n_exclamation ELSE NULL END) AS n_exclamation,
    AVG(CASE WHEN n_space <> 0 THEN n_space ELSE NULL END) AS n_space,
    AVG(CASE WHEN n_tilde <> 0 THEN n_tilde ELSE NULL END) AS n_tilde,
    AVG(CASE WHEN n_comma <> 0 THEN n_comma ELSE NULL END) AS n_comma,
    AVG(CASE WHEN n_plus <> 0 THEN n_plus ELSE NULL END) AS n_plus,
    AVG(CASE WHEN n_asterisk <> 0 THEN n_asterisk ELSE NULL END) AS n_asterisk,
    AVG(CASE WHEN n_hashtag <> 0 THEN n_hashtag ELSE NULL END) AS n_hashtag,
    AVG(CASE WHEN n_dollar <> 0 THEN n_dollar ELSE NULL END) AS n_dollar,
    AVG(CASE WHEN n_percent <> 0 THEN n_percent ELSE NULL END) AS n_percent
FROM Fake_website

UNION ALL

SELECT
	"Real" as website,
    AVG(CASE WHEN n_dots <> 0 THEN n_dots ELSE NULL END) AS n_dots,
    AVG(CASE WHEN n_hyphen <> 0 THEN n_hyphen ELSE NULL END) AS n_hyphen,
    AVG(CASE WHEN n_underline <> 0 THEN n_underline ELSE NULL END) AS n_underline,
    AVG(CASE WHEN n_slash <> 0 THEN n_slash ELSE NULL END) AS n_slash,
    AVG(CASE WHEN n_questionmark <> 0 THEN n_questionmark ELSE NULL END) AS n_questionmark,
    AVG(CASE WHEN n_equal <> 0 THEN n_equal ELSE NULL END) AS n_equal,
    AVG(CASE WHEN n_at <> 0 THEN n_at ELSE NULL END) AS n_at,
    AVG(CASE WHEN n_and <> 0 THEN n_and ELSE NULL END) AS n_and,
    AVG(CASE WHEN n_exclamation <> 0 THEN n_exclamation ELSE NULL END) AS n_exclamation,
    AVG(CASE WHEN n_space <> 0 THEN n_space ELSE NULL END) AS n_space,
    AVG(CASE WHEN n_tilde <> 0 THEN n_tilde ELSE NULL END) AS n_tilde,
    AVG(CASE WHEN n_comma <> 0 THEN n_comma ELSE NULL END) AS n_comma,
    AVG(CASE WHEN n_plus <> 0 THEN n_plus ELSE NULL END) AS n_plus,
    AVG(CASE WHEN n_asterisk <> 0 THEN n_asterisk ELSE NULL END) AS n_asterisk,
    AVG(CASE WHEN n_hashtag <> 0 THEN n_hashtag ELSE NULL END) AS n_hashtag,
    AVG(CASE WHEN n_dollar <> 0 THEN n_dollar ELSE NULL END) AS n_dollar,
    AVG(CASE WHEN n_percent <> 0 THEN n_percent ELSE NULL END) AS n_percent
from Real_website;


CREATE TABLE IF NOT EXISTS standard_deviation AS
SELECT
	"Fake" as website,
    stddev(CASE WHEN n_dots <> 0 THEN n_dots ELSE NULL END) AS n_dots,
    stddev(CASE WHEN n_hyphen <> 0 THEN n_hyphen ELSE NULL END) AS n_hyphen,
    stddev(CASE WHEN n_underline <> 0 THEN n_underline ELSE NULL END) AS n_underline,
    stddev(CASE WHEN n_slash <> 0 THEN n_slash ELSE NULL END) AS n_slash,
    stddev(CASE WHEN n_questionmark <> 0 THEN n_questionmark ELSE NULL END) AS n_questionmark,
    stddev(CASE WHEN n_equal <> 0 THEN n_equal ELSE NULL END) AS n_equal,
    stddev(CASE WHEN n_at <> 0 THEN n_at ELSE NULL END) AS n_at,
    stddev(CASE WHEN n_and <> 0 THEN n_and ELSE NULL END) AS n_and,
    stddev(CASE WHEN n_exclamation <> 0 THEN n_exclamation ELSE NULL END) AS n_exclamation,
    stddev(CASE WHEN n_space <> 0 THEN n_space ELSE NULL END) AS n_space,
    stddev(CASE WHEN n_tilde <> 0 THEN n_tilde ELSE NULL END) AS n_tilde,
    stddev(CASE WHEN n_comma <> 0 THEN n_comma ELSE NULL END) AS n_comma,
    stddev(CASE WHEN n_plus <> 0 THEN n_plus ELSE NULL END) AS n_plus,
    stddev(CASE WHEN n_asterisk <> 0 THEN n_asterisk ELSE NULL END) AS n_asterisk,
    stddev(CASE WHEN n_hashtag <> 0 THEN n_hashtag ELSE NULL END) AS n_hashtag,
    stddev(CASE WHEN n_dollar <> 0 THEN n_dollar ELSE NULL END) AS n_dollar,
    stddev(CASE WHEN n_percent <> 0 THEN n_percent ELSE NULL END) AS n_percent
FROM Fake_website

UNION ALL

SELECT
	"Real" as website,
	stddev(CASE WHEN n_dots <> 0 THEN n_dots ELSE NULL END) AS n_dots,
    stddev(CASE WHEN n_hyphen <> 0 THEN n_hyphen ELSE NULL END) AS n_hyphen,
    stddev(CASE WHEN n_underline <> 0 THEN n_underline ELSE NULL END) AS n_underline,
    stddev(CASE WHEN n_slash <> 0 THEN n_slash ELSE NULL END) AS n_slash,
    stddev(CASE WHEN n_questionmark <> 0 THEN n_questionmark ELSE NULL END) AS n_questionmark,
    stddev(CASE WHEN n_equal <> 0 THEN n_equal ELSE NULL END) AS n_equal,
    stddev(CASE WHEN n_at <> 0 THEN n_at ELSE NULL END) AS n_at,
    stddev(CASE WHEN n_and <> 0 THEN n_and ELSE NULL END) AS n_and,
    stddev(CASE WHEN n_exclamation <> 0 THEN n_exclamation ELSE NULL END) AS n_exclamation,
    stddev(CASE WHEN n_space <> 0 THEN n_space ELSE NULL END) AS n_space,
    stddev(CASE WHEN n_tilde <> 0 THEN n_tilde ELSE NULL END) AS n_tilde,
    stddev(CASE WHEN n_comma <> 0 THEN n_comma ELSE NULL END) AS n_comma,
    stddev(CASE WHEN n_plus <> 0 THEN n_plus ELSE NULL END) AS n_plus,
    stddev(CASE WHEN n_asterisk <> 0 THEN n_asterisk ELSE NULL END) AS n_asterisk,
    stddev(CASE WHEN n_hashtag <> 0 THEN n_hashtag ELSE NULL END) AS n_hashtag,
    stddev(CASE WHEN n_dollar <> 0 THEN n_dollar ELSE NULL END) AS n_dollar,
    stddev(CASE WHEN n_percent <> 0 THEN n_percent ELSE NULL END) AS n_percent
from Real_website;

SELECT * FROM count;
SELECT * FROM standard_deviation;
SELECT * FROM average;


# Remove safe updates
SET SQL_SAFE_UPDATES = 0;
# Update table standard_deviation and average to replace null result with zero
UPDATE standard_deviation
SET 
n_asterisk = COALESCE(n_asterisk, 0),
n_hashtag = COALESCE(n_hashtag, 0),
n_dollar = COALESCE(n_dollar, 0)
WHERE 
n_asterisk IS NULL OR
n_hashtag IS NULL OR 
n_dollar IS NULL;

UPDATE average
SET 
n_asterisk = COALESCE(n_asterisk, 0),
n_hashtag = COALESCE(n_hashtag, 0),
n_dollar = COALESCE(n_dollar, 0)
WHERE 
n_asterisk IS NULL OR
n_hashtag IS NULL OR 
n_dollar IS NULL;

# Add safe update back on
SET SQL_SAFE_UPDATES = 1;

