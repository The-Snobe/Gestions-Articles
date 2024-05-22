<%@ page import="java.sql.*" %>

<%
    // Informations de connexion à la base de données
    String DB_URL = "jdbc:mysql://localhost:3306/project";
    String DB_USER = "root";
    String DB_PASSWORD = "";

    // Récupérer le code du produit à supprimer depuis les paramètres de la requête
    String codeProduit = request.getParameter("code");

    // Établir la connexion à la base de données
    Connection conn = null;
    PreparedStatement statement = null;

    try {
        // Charger le pilote JDBC
        Class.forName("com.mysql.jdbc.Driver");

        // Établir la connexion à la base de données
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Exécuter la requête SQL pour supprimer le produit
        String query = "DELETE FROM produit WHERE code = ?";
        statement = conn.prepareStatement(query);
        statement.setString(1, codeProduit);
        int rowsAffected = statement.executeUpdate();

        if (rowsAffected > 0) {
            // La suppression a réussi
            out.println("<script>alert('Suppression réussie');</script>");
            response.sendRedirect("Accueil.jsp");
        } else {
            // La suppression a échoué
            out.println("<script>alert('Échec de la suppression');</script>");
            response.sendRedirect("Accueil.jsp");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Gérer les erreurs de connexion à la base de données
        out.println("<script>alert('Échec de la suppression');</script>");
    } 
%>