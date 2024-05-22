<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
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
  background-color:#2DF91C;
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

  .error-message {
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
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
    <div class="error-message">
        <%= errorMessage %>
    </div>
<%
    }
%>
<%
    String sucessMessage = (String) request.getAttribute("successMessage");
    if (sucessMessage != null) {
%>
    <div class="sucess-message">
        <%= sucessMessage %>
    </div>
<%
    }
%>
	<div class="container">
    <h1>Inscription</h1>
    
    <form  method="POST" action="Inscription" >
    	<div class="form-group">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>
        </div>
		<div class="form-group">
        <label for="prenom">Prénom :</label>
        <input type="text" id="prenom" name="prenom" required>
        </div>
        <div class="form-group">
        <label for="email">Email :</label>
        <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password" required>
        </div>
        <div class="buttons">
        <p>Déjà inscrit ? <a href="Connexion.jsp" class="button1">Se connecter</a></p>
        <input type="submit" value="S'inscrire" class="button">
        </div>
    </form>
    </div>
    
</body>
</html>