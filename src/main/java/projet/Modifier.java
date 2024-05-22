package projet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/Modifier")
public class Modifier extends HttpServlet {
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

        // Établir la connexion à la base de données et mettre à jour le produit
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Exécuter la requête SQL pour mettre à jour le produit
            String query = "UPDATE produit SET designation=?, prix=?, quantite=?, dateExpiration=? WHERE code=?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, designation);
            statement.setDouble(2, prix);
            statement.setInt(3, quantite);
            statement.setString(4, dateExpiration);
            statement.setString(5, code);
            statement.executeUpdate();

            conn.close();

            // Rediriger vers la page de liste des produits après la modification
            String successMessage ="Modifier avec success!";
            request.setAttribute("successMessage",successMessage);
            request.getRequestDispatcher("Accueil.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Gérer les erreurs de connexion à la base de données
            // Rediriger vers une page d'erreur appropriée
            request.setAttribute("errorMessage", "Erreur de connexion à la base de données");
            request.getRequestDispatcher("Modifier.jsp").forward(request, response);
        }
    }
}
