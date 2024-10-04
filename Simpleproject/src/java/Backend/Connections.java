package Backend;
import java.sql.*;



/**
 *
 * @author JdFils-Salim
 */
public class Connections {
    public Connection getConnection() throws SQLException {
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/simpleproject";
        String username = "root";
        String password = "";

        try {
            // Register MySQL JDBC Driver (optional for JDBC 4.0+)
            Class.forName("com.mysql.cj.jdbc.Driver");  // For MySQL Connector/J 8.x.x
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found."+e);
          
            return null;
        }

        // Establishing connection
        conn = DriverManager.getConnection(url, username, password);
        if(conn!=null){
            System.out.println("connected to db simple project");
        }else{
                        System.out.println("Failed  to connect to simple project db. try again or error 500 :)");

        }
        return conn;
    }
    
    public static void main(String[] args) {
        try {
            Connections conn=new Connections();
            conn.getConnection();
        } catch (SQLException ex) {
            System.out.println("error:"+ex);        }
        
    }
}