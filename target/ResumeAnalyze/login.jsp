<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        body {
            background: #121212;
            color: #fff;
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background: #1f1f1f;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #000;
            width: 300px;
        }
        h2 {
            text-align: center;
            color: #00ffe7;
        }
        input, button {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-size: 16px;
        }
        input {
            background-color: #2a2a2a;
            color: #fff;
        }
        button {
            background-color: #00ffe7;
            color: #000;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #00c2a8;
        }
        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Admin Login</h2>
        <form action="login" method="post">
            <input type="text" name="username" placeholder="Username" required />
            <input type="password" name="password" placeholder="Password" required />
            <button type="submit">Login</button>
        </form>
        <div class="error">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
        </div>
    </div>
</body>
</html>
