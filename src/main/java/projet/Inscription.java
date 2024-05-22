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

@WebServlet("/Inscription")
public class Inscription extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les valeurs soumises dans le formulaire
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Nom: " + nom);
        System.out.println("Prénom: " + prenom);
        System.out.println("Email: " + email);

        // Vérifier la force du mot de passe (par exemple, une longueur minimale ou une complexité requise)
        boolean isPasswordStrong = checkPasswordStrength(password);
        if (!isPasswordStrong) {
            String errorMessage = "Mot de passe insuffisamment fort. Veuillez entrer un mot de passe de 8 caractères minimum, contenant au moins une lettre majuscule, une lettre minuscule, un chiffre et un caractère spécial.";
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("Inscription.jsp").forward(request, response);
            return;
        }

        // Enregistrer les données dans une base de données XAMPP
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "");

            // Vérifier si l'email existe déjà dans la base de données
            String checkQuery = "SELECT COUNT(*) FROM responsable WHERE email = ?";
            PreparedStatement checkStatement = conn.prepareStatement(checkQuery);
            checkStatement.setString(1, email);
            ResultSet resultSet = checkStatement.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);

            if (count > 0) {
                conn.close();
                // Rediriger vers une page d'erreur indiquant que l'email existe déjà
                request.setAttribute("errorMessage", "L'email existe déjà");
                request.getRequestDispatcher("Inscription.jsp").forward(request, response);
                return; // Arrêter l'exécution de la méthode doPost
            }

            // L'email n'existe pas, procéder à l'insertion de la personne
            String query = "INSERT INTO responsable (nom, prenom, email, password) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, nom);
            statement.setString(2, prenom);
            statement.setString(3, email);
            statement.setString(4, password);
            int rowsAffected = statement.executeUpdate();
            System.out.println("Nombre de lignes affectées: " + rowsAffected);

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Inscription.jsp"); // Rediriger vers la page d'inscription en cas d'erreur lors de l'enregistrement dans la base de données
            return;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("Inscription.jsp"); // Rediriger vers la page d'inscription en cas d'erreur lors de l'enregistrement dans la base de données
            return;
        }

        // Créer une session et stocker les données de l'utilisateur
        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        String sucessMessage=("L'enregistrement a été effectué avec succès.!");
        session.setAttribute("successMessage", sucessMessage);
        System.out.println("Redirection vers la page de connexion.");
        response.sendRedirect("Connexion.jsp");
    }

    private boolean checkPasswordStrength(String password) {
        // Vérifier la longueur minimale du mot de passe
        if (password.length() < 8) {
            return false;
        }

        // Vérifier si le mot de passe contient au moins une lettre majuscule et une lettre minuscule
        boolean hasUppercase = false;
        boolean hasLowercase = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) {
                hasUppercase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowercase = true;
            }
        }
        if (!hasUppercase || !hasLowercase) {
            return false;
        }

        // Vérifier si le mot de passe contient au moins un chiffre
        boolean hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isDigit(c)) {
                hasDigit = true;
                break;
            }
        }
        if (!hasDigit) {
            return false;
        }

        // Vérifier si le mot de passe contient au moins un caractère spécial
        boolean hasSpecialChar = false;
        for (char c : password.toCharArray()) {
            if (!Character.isLetterOrDigit(c)) {
                hasSpecialChar = true;
                break;
            }
        }
        if (!hasSpecialChar) {
            return false;
        }

        // Si toutes les vérifications sont réussies, le mot depasse est considéré comme suffisamment fort.
        return true;
    }
}