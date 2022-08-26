--list of sales department retirees
SELECT dp.emp_no,
    ri.first_name,
    ri.last_name,
	d.dept_name
INTO sales_retiree
FROM dept_emp AS dp
	    INNER JOIN retirement_info AS ri
		     ON (dp.emp_no = ri.emp_no)
		INNER JOIN departments AS d
		  	 ON (dp.dept_no = d.dept_no)
			 WHERE (d.dept_name = 'Sales')
			 
			 
--list of sales and development retirees			 
SELECT dp.emp_no,
    ri.first_name,
    ri.last_name,
	d.dept_name
INTO sales_and_dev_retiree
FROM dept_emp AS dp
	    INNER JOIN retirement_info AS ri
		     ON (dp.emp_no = ri.emp_no)
		INNER JOIN departments AS d
		  	 ON (dp.dept_no = d.dept_no)
			 WHERE d.dept_name IN ('Sales', 'Development')
			 
			 
			 
			 
			 
-- Create list of the titles of retiring employees
SELECT e.emp_no, 
       e.first_name, 
	   e.last_name,
	   ti.title, 
	   ti.from_date,
	   ti.to_date
INTO retirement_titles
FROM employees as e
    INNER JOIN titles AS ti
	 ON (e.emp_no = ti.emp_no)
	 WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	 ORDER BY (e.emp_no)

SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
    last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

--list of the number of titles of emloyees retiring.
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT(emp_no) DESC;


--employees eligible for mentorship program
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty	
FROM employees as e
JOIN dept_emp as de ON de.emp_no = e.emp_no
JOIN titles as ti ON ti.emp_no = e.emp_no
	WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

