package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DBUtil {
	private static String DRIVER = "com.mysql.jdbc.Driver";
	private static String URL = "jdbc:mysql://127.0.0.1:3306/liantong";
	private static String USERNAME = "root";
	private static String PASSWORD = "root";
	static{
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws SQLException{
			return DriverManager.getConnection(URL,USERNAME,PASSWORD);
	}
	public static void close(ResultSet rs,PreparedStatement pstm,Connection conn){
		try {
			if(rs != null && !rs.isClosed()){
				rs.close();
			}
			if(pstm != null && !pstm.isClosed()){
				pstm.close();
			}
			if(conn != null && !conn.isClosed()){
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
}