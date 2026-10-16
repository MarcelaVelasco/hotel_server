<?php
        $server ="DESKTOP-QEPGA86";
        $baseDatos = "hotelesABD1";
        $usuarioSQL ="sa";
        $claveSQL = "12345";

        try {
            $conexion = new PDO (
                "sqlsrv:Server= $server;DataBase=$baseDatos; TrustServerCertificate=1", 
                $usuarioSQL,$claveSQL
            );
            $conexion->setAttribute
            (PDO::ATTR_ERRMODE, 
            PDO::ERRMODE_EXCEPTION
            );
        } catch (PDOException $e) {
            die("Error de conexión: " . $e->getMessage());
        }
?>