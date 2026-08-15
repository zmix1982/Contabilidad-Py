<?php
require_once 'config.php';

class Database {
    private static $instancia = null;
    private $conn;
    private $host = 'localhost';
    private $user = 'root';
    private $pass = '';
    private $dbname = 'contabilidad_py';
    
    private function __construct() {
        $this->conn = new mysqli($this->host, $this->user, $this->pass, $this->dbname);
        if ($this->conn->connect_error) {
            die("Error de conexión: " . $this->conn->connect_error);
        }
        $this->conn->set_charset("utf8");
    }
    
    public static function getInstancia() {
        if (self::$instancia === null) {
            self::$instancia = new Database();
        }
        return self::$instancia;
    }
    
    public function getConexion() { return $this->conn; }
    public function preparar($sql) { return $this->conn->prepare($sql); }
    public function escapar($valor) { return $this->conn->real_escape_string($valor); }
    public function ultimoId() { return $this->conn->insert_id; }
}
?>