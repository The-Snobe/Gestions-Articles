package projet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Connexion
 */
@WebServlet("/Connexion")
public class Connexion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	// Informations de la base de données
    private static final String DB_URL = "jdbc:mysql://localhost:3306/project";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// Récupérer les valeurs soumises dans le formulaire
        String email = request.getParameter("mail");
        String password = request.getParameter("mpd");

        // Vérifier les informations de connexion dans la base de données
        try {
        	Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("connexion :");
            System.exit(0);
            String query = "SELECT * FROM responsable WHERE email = ? AND password = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, email);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();
            System.out.println("result: "+query);
            System.exit(0);

            //if (resultSet.next()) {
                // Les informations de connexion sont valides

                // Récupérer le nom de l'utilisateur
                String nom = resultSet.getString("nom");

                // Créer une session et stocker les données de l'utilisateur
                HttpSession session = request.getSession();
                session.setAttribute("nom", nom);
                session.setAttribute("email", email);

                // Rediriger vers la page d'accueil ou une autre page protégée
                response.sendRedirect("Acceuil.jsp");
          //  } else {
                // Les informations de connexion sont invalides
                // Ajouter un message d'erreur à la requête
              //  request.setAttribute("errorMessage", "Identifiants incorrects");

                // Rediriger vers la page de connexion avec le message d'erreur
               // request.getRequestDispatcher("Connexion.jsp").forward(request, response);
          //  }

            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Gérer les erreurs de connexion à la base de données
            // Rediriger vers la page de connexion avec un message d'erreur
            request.setAttribute("errorMessage", "Erreur de connexion à la base de données");
            request.getRequestDispatcher("Connexion.jsp").forward(request, response);
        }
    }

}
