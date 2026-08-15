<?php
define('BASE_URL', 'http://localhost/Contabilidad-Py/');
define('UPLOAD_DIR', __DIR__ . '/uploads/');
define('EXPORT_DIR', __DIR__ . '/exports/');
define('MAX_FILE_SIZE', 10 * 1024 * 1024);
define('ALLOWED_EXTENSIONS', ['pdf', 'jpg', 'jpeg', 'png']);

define('IVA_TASA_STANDARD', 10);
define('IVA_TASA_REDUCIDO', 5);

define('API_KEY_CONSULTA_PUBLICA', 'TU_API_KEY_AQUI');
define('API_URL_CONSULTA_RUC', 'https://servicios.set.gov.py/EstApiWS/ApiWS/ConsultaRUC');
define('API_URL_VALIDAR_TIMBRADO', 'https://servicios.set.gov.py/EstApiWS/ApiWS/ValidezTimbrado');
define('EXPORT_FILENAME_PREFIX', 'REG_');

if (session_status() === PHP_SESSION_NONE) session_start();