package rad;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/resume_analyzer?allowPublicKeyRetrieval=true&useSSL=false",
            "root",
            "123456"
        );
    }
}