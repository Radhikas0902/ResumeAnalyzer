<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resume Analyzer - Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #f0f9fa;
            --text-color: #121212;
            --accent: #00c2a8;
            --card-bg: #ffffff;
            --button-bg: #00c2a8;
            --button-text: #ffffff;
        }

        body.dark-mode {
            --bg-color: #1c1c1c;
            --text-color: #f0f0f0;
            --card-bg: #2c2c2c;
            --button-bg: #00c2a8;
            --button-text: #ffffff;
        }

        body {
            margin: 0;
            padding: 0;
            background: var(--bg-color);
            font-family: 'Poppins', sans-serif;
            color: var(--text-color);
            transition: all 0.3s ease;
        }

        .navbar {
            background-color: var(--card-bg);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar h1 {
            color: var(--accent);
            margin: 0;
        }

        .nav-links a {
            margin-left: 20px;
            text-decoration: none;
            color: var(--accent);
            font-weight: 600;
        }

        .container {
            text-align: center;
            padding: 50px 20px;
        }

        .container h2 {
            font-size: 32px;
            color: var(--accent);
        }

        .buttons a {
            display: inline-block;
            padding: 12px 20px;
            margin: 15px;
            background: var(--button-bg);
            color: var(--button-text);
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .glass-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 50px;
            gap: 30px;
        }

        .glass-card {
            background: var(--card-bg);
            padding: 25px;
            width: 280px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15);
            transition: transform 0.3s;
        }

        .glass-card:hover {
            transform: translateY(-10px);
        }

        .glass-card h3 {
            color: var(--accent);
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 26px;
            margin-left: 20px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 30px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: var(--accent);
        }

        input:checked + .slider:before {
            transform: translateX(24px);
        }

        .chatbot-button {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 90px;
            height: 90px;
            background: #fff;
            border-radius: 50%;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .chatbot-button img {
            width: 50px;
            height: 50px;
        }

        .chat-window {
            position: fixed;
            bottom: 100px;
            right: 30px;
            width: 300px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            display: none;
            flex-direction: column;
            z-index: 1000;
            color: #000000;
        }

        .chat-header {
            background: var(--accent);
            color: white;
            padding: 10px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            font-weight: bold;
        }

        .chat-body {
            padding: 15px;
            height: 200px;
            overflow-y: auto;
            font-size: 14px;
            color: #000000;
        }

        .chat-body p {
            margin: 5px 0;
            color: #000000;
        }

        .chat-input {
            display: flex;
            border-top: 1px solid #ddd;
        }

        .chat-input input {
            flex: 1;
            border: none;
            padding: 10px;
            font-size: 14px;
        }

        .chat-input button {
            padding: 10px;
            background: var(--accent);
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>

    <script>
        function toggleChat() {
            const win = document.getElementById('chatWindow');
            win.style.display = win.style.display === 'flex' ? 'none' : 'flex';
        }

        function sendMessage() {
            const input = document.getElementById('chatInput');
            const message = input.value.trim();
            if (message === '') return;

            const chatBody = document.getElementById('chatBody');
            const userMsg = document.createElement('p');
            userMsg.innerHTML = '<strong>You:</strong> ' + message;
            chatBody.appendChild(userMsg);

            const botMsg = document.createElement('p');
            botMsg.innerHTML = '<strong>Bot:</strong> ' + getBotReply(message);
            chatBody.appendChild(botMsg);

            input.value = '';
            chatBody.scrollTop = chatBody.scrollHeight;
        }

        function getBotReply(msg) {
            msg = msg.toLowerCase();
            if (msg.includes('ati')) return 'ATI score shows how well your resume matches the job description.';
            if (msg.includes('upload')) return 'Go to the Upload Resume section and select your file.';
            if (msg.includes('dashboard')) return 'Admin Dashboard lets admins review all resume stats.';
            if (msg.includes('predict')) return 'The Career Predictor feature uses resume keywords to suggest roles.';
            return 'Sorry, I didn\'t understand that. Try asking about "ATI Score", "Upload", or "Predictor".';
        }

        function toggleMode() {
            const isDark = document.body.classList.toggle('dark-mode');
            document.getElementById("modeSwitch").checked = isDark;
        }
    </script>
</head>
<body>
<div class="navbar">
    <h1>Resume Analyzer</h1>
    <div class="nav-links">
        <a href="upload.jsp">Upload Resume</a>
        <a href="dashboard.jsp">Admin Dashboard</a>
        <label class="switch">
            <input type="checkbox" onchange="toggleMode()" id="modeSwitch">
            <span class="slider"></span>
        </label>
    </div>
</div>

<div class="container">
    <h2>Welcome to the Smart Resume Screening Portal</h2>
    <p>Upload your resume and compare it with job descriptions. Your ATI Score shows how well your resume matches the role!</p>
    <div class="buttons">
        <a href="upload.jsp">Upload Resume</a>
    </div>

  <div class="glass-cards">
    <div class="glass-card">
        <h3> ATS Compatibility Score</h3>
        <p>Check how well your resume matches job roles using AI-based resume parsing and keyword matching.</p>
    </div>
    <div class="glass-card">
        <h3>Career Path Predictor</h3>
        <p>Let our system suggest possible career tracks based on your resume content or selected preferences.</p>
    </div>
    <div class="glass-card">
        <h3> Resume Skill Extractor</h3>
        <p>Extract technical and soft skills from uploaded resumes and compare them with job requirements.</p>
    </div>

    </div>
</div>

<!-- Chatbot Icon -->
<div class="chatbot-button" onclick="toggleChat()">
    <img src="images/robot.jpg" alt="Bot">
</div>

<!-- Chatbot Window -->
<div class="chat-window" id="chatWindow">
    <div class="chat-header">Resume Bot</div>
    <div class="chat-body" id="chatBody">
        <p><strong>Bot:</strong> Hi! Need help with resumes or ATI Score?</p>
    </div>
    <div class="chat-input">
        <input type="text" id="chatInput" placeholder="Ask me..." onkeydown="if(event.key === 'Enter') sendMessage()">
        <button onclick="sendMessage()">➤</button>
    </div>
</div>
</body>
</html>
