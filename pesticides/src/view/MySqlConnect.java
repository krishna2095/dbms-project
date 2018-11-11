package view;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.*;
import javax.swing.*;



public class MySqlConnect {
    Connection conn=null;
    public static Connection ConnectDB(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://localhost/MiniProject","root","Viragandham@2095");
           // JOptionPane.showMessageDialog(null,"Connected to database");
           
            return conn;
            
        }catch(Exception e){
            JOptionPane.showConfirmDialog(null,e);
            return null;
        }
        
    }
    
}
