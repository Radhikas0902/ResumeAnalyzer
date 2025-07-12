package rad;

import java.io.*;
import org.apache.poi.xwpf.usermodel.*;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

public class ResumeParser {

    public static String extractText(String filePath) {
        if (filePath == null || filePath.isEmpty()) return "";

        String lowerPath = filePath.toLowerCase();

        if (lowerPath.endsWith(".pdf")) {
            return extractTextFromPDF(filePath);
        } else if (lowerPath.endsWith(".docx")) {
            return extractTextFromDocx(filePath);
        } else {
            System.err.println("Unsupported file format: " + filePath);
            return "";
        }
    }

    public static String extractTextFromDocx(String filePath) {
        StringBuilder text = new StringBuilder();
        try (FileInputStream fis = new FileInputStream(new File(filePath));
             XWPFDocument doc = new XWPFDocument(fis)) {

            for (XWPFParagraph p : doc.getParagraphs()) {
                if (p != null && p.getText() != null) {
                    text.append(p.getText()).append("\n");
                }
            }

        } catch (Exception e) {
            System.err.println("Error reading .docx file: " + e.getMessage());
            e.printStackTrace();
        }
        return text.toString();
    }

    public static String extractTextFromPDF(String filePath) {
        StringBuilder text = new StringBuilder();
        try (PDDocument doc = PDDocument.load(new File(filePath))) {
            PDFTextStripper stripper = new PDFTextStripper();
            text.append(stripper.getText(doc));
        } catch (IOException e) {
            System.err.println("Error reading PDF file: " + e.getMessage());
            e.printStackTrace();
        }
        return text.toString();
    }
}