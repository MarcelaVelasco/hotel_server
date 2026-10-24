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
    <div class="Login-icon"> </div>

        <h1>Hotel SensuYork</h1>
        <p class="subtitulo">Sistema de Gestión de Hoteles</p>

        <!-- Código para validaciones en el formualrio de inicio de sesión -->

        <?php if($error ==='Credenciales incorrectas'): ?>
        <div class = "Alerta error" >
            Usuario o contraseña incorrectos. Por favor, inténtelo de nuevo.
        </div>

        <?php elseif($error === 'sesión'): ?>
        <div class = "Alerta error" >
            Debe iniciar sesión para acceder a esta página.
        </div>

        <?php elseif($error === 'rol'): ?>
        <div class = "Alerta error" >
            No tiene permisos para acceder a esta página.
        </div>
        <?php endif; ?>

        <!-- Código para el fomulario de inicio de sesión -->

        <form action="login.php" method="post">
        
        <label for="usuario">Ingrese el Usuario</label>
        <input type="text" id="usuario" name="Usuario" placeholder="Ingrese usuario" 
        maxlength="50" required>

        <label for="password">Ingrese la contraseña</label>
        <input type="password" id="password" name="password" placeholder="Ingrese la contraseña"
        required autocomplete="current-password">

        <button type="submit" class = "btn-principal">Iniciar Sesión</button>
        </form>
        <p class="pie-login">Proyecto Hotel - Administración Base de Datos</p>
        </div>
        
</body>
</html>