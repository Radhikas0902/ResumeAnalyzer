<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="rad.DBConnection" %>

<html>
<head>
    <title>Upload Resume</title>
    <style>
        body {
            background-color: #121212;
            color: white;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 80px auto;
            background-color: #1f1f1f;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 15px rgba(0, 255, 255, 0.08);
        }

        h2 {
            color: #00d1b2;
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #ccc;
            font-size: 15px;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            border: none;
            border-radius: 10px;
            background-color: #2b2b2b;
            color: white;
            font-size: 14px;
        }

        .btn {
            background-color: #00d1b2;
            color: black;
            font-weight: bold;
            border: none;
            padding: 12px;
            border-radius: 10px;
            width: 100%;
            margin-top: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #00bfa5;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Upload Your Resume</h2>
       <form action="analyze" method="post" enctype="multipart/form-data">

            <label for="name">Your Name</label>
            <input type="text" name="name" id="name" required />

            <label for="email">Email</label>
            <input type="email" name="email" id="email" required />

            <label for="job_id">Select Job Role</label>
            <select name="job_id" id="job_id" required>
               <option value="1">Software Developer</option>
               <option value="2">Web Developer</option>
               <option value="3">Frontend Developer</option>
               <option value="4">Backend Developer</option>
               <option value="5">Full Stack Developer</option>
               <option value="6">Java Developer</option>
               <option value="7">Python Developer</option>
               <option value="8">Mobile App Developer</option>
               <option value="9">Data Analyst</option>
               <option value="10">Data Scientist</option>
               <option value="11">Machine Learning Engineer</option>
               <option value="12">DevOps Engineer</option>
               <option value="13">Cloud Engineer</option>
               <option value="14">Cybersecurity Analyst</option>
               <option value="15">QA/Test Engineer</option>
               <option value="16">UI/UX Designer</option>
               <option value="17">System Administrator</option>
               <option value="18">Database Administrator</option>
               <option value="19">IT Support Specialist</option>
               <option value="20">Network Engineer</option>
            </select>

            <label for="resume">Upload Resume (.pdf or .docx)</label>
            <input type="file" name="resume" id="resume" accept=".pdf,.docx" required />

            <button type="submit" class="btn">Analyze Resume</button>
        </form>
    </div>
</body>
</html>
