<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Accueil</title>
    <style>
       :root {
  --primary-color: #007bff;
  --background-color: blue;
  --text-color: #333;
  --font-family: "Helvetica Neue", "Arial", sans-serif;
}

/* Styles de base de la page */
body {
 background-image: url('images/bord.jpg');
 background-size: cover;
 background-color: #FF5733;
}

/* Titres */
h1 {
  text-align: center;
  margin-bottom: 30px;
  color: var(--text-color);
}
h2 {
  text-align: left;
  margin-bottom: 30px;
  text-decoration: italic;
  color: var(--text-color);
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

th, td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

th {
  background-color: #f5f5f5;
  color: var(--text-color);
}

tr:nth-child(even) {
  background-color: #bceeff; /* Couleur d'arrière-plan pour les lignes paires */
}

tr:nth-child(odd) {
  background-color: #fff; /* Couleur d'arrière-plan pour les lignes impaires */
}

tr:hover {
  background-color: #e9e9e9;
}

/* Boutons */
.button {
  display: inline-block;
  padding: 10px 20px;
  background-color: var(--primary-color);
  color: #fff;
  text-decoration: none;
  border-radius: 4px;
  transition: background-color 0.3s ease;
  border: none;
  cursor: pointer;
}

.button:hover {
  background-color: #0056b3;
}

.button-edit {
  background-color: #ffc107;
}

.button-delete {
  background-color: #dc3545;
}

/* Messages de succès et d'erreur */
  .success-message {
    background-color: #fff;
    color: #155724;
    border: 1px solid #c3e6cb;
    padding: 10px;
    margin-top: 10px;
    border-radius: 4px;
  }

  .error{
    background-color: #fff;
    color: #721c24;
    border: 1px solid #f5c6cb;
    padding: 10px;
    margin-top: 10px;
    border-radius: 4px;
  }
</style>
</head>
<body>
<%-- Afficher les messages d'erreur --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <%
    String sucessMessage = (String) request.getAttribute("successMessage");
    if (sucessMessage != null) {
%>
    <div class="sucess-message">
        <%= sucessMessage %>
    </div>
<%
    }
%><script>
    setTimeout(function() {
      document.querySelector(".success-message").style.display = "none";
    }, 5000);
  </script>
  	<h2>Bienvenue <%= session.getAttribute("nom") %> !</h2>
    <h1>Liste des produits</h1>
     <a href="Ajouter.jsp" class="button">Ajouter un produit</a>
    <table>
        <thead>
            <tr>
                <th>Code</th>
                <th>Désignation</th>
                <th>Prix</th>
                <th>Quantité</th>
                <th>Date d'expiration</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Récupérer les produits de la base de données et les afficher dans le tableau -->
            <%@ page import="java.sql.*" %>
            <%@ page import="javax.naming.InitialContext" %>
            <%@ page import="javax.sql.DataSource" %>
            <%@ page import="java.text.SimpleDateFormat" %>
            <%@ page import="java.util.Date" %>
            <%
                // Informations de connexion à la base de données
                String DB_URL = "jdbc:mysql://localhost:3306/project";
                String DB_USER = "root";
                String DB_PASSWORD = "";
                
                // Établir la connexion à la base de données
                Connection conn = null;
                PreparedStatement statement = null;
                ResultSet rs = null;
                
                try {
                    // Charger le pilote JDBC
                    Class.forName("com.mysql.jdbc.Driver");
                    
                    // Établir la connexion à la base de données
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                    
                    // Exécuter la requête SQL pour récupérer les produits
                    String query = "SELECT * FROM produit";
                    statement = conn.prepareStatement(query);
                    rs = statement.executeQuery();

                    // Parcourir les résultats et afficher chaque produit dans une ligne du tableau
                    while (rs.next()) {
                         String code = rs.getString("code");
                        String designation = rs.getString("designation");
                        double prix = rs.getDouble("prix");
                        int quantite = rs.getInt("quantite");
                        Date dateExpiration = rs.getDate("dateExpiration");

                        // Formater la date d'expiration
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                        String dateExpirationFormatted = dateFormat.format(dateExpiration);

                        %>
                        <tr>
                            <td><%= code %></td>
                            <td><%= designation %></td>
                            <td><%= prix %></td>
                            <td><%= quantite %></td>
                            <td><%= dateExpirationFormatted %></td>
                            <td>
                                <a href="Modifier.jsp?code=<%= code %>" class="button button-edit">Modifier</a>
                                <a href="Supprimer.jsp?code=<%= code %>" class="button button-delete">Supprimer</a>
                            </td>
                        </tr>
                        <%
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    // Gérer les erreurs de connexion à la base de données
                } finally {
                    // Fermer les ressources
                    if (rs != null) {
                        try {
                            rs.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (statement != null) {
                        try {
                            statement.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (conn != null) {
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </tbody>
    </table>

</body>
</html>