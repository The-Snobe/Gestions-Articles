<%@ page import="java.sql.*" %>

<%
    // Informations de connexion � la base de donn�es
    String DB_URL = "jdbc:mysql://localhost:3306/project";
    String DB_USER = "root";
    String DB_PASSWORD = "";

    // R�cup�rer le code du produit � supprimer depuis les param�tres de la requ�te
    String codeProduit = request.getParameter("code");

    // �tablir la connexion � la base de donn�es
    Connection conn = null;
    PreparedStatement statement = null;

    try {
        // Charger le pilote JDBC
        Class.forName("com.mysql.jdbc.Driver");

        // �tablir la connexion � la base de donn�es
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Ex�cuter la requ�te SQL pour supprimer le produit
        String query = "DELETE FROM produit WHERE code = ?";
        statement = conn.prepareStatement(query);
        statement.setString(1, codeProduit);
        int rowsAffected = statement.executeUpdate();

        if (rowsAffected > 0) {
            // La suppression a r�ussi
            out.println("<script>alert('Suppression r�ussie');</script>");
            response.sendRedirect("Accueil.jsp");
        } else {
            // La suppression a �chou�
            out.println("<script>alert('�chec de la suppression');</script>");
            response.sendRedirect("Accueil.jsp");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // G�rer les erreurs de connexion � la base de donn�es
        out.println("<script>alert('�chec de la suppression');</script>");
    } 
%>