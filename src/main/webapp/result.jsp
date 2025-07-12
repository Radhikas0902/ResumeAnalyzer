<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Resume Analysis Result</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #121212;
            color: #ffffff;
            padding: 40px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: #1f1f1f;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 15px rgba(0, 255, 255, 0.08);
        }

        h2 {
            color: #00d1b2;
            text-align: center;
            margin-bottom: 30px;
        }

        .score-box {
            background: #2b2b2b;
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
        }

        .score-title {
            font-weight: bold;
            color: #00ffe7;
            margin-bottom: 10px;
        }

        ul {
            list-style: none;
            padding-left: 0;
        }

        ul li {
            background: #333;
            padding: 10px 15px;
            margin: 6px 0;
            border-radius: 8px;
            font-size: 14px;
        }

        .score-value {
            color: #ffffff;
            font-size: 16px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #00d1b2;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        textarea, select {
            width: 100%;
            background-color: #2b2b2b;
            border: none;
            border-radius: 10px;
            padding: 10px;
            color: white;
            margin-top: 10px;
        }

        .submit-feedback {
            background-color: #00d1b2;
            color: black;
            padding: 10px 15px;
            border-radius: 10px;
            border: none;
            margin-top: 15px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📊 Resume Analysis Result</h2>

    <div class="score-box">
        <div class="score-title">Overall ATS Score:</div>
        <div class="score-value"><%= session.getAttribute("atsScore") %>%</div>
    </div>

    <div class="score-box">
        <div class="score-title">Section-wise Breakdown:</div>
        <ul>
            <li>🎯 Tailoring Score: <%= session.getAttribute("tailoringScore") %>%</li>
            <li>📝 Grammar Score: <%= session.getAttribute("grammarScore") %>%</li>
            <li>📄 Content Score: <%= session.getAttribute("contentScore") %>%</li>
            <li>🎨 Formatting Score: <%= session.getAttribute("formattingScore") %>%</li>
        </ul>
    </div>

    <div class="score-box">
        <div class="score-title">✅ Resume Keywords Identified:</div>
        <ul>
            <%
                List<String> resumeSkills = (List<String>) session.getAttribute("resumeSkills");
                if (resumeSkills != null && !resumeSkills.isEmpty()) {
                    for (String skill : resumeSkills) {
            %>
                        <li><%= skill %></li>
            <%
                    }
                } else {
            %>
                        <li>No keywords extracted from resume.</li>
            <%
                }
            %>
        </ul>
    </div>

    <div class="score-box">
        <div class="score-title">❌ Missing from Resume (But Present in Job Description):</div>
        <ul>
            <%
                List<String> missingSkills = (List<String>) session.getAttribute("missingSkills");
                if (missingSkills != null && !missingSkills.isEmpty()) {
                    for (String skill : missingSkills) {
            %>
                        <li><%= skill %></li>
            <%
                    }
                } else {
            %>
                        <li>🎉 Great! No missing skills detected.</li>
            <%
                }
            %>
        </ul>
    </div>

  

    <hr style="margin: 40px 0; border-color: #00ffe7;">

    <div class="score-box">
        <div class="score-title">🗣️ We value your feedback!</div>
        <form action="feedback.jsp" method="post">
            <label for="rating">Rate the analysis (1 to 5):</label>
            <select id="rating" name="rating" required>
                <option value="">-- Select Rating --</option>
                <option value="5">⭐⭐⭐⭐⭐ - Excellent</option>
                <option value="4">⭐⭐⭐⭐ - Good</option>
                <option value="3">⭐⭐⭐ - Average</option>
                <option value="2">⭐⭐ - Poor</option>
                <option value="1">⭐ - Bad</option>
            </select>

            <label for="comment">Comments (optional):</label>
            <textarea id="comment" name="comment" rows="4" placeholder="What can we improve?"></textarea>

            <button type="submit" class="submit-feedback">Submit Feedback</button>
        </form>
    </div>
</div>
</body>
</html>
	