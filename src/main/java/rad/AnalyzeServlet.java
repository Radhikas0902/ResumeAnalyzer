package rad;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/upload")
@MultipartConfig
public class AnalyzeServlet extends HttpServlet {

    private static final List<String> jobSkills = Arrays.asList(
        "java", "python", "html", "css", "javascript",
        "mysql", "sql", "c++", "c", "flask", "django", "servlets", "jsp", "jdbc", "unix"
    );

    private String extractTextFromPDF(InputStream inputStream) throws IOException {
        try (PDDocument document = PDDocument.load(inputStream)) {
            PDFTextStripper stripper = new PDFTextStripper();
            return stripper.getText(document);
        }
    }

    private String extractTextFromDocx(InputStream inputStream) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (XWPFDocument document = new XWPFDocument(inputStream)) {
            for (XWPFParagraph para : document.getParagraphs()) {
                sb.append(para.getText()).append("\n");
            }
        }
        return sb.toString();
    }

    private List<String> extractSkills(String resumeText) {
        Set<String> foundSkills = new HashSet<>();
        String cleanText = resumeText.toLowerCase().replaceAll("[^a-z0-9+#.]+", " ");
        for (String skill : jobSkills) {
            if (cleanText.contains(skill.toLowerCase())) {
                foundSkills.add(skill.toLowerCase());
            }
        }
        return new ArrayList<>(foundSkills);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int jobId = Integer.parseInt(request.getParameter("job_id"));

        Part filePart = request.getPart("resume");
        String fileName = filePart.getSubmittedFileName();

        // Extract resume text
        String resumeText;
        InputStream fileContent = filePart.getInputStream();
        if (fileName.endsWith(".pdf")) {
            resumeText = extractTextFromPDF(fileContent);
        } else if (fileName.endsWith(".docx")) {
            resumeText = extractTextFromDocx(fileContent);
        } else {
            resumeText = new String(fileContent.readAllBytes());
        }

        // Skill extraction
        List<String> resumeSkills = extractSkills(resumeText);
        List<String> missingSkills = new ArrayList<>();
        for (String skill : jobSkills) {
            if (!resumeSkills.contains(skill.toLowerCase())) {
                missingSkills.add(skill);
            }
        }

        int matched = resumeSkills.size();
        int total = jobSkills.size();
        int atsScore = (int) (((double) matched / total) * 100);

        int tailoringScore = atsScore;
        int grammarScore = 85;
        int contentScore = 70;
        int formattingScore = 60;
        String extractedSkills = String.join(", ", resumeSkills);

        // Placeholder experience (custom logic can be added later)
        String experience = "1-2 years";

        // Save resume file
        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String relativePath = "uploads/" + fileName;
        filePart.write(uploadPath + File.separator + fileName);

        // Store in DB
        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO resumes (name, email, filepath, ati_score, job_id, tailoring_score, grammar_score, content_score, formatting_score, skills, experience) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, relativePath);
            ps.setInt(4, atsScore);
            ps.setInt(5, jobId);
            ps.setInt(6, tailoringScore);
            ps.setInt(7, grammarScore);
            ps.setInt(8, contentScore);
            ps.setInt(9, formattingScore);
            ps.setString(10, extractedSkills);
            ps.setString(11, experience);
            ps.executeUpdate();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Store data in session for result.jsp
        HttpSession session = request.getSession();
        session.setAttribute("atsScore", atsScore);
        session.setAttribute("resumeSkills", resumeSkills);
        session.setAttribute("missingSkills", missingSkills);
        session.setAttribute("jobSkills", jobSkills);
        session.setAttribute("tailoringScore", tailoringScore);
        session.setAttribute("grammarScore", grammarScore);
        session.setAttribute("contentScore", contentScore);
        session.setAttribute("formattingScore", formattingScore);
        session.setAttribute("name", name);
        session.setAttribute("email", email);
        session.setAttribute("job_id", jobId);
        session.setAttribute("filepath", relativePath);
        session.setAttribute("skills", extractedSkills);
        session.setAttribute("experience", experience);

        request.getRequestDispatcher("result.jsp").forward(request, response);

    }
}
