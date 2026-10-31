/* ============================================================
   Actividad I - Periodo III - Administración de Base de Datos
   Script complementario para la base de datos hotelesABD1.
   Ejecutar DESPUÉS del script original (PracticaHotel_...sql).
   Es seguro ejecutarlo varias veces (CREATE OR ALTER).

   Qué corrige:
   - Los procedimientos usaban varchar(60) y truncaban Nombre/Ciudad/
     Direccion (la tabla permite 100/100/150). Se amplían a esos tamaños.
   - actualizarHotel / eliminarHotel quedan con SET NOCOUNT ON.
   - validarinsertHotel usaba ALTER sin existir: ahora CREATE OR ALTER
     y además rechaza habitaciones <= 0, precio <= 0 y estados inválidos.
   - Nuevo trigger validarupdateHotel para las ediciones.
   ============================================================ */

USE hotelesABD1;
GO

CREATE OR ALTER PROCEDURE agregarHotel
    @Nombre       VARCHAR(100),
    @Ciudad       VARCHAR(100),
    @Direccion    VARCHAR(150),
    @Habitaciones INT,
    @PrecioNoche  DECIMAL(10,2),
    @Estado       VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Hotel (Nombre, Ciudad, Direccion, Habitaciones, PrecioNoche, Estado)
    VALUES (@Nombre, @Ciudad, @Direccion, @Habitaciones, @PrecioNoche, @Estado);
END;
GO

CREATE OR ALTER PROCEDURE consultarHotel
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Hotel ORDER BY IdHotel;
END;
GO

CREATE OR ALTER PROCEDURE actualizarHotel
    @idHotel      INT,
    @Nombre       VARCHAR(100),
    @Ciudad       VARCHAR(100),
    @Direccion    VARCHAR(150),
    @Habitaciones INT,
    @PrecioNoche  DECIMAL(10,2),
    @Estado       VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Hotel
    SET Nombre       = @Nombre,
        Ciudad       = @Ciudad,
        Direccion    = @Direccion,
        Habitaciones = @Habitaciones,
        PrecioNoche  = @PrecioNoche,
        Estado       = @Estado
    WHERE IdHotel = @idHotel;
END;
GO

CREATE OR ALTER PROCEDURE eliminarHotel
    @IdHotel INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM Hotel WHERE IdHotel = @IdHotel;
END;
GO

CREATE OR ALTER PROCEDURE recibirlogin
    @Usuario VARCHAR(50),
    @Clave   VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM Usuario WHERE Usuario = @Usuario AND Clave = @Clave;
END;
GO

/* ---------- Triggers ---------- */

-- Al insertar: no permite campos vacíos ni valores inválidos
CREATE OR ALTER TRIGGER validarinsertHotel
ON Hotel
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Nombre IS NULL OR LTRIM(RTRIM(Nombre)) = ''
           OR Ciudad IS NULL OR LTRIM(RTRIM(Ciudad)) = ''
           OR Direccion IS NULL OR LTRIM(RTRIM(Direccion)) = ''
           OR Habitaciones IS NULL
           OR PrecioNoche IS NULL
           OR Estado IS NULL OR LTRIM(RTRIM(Estado)) = ''
    )
    BEGIN
        RAISERROR('No se aceptan campos vacios', 16, 1);
        RETURN;
    END;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Habitaciones <= 0
           OR PrecioNoche <= 0
           OR Estado NOT IN ('Activo', 'Inactivo')
    )
    BEGIN
        RAISERROR('Habitaciones y precio deben ser mayores que 0 y el estado Activo o Inactivo', 16, 1);
        RETURN;
    END;

    INSERT INTO Hotel (Nombre, Ciudad, Direccion, Habitaciones, PrecioNoche, Estado)
    SELECT Nombre, Ciudad, Direccion, Habitaciones, PrecioNoche, Estado
    FROM inserted;
END;
GO

-- Al actualizar: mismas reglas; si fallan se revierte el cambio
CREATE OR ALTER TRIGGER validarupdateHotel
ON Hotel
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE Nombre IS NULL OR LTRIM(RTRIM(Nombre)) = ''
           OR Ciudad IS NULL OR LTRIM(RTRIM(Ciudad)) = ''
           OR Direccion IS NULL OR LTRIM(RTRIM(Direccion)) = ''
           OR Habitaciones IS NULL OR Habitaciones <= 0
           OR PrecioNoche IS NULL OR PrecioNoche <= 0
           OR Estado IS NULL OR Estado NOT IN ('Activo', 'Inactivo')
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('No se aceptan campos vacios, habitaciones o precio menores o iguales a 0, ni estados distintos de Activo/Inactivo', 16, 1);
        RETURN;
    END;
END;
GO

/* ---------- Pruebas rápidas (opcional) ----------
EXEC consultarHotel;
EXEC actualizarHotel 1, 'Hotel El Sol', 'San Salvador', 'Centro', 35, 48.50, 'Activo';
EXEC actualizarHotel 1, 'Hotel El Sol', 'San Salvador', 'Centro', -5, 48.50, 'Activo';  -- debe fallar (trigger)
EXEC eliminarHotel 3;
-------------------------------------------------- */
