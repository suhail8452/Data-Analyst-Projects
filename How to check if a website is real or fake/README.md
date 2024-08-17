# How to check if a website is real or fake

The data is available to download : https://www.kaggle.com/datasets/danielfernandon/web-page-phishing-dataset?resource=download
The data counts the number of times a symbol appears in the url, the url length, the number of redirections and if the website is real or not.

## Objectives 
Which field has the strongest and weakest correlation with the phishing field and why?
Is the URL length a good indicator of whether a website is phishing or not?
Is the number of redirections a good indicator whether a website is phishing or not?
What advice would you give someone to avoid phishing website?

## Method

### Getting Data and cleaning data.sql
Using MYSQL I used LOAD DATA INFILE to get the data into a table since using the table wizard was taking too long. Once the data is on the workbench, I
split the data into two table one containing only symbols and the other table the rest of the data. Then I checked to make sure there is no null results in each of the table. 

### Answering Questions.sql

I wrote SQL code average url length and redirection for phishing and real websites.
Created two table, one table with all the symbols when the website is phishing and the other table with all the symbols when the website is real.
I found the average, standard deviation and the number of time the symbol appears in a url for the real and phishing websites.
Got rid of any null results.

### Combining data

Using excel to combine two tables that I was having difficulty combining in Power Bi.

### Visualizing results 

Import table from MYSQL to Power Bi to create visualization to answer questions.

## Results

### Which field has the strongest and weakest correlation with the phishing field and why?

The symbols with the strongest correlation to a phishing websites are asterisk (*), hashtag (#) and dollar sign ($). No real website in the dataset contains any of these symbols in the url. 

The average percent (%) symbols for real website is more than twice than fake websites. Using the standard deviation and calculating a 95% confidence range, a url with a more then 22 percent symbols in the url is more likely to be real than phishing.

The average slash symbol (/) for real website is 1.65 while for fake websites it's 3.18. Real website upper range have a 95 % confidence is 3.79 while for phishing websites it's 7.15. 

The symbols with the weakest correlation is the space ( ), question mark (?) and tilde (~) because they have a similar average and standard deviation so will be hard to differentiate whether the website is real or not.

The at (@) symbols for real website has a standard deviation of 0.0 and an average of 1.0. So a website is likely to be phishing if contains more than 1 at symbol

### Is the URL length a good indicator of whether a website is phishing or not?
Taking the average url length for phising and real websites, phishing website have an average character length of 66.5 while real website have an average length 23.6. The longer the url length the greater the chance the website is phishing. Phishing website have a standard deviation of 68.6 while real website it's 16.1.

### Is the number of redirections a good indicator whether a website is phishing or not?
The number of redirections gives no idicatation whether a website is phishing or not as the average values are close to one another and the standard deviation is close as well.

### What advice would you give someone to avoid phishing website?

The number of time the asterisk, hashtag and dollar sign appear is less than a hundred url each out of more than 100,000 websites. The two best indicators for a website will be the url length and the slash symbols. A url with a length more than 40 characters is a raise for concern and the longer the url the more likely it is phishing. A url with more than 4 slash symbols has a good chance of being a phishing website.


