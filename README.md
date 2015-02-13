R codes
=======

When it comes to perform statistical analysis, data mining, visualization and sometimes even web application development, R has been my first choice of language. 
Many times, I wrote a code to help friends and co-workers solve R related problems efficiently. I decide to share some of the codes here. I hope you find them useful :)



## List of Activities

1. **[THREE_ARMIA.R](https://github.com/powerlim2/R/blob/master/R/THREE_ARIMA.R)**
	* Present 3 different ways to perform ARIMA analysis on multilevel data and compare the computational efficiency. 
	When running arima(), it turns out that 'by()' is more efficient than 'dlply()' and 'for loop'.
	
2. **[DATA_WRANGLING_ADD_COLUMNS.R](https://github.com/powerlim2/R/blob/master/R/DATA_WRANGLING_ADD_COLUMNS.R)**
	* An example of Time-Series data manipulation: Marketing data.
	* Generate additional n columns: if the value is positive, give the time when the value happens, otherwise give 0.

3. **[LIST_TO_TRANSACTIONS.R](https://github.com/powerlim2/R/blob/master/R/LIST_TO_TRANSACTIONS.R)**
	* Data Wrangling function to perform Market Basket Analysis using "arules" package. 
	* We can easily make basket rows without worrying about sparsity of data within database using `GROUP_CONCAT()` function.
    * Using database to build an input feasure set is especially recommended when the size of raw data is large (100+ GB).
	* The output of `GROUP_CONCAT()` gives us (basket_id, "item 1, item 2, item 3, ..., item N")
	However, due to the quotation marks, default import in R will recognize number of items as just 1 item with long name.
	* This approach handles such problem effectively and enable us to run Apriori algorithm efficiently in R.

4. **[SAMPLE_SIZE.R](https://github.com/powerlim2/R/blob/master/R/SAMPLE_SIZE.R)**
	* Calculate the appropriate sample size for A/B testing based on alpha, power, size ratio, props  
	* Reference: [http://web.stanford.edu/~kcobb/hrp259/lecture11](http://web.stanford.edu/~kcobb/hrp259/lecture11.ppt)
	
