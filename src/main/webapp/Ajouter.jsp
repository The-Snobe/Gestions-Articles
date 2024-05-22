<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un produit</title>
     <style>
       :root {
 body {
  font-family: 'Times New Roman';
  background-color: #a374f0;
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

/* Boutons */
.buttons {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.button {
  padding: 12px 30px;
  background-color: #a374f0;
  color: #fff;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  text-decoration: none;
}


.button:hover {
  background-color: #c7a8f8;
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
<script>
    setTimeout(function() {
      document.querySelector(".success-message").style.display = "none";
    }, 5000);
  </script>
	<div class="container">
    <h1>Ajouter un produit</h1>
    <form method="post" action="Ajouter">
    
    	<div class="form-group">
        <label for="designation">Code :</label>
       	<input type="text" id="designation" name="designation" value="<%= (request.getParameter("code") != null) ? request.getParameter("code") : "" %>" required>
        </div>
        <div class="form-group">
        <label for="designation">Désignation :</label>
       	<input type="text" id="designation" name="designation" value="<%= (request.getParameter("designation") != null) ? request.getParameter("designation") : "" %>" required>
        </div>
        <div class="form-group">
        <label for="prix">Prix :</label>
        <input type="number" id="prix" name="prix" value="<%= (request.getParameter("prix") != null) ? request.getParameter("prix") : "" %>" required>
        </div>
        <div class="form-group">
        <label for="quantite">Quantité :</label>
        <input type="number" id="quantite" name="quantite" value="<%= request.getParameter("quantite") %>" required>
        </div>
        <div class="form-group">
        <label for="dateExpiration">Date d'expiration :</label>
        <input type="date" id="dateExpiration" name="dateExpiration" value="<%= request.getParameter("dateExpiration") %>" required>
        </div>
        <div class="buttons">
        <p>Annulé ? <a href="Accueil.jsp" class="button1">Retour</a></p>
        <input type="submit" value="Ajouter" class= "button">
        </div>
    </form>
    </div>
</body>
</html>