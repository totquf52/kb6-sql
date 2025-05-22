package org.scoula.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCUtil {
    static Connection conn = null;
    // 정적 초기화 블록을 사용하여 JDBC 드라이버를 로드하고 데이터베이스 연결을 설정
    static {
        try{
            // Properties 객체를 생성하고 application.properties 파일을 로드
            Properties properties = new Properties();
            properties.load(JDBCUtil.class.getResourceAsStream("/application.properties"));

            // 프로퍼티 파일에서 드라이버, URL, 사용자 ID, 비밀번호를 가져옴
            String driver = properties.getProperty("driver");
            String url = properties.getProperty("url");
            String id = properties.getProperty("id");
            String password = properties.getProperty("password");

            // MySQL JDBC 드라이버를 로드
            Class.forName(driver);
            conn = DriverManager.getConnection(url, id, password);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    // 데이터베이스 연결 객체를 반환하는 메서드
    public static Connection getConnection(){
        return conn;
    }

    // 데이터베이스 연결을 닫는 메서드
    public static void close(){
        try{
            if(conn != null){
                conn.close();
                conn = null;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}
