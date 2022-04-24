-----------------------------------------------------------------------------------------
--Deliverable 1
-----------------------------------------------------------------------------------------

--The Number of Retiring Employees by Title.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY count DESC;

-----------------------------------------------------------------------------------------
--Deliverable 2
-----------------------------------------------------------------------------------------

--Mentorship Elegibility 
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE de.to_date = ('9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

-----------------------------------------------------------------------------------------
--Deliverable 3
-----------------------------------------------------------------------------------------

SELECT ut.emp_no,
    ut.first_name,
	ut.last_name,
	ut.title,
    e.birth_date,
    de.to_date
INTO oldest_retiring
FROM unique_titles as ut
INNER JOIN employees as e
ON (ut.emp_no = e.emp_no)
INNER JOIN dept_emp as de
ON (ut.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1952-12-31')
	 AND (de.to_date = '9999-01-01');
