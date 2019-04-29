<p><b>Compiled database scheme for the subject area (Company).</b></p>
<p>The schema database corresponds to the third normal form (3NF).</p>
<b>Subject Area Description:</b>
<ul>
<li>The company employs employees performing projects (project data: name, creation date, open / closed status, closing date).</li>
<li>An employee may carry out several projects, his position may differ on different projects.</li>
<li>Tasks on the project are given to the employee with the indication of the deadline. The task can be in the status: Open, completed, needs some work, accepted (closed), indicating the date of the status and the status of the employee.</li>
</ul>

<b>The following queries for sampling / changing data are written:</b>
<ol>
  <li>
Get a list of all company positions with the number of employees in each of them.</li>
  <li>
Determine the list of company posts with no employees.</li>
  <li>
To receive the list of projects with indication of how many employees of each position work on the project</li>
  <li>
Calculate on each project, what is the average number of tasks per employee</li>
  <li>
Calculate the duration of each project</li>
  <li>
Identify employees with a minimum number of unclosed tasks.</li>
  <li>
Identify employees with the maximum number of unclosed tasks whose deadline has already expired.</li>
  <li>
Extend deadline for unclosed tasks for 5 days</li>
  <li>
Count on each project the number of tasks that have not yet begun</li>
  <li>
Transfer projects to the closed state, for which all tasks are closed and set the closing time by the closing time of the project task accepted by the last</li>
  <li>
Find out for all projects which employees on the project do not have unclosed tasks.</li>
  <li>
The assigned task (by title) of the project is transferred to an employee with a minimum number of tasks performed by him.</li>
</ol>
