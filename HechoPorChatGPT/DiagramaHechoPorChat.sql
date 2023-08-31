-- Crear la tabla Usuario
CREATE TABLE Usuario (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    Tipo ENUM('Paciente', 'Médico', 'Administrador'),
    Email VARCHAR(255) NOT NULL,
    Contraseña VARCHAR(255) NOT NULL
);

-- Crear la tabla Paciente
CREATE TABLE Paciente (
    PacienteID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT UNIQUE,
    Cédula VARCHAR(20),
    NombreCompleto VARCHAR(255),
    Teléfono VARCHAR(20),
    CiudadResidencia VARCHAR(255),
    FechaNacimiento DATE,
    Alergias TEXT,
    EPS VARCHAR(255),
    TipoSangre VARCHAR(10),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
);

-- Crear la tabla Médico
CREATE TABLE Médico (
    MédicoID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT UNIQUE,
    Especialidad VARCHAR(255),
    HorarioInicio TIME,
    HorarioFin TIME,
    DíasLibres TEXT,
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID)
);

-- Crear la tabla Cita
CREATE TABLE Cita (
    CitaID INT AUTO_INCREMENT PRIMARY KEY,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FechaHoraCita DATETIME,
    Estado ENUM('Programada', 'Completada', 'Cancelada'),
    MotivoConsulta TEXT,
    MédicoID INT,
    PacienteID INT,
    FOREIGN KEY (MédicoID) REFERENCES Médico(MédicoID),
    FOREIGN KEY (PacienteID) REFERENCES Paciente(PacienteID)
);

-- Crear la tabla PQRS
CREATE TABLE PQRS (
    PQRSID INT AUTO_INCREMENT PRIMARY KEY,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DetallePQRS TEXT,
    Estado ENUM('Nuevo', 'En Proceso', 'Resuelto', 'Archivado'),
    TipoAtención VARCHAR(255), -- Aquí especifica si se relaciona con Cita u otra atención
    PacienteID INT,
    AdministradorID INT, -- Opcional si un administrador responde
    FOREIGN KEY (PacienteID) REFERENCES Paciente(PacienteID),
    FOREIGN KEY (AdministradorID) REFERENCES Usuario(UsuarioID)
);

-- Crear la tabla HistorialMédico
CREATE TABLE HistorialMédico (
    HistorialID INT AUTO_INCREMENT PRIMARY KEY,
    FechaAtención DATE,
    NotasMédico TEXT,
    Diagnóstico TEXT,
    Tratamiento TEXT,
    MédicoID INT,
    PacienteID INT,
    FOREIGN KEY (MédicoID) REFERENCES Médico(MédicoID),
    FOREIGN KEY (PacienteID) REFERENCES Paciente(PacienteID)
);
