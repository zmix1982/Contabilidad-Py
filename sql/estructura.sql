-- ============================================================
-- SISTEMA DE CONTABILIDAD PARA PARAGUAY (DNIT/SET)
-- BASE DE DATOS: contabilidad_py
-- ============================================================

-- Crear la base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS contabilidad_py;
USE contabilidad_py;

-- ============================================================
-- 1. TABLA DE USUARIOS
-- ============================================================
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    ruc VARCHAR(20) NULL,
    rol ENUM('admin', 'contador', 'usuario') DEFAULT 'usuario',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar usuario administrador por defecto
-- Correo: admin@contabilidad.py
-- Contraseña: admin123 (hasheada con password_hash)
INSERT INTO usuarios (email, password, nombre, rol, ruc) VALUES
('admin@contabilidad.py', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrador', 'admin', '800123451');

-- ============================================================
-- 2. TABLA DE MÓDULOS DISPONIBLES
-- ============================================================
CREATE TABLE modulos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT,
    activo_por_defecto BOOLEAN DEFAULT FALSE
);

-- Insertar módulos base
INSERT INTO modulos (nombre, descripcion) VALUES
('IVA', 'Impuesto al Valor Agregado - Tasas 10% y 5%'),
('IRP', 'Impuesto a la Renta Personal - Escalas progresivas'),
('IRE', 'Impuesto a la Renta Empresarial - Régimen general');

-- ============================================================
-- 3. TABLA DE ACTIVACIÓN DE MÓDULOS POR USUARIO
-- ============================================================
CREATE TABLE usuario_modulos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    modulo_id INT NOT NULL,
    activo BOOLEAN DEFAULT FALSE,
    fecha_activacion DATE NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (modulo_id) REFERENCES modulos(id) ON DELETE CASCADE,
    UNIQUE KEY (usuario_id, modulo_id)
);

-- ============================================================
-- 4. TABLA DE TERCEROS (Clientes y Proveedores)
-- ============================================================
CREATE TABLE terceros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    ruc VARCHAR(20) NULL,
    tipo ENUM('cliente', 'proveedor', 'ambos') DEFAULT 'ambos',
    direccion TEXT,
    telefono VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- ============================================================
-- 5. TABLA DE FACTURAS (Manuales, Digitales, Virtuales)
-- ============================================================
CREATE TABLE facturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    
    -- Tipo de factura
    es_virtual BOOLEAN DEFAULT FALSE,   -- Importada desde Marangatu
    es_fisica BOOLEAN DEFAULT FALSE,    -- Subida manual (física escaneada)
    es_digital BOOLEAN DEFAULT FALSE,   -- Subida manual (digital PDF)
    
    -- Datos del comprobante
    ruc_emisor VARCHAR(20),
    ruc_receptor VARCHAR(20),
    numero_factura VARCHAR(50),
    timbrado VARCHAR(50),
    fecha_emision DATE,
    
    -- Montos e impuestos
    monto_total DECIMAL(15,2) NOT NULL,
    monto_iva DECIMAL(15,2) DEFAULT 0,
    tipo_iva ENUM('standard', 'reducido', 'exento') DEFAULT 'standard',
    
    -- Archivo subido (si es manual)
    archivo_path VARCHAR(255) NULL,
    
    -- Datos del QR (si se escaneó)
    qr_data TEXT NULL,
    
    -- Imputación contable
    imputada BOOLEAN DEFAULT FALSE,
    id_cliente INT NULL,
    id_proveedor INT NULL,
    observaciones TEXT,
    
    -- Auditoría
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES terceros(id) ON DELETE SET NULL,
    FOREIGN KEY (id_proveedor) REFERENCES terceros(id) ON DELETE SET NULL
);

-- ============================================================
-- 6. TABLA DE OPERACIONES CONTABLES
-- (Para IVA, IRP, IRE)
-- ============================================================
CREATE TABLE operaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    factura_id INT NULL,
    
    tipo_operacion ENUM('compra', 'venta', 'gasto', 'ingreso') NOT NULL,
    monto_base DECIMAL(15,2) NOT NULL,
    monto_impuesto DECIMAL(15,2) DEFAULT 0,
    tasa_impuesto DECIMAL(5,2) DEFAULT 0,
    
    modulo_origen VARCHAR(10) NOT NULL,  -- 'IVA', 'IRP', 'IRE'
    fecha DATE NOT NULL,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (factura_id) REFERENCES facturas(id) ON DELETE SET NULL
);

-- ============================================================
-- 7. TABLA DE PERÍODOS FISCALES (Cierre Mensual)
-- ============================================================
CREATE TABLE periodos_fiscales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    mes INT NOT NULL,
    año INT NOT NULL,
    estado ENUM('abierto', 'cerrado', 'en_proceso') DEFAULT 'abierto',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    UNIQUE KEY (usuario_id, mes, año)
);

-- ============================================================
-- 8. (OPCIONAL) TABLA DE LOGS O BITÁCORA
-- Para auditoría de acciones
-- ============================================================
CREATE TABLE IF NOT EXISTS logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NULL,
    accion VARCHAR(100),
    tabla VARCHAR(50),
    registro_id INT,
    ip VARCHAR(45),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
-- NOTA: La contraseña del usuario admin es "admin123"
-- Puedes cambiarla desde el sistema o ejecutando:
-- UPDATE usuarios SET password = password_hash('nueva_clave', PASSWORD_DEFAULT) WHERE email = 'admin@contabilidad.py';
-- ============================================================