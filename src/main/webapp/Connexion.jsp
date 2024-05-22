<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Page de Connexion</title>
    <style>
    body {
  font-family: 'Times New Roman';
  background-color: #FF5733;
}

.container {
  max-width: 350px;
  margin:0 auto;
  padding: 40px;
  margin-top: 90px;
  background-color: #fcfcfdef;
  border-radius: 10px;
}

h1 {
  text-align: center;
  margin-bottom: 30px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 10px;
    font-size: 16px;
    color: #333;
  }
  
  .form-group input {
    width: 90%;
    padding: 10px;
    font-size: 13px;
    border-radius: 3px;
    align-items: center;
    border: 1px solid #a3a2a2;
    transition: border-color 0.3s;
  }

.buttons {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.button {
  padding: 12px 30px;
  background-color: #2DF91C;
  color: #fff;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  text-decoration: none;
}


.button:hover {
  background-color: #FF5733;
}

/* Styles spécifiques à la page d'inscription */
.container.register {
  background-color: #f2f2f2;
  border: 1px solid #742727;
  margin-top: 20%;
}

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

  .error {
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
    <div class="container">
        <h1>Connexion</h1>
        
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
        <form action="Connexion" method="post">
        	<div class="form-group">
            <input type="text" name="mail" placeholder="Email" required>
            </div>
            <div class="form-group">
            <input type="password" name="mpd" placeholder="Mot de passe" required>
            </div>
            <div class="buttons">
            <p>Pas inscrit ? <a href="Inscription.jsp" class="button1">S'inscrire</a></p>
            <input type="submit" value="Se connecter" class="button">
            </div>
            
            
        </form>
    </div>
    
</body>

</html>