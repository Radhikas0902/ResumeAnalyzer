<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="rad.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            background-color: #121212;
            color: white;
            font-family: Arial;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #00ffe7;
        }
        table {
            width: 100%;
            background-color: #1f1f1f;
            color: #00ffe7;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #333;
            text-align: left;
        }
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .search-form input[type="text"] {
            padding: 6px;
            width: 250px;
            border-radius: 5px;
            border: none;
        }
        .search-form button {
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            background-color: #00ffe7;
            color: #121212;
            font-weight: bold;
            cursor: pointer;
        }
        .logout-button {
            background-color: red;
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .feedback {
            color: orange;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <form class="search-form" method="get" action="dashboard.jsp">
            <input type="text" name="search" placeholder="Search by name or skills..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <button type="submit">🔍 Search</button>
        </form>

        <form action="logout.jsp" method="get">
            <button class="logout-button" type="submit">🚪 Logout</button>
        </form>
    </div>

    <h2>📊 Admin Dashboard</h2>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String search = request.getParameter("search");

        try {
            conn = DBConnection.getConnection();

            if (search != null && !search.trim().isEmpty()) {
                stmt = conn.prepareStatement(
                    "SELECT r.name, r.email, r.skills, r.experience, r.ati_score, j.title, j.required_skills " +
                    "FROM resumes r JOIN job_descriptions j ON r.job_id = j.id " +
                    "WHERE LOWER(r.name) LIKE ? OR LOWER(r.skills) LIKE ?"
                );
                String keyword = "%" + search.toLowerCase() + "%";
                stmt.setString(1, keyword);
                stmt.setString(2, keyword);
            } else {
                stmt = conn.prepareStatement(
                    "SELECT r.name, r.email, r.skills, r.experience, r.ati_score, j.title, j.required_skills " +
                    "FROM resumes r JOIN job_descriptions j ON r.job_id = j.id"
                );
            }

            rs = stmt.executeQuery();
            int count = 0;
    %>

    <% if (search != null && !search.trim().isEmpty()) { %>
        <div class="feedback">🔍 Showing results for: "<%= search %>"</div>
    <% } %>

    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Job Title</th>
            <th>ATI Score</th>
            <th>Skills</th>
            <th>Experience</th>
        </tr>

        <%
            while (rs.next()) {
                count++;
                int score = rs.getInt("ati_score");

                String resumeSkills = rs.getString("skills");
                resumeSkills = (resumeSkills != null) ? resumeSkills.toLowerCase() : "";

                String requiredSkills = rs.getString("required_skills");
                requiredSkills = (requiredSkills != null) ? requiredSkills.toLowerCase() : "";

                List<String> missingSkills = new ArrayList<>();
                String[] requiredSkillsArray = requiredSkills.isEmpty() ? new String[0] : requiredSkills.split(",\\s*");
                for (String skill : requiredSkillsArray) {
                    if (!resumeSkills.contains(skill.trim())) {
                        missingSkills.add(skill.trim());
                    }
                }
        %>
            <tr>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("title") %></td>
                <td>
                    <%= score %>% 
                    <%= score < 60 ? " <span style='color:orange;'>⚠️ Improve Skills</span>" : "" %>
                </td>
                <td><%= rs.getString("skills") != null ? rs.getString("skills") : "-" %></td>
                <td><%= rs.getString("experience") != null ? rs.getString("experience") : "-" %></td>
            </tr>

            <% if (score < 60 && !missingSkills.isEmpty()) { %>
                <tr>
                    <td colspan="6" class="feedback">
                        🔧 Feedback: You may be missing these skills: <%= String.join(", ", missingSkills) %>
                    </td>
                </tr>
            <% } %>
        <%
            }

            // Only show "No results found" if user searched something and got no matches
            if (count == 0 && search != null && !search.trim().isEmpty()) {
        %>
            <tr>
                <td colspan="6" class="feedback">❌ No results found for "<%= search %>"</td>
            </tr>
        <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>
    </table>
</body>
</html>
