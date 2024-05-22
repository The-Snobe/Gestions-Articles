package projet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/Ajouter")
public class Ajouter extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Informations de connexion à la base de données
        String DB_URL = "jdbc:mysql://localhost:3306/project";
        String DB_USER = "root";
        String DB_PASSWORD = "";

        // Récupérer les valeurs soumises dans le formulaire
        String code = request.getParameter("code");
        String designation = request.getParameter("designation");
        double prix = Double.parseDouble(request.getParameter("prix"));
        int quantite = Integer.parseInt(request.getParameter("quantite"));
        String dateExpiration = request.getParameter("dateExpiration");

        // Établir la connexion à la base de données et insérer le produit
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Vérifier si le code existe déjà dans la base de données
            String checkQuery = "SELECT COUNT(*) FROM produit WHERE code = ?";
            PreparedStatement checkStatement = conn.prepareStatement(checkQuery);
            checkStatement.setString(1, code);
            ResultSet resultSet = checkStatement.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);

            if (count > 0) {
                conn.close();
                // Rediriger vers une page d'erreur indiquant que le code existe déjà
                request.setAttribute("errorMessage", "Le code existe déjà");
                request.getRequestDispatcher("Ajouter.jsp").forward(request, response);
                return; // Arrêter l'exécution de la méthode doPost
            }

            // Le code n'existe pas, procéder à l'insertion du produit
            String query = "INSERT INTO produit (code, designation, prix, quantite, dateExpiration) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, code);
            statement.setString(2, designation);
            statement.setDouble(3, prix);
            statement.setInt(4, quantite);
            statement.setString(5, dateExpiration);
            statement.executeUpdate();

            conn.close();

            // Rediriger vers la page de liste des produits après l'ajout
            request.setAttribute("successMessage", "Enregistrer avec success !");
            request.getRequestDispatcher("Accueil.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Gérer les erreurs de connexion à la base de données
            // Rediriger vers une page d'erreur appropriée
            request.setAttribute("errorMessage", "Erreur de connexion à la base de données");
            request.getRequestDispatcher("Ajouter.jsp").forward(request, response);
        }
    }
}
