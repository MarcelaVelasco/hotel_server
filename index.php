<?php
    session_start();

    if(isset($_SESSION["Usuario"])){
        header("Location: panel.php");
        exit;
    }

    $error = $_GET["error"];
?>

<DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOTEL</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>    
<body class ="login-body">
    <div class="login-container">
        <h1>Iniciar Sesión</h1>
        <?php if(isset($error) && $error == 1): ?>
            <p class="error-message">Usuario o contraseña incorrectos</p>
        <?php endif; ?>
        <form action="validar.php" method="POST">
            <input type="text" name="usuario" placeholder="Usuario" required>
            <input type="password" name="clave" placeholder="Contraseña" required>
            <button type="submit">Iniciar Sesión</button>
        </form>
</body>
</html>