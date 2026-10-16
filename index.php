<?php
    session_start();

    if(isset($_SESSION['Usuario'])){
        header("Location: panel.php");
        exit;
    }

    $error = $_GET["error"] ?? '';
?>

<DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HOTEL</title>
    <link rel="stylesheet" href="css/estilo.css">
</head>    
<body class ="login-body">
    <div class="login-container">
    <div class="Login-icon"></div>
        <h1>Hotel Sensuyork</h1>
        <p class="subtitulo">Sistema de Gestión de Hoteles</p>
        
</body>
</html>