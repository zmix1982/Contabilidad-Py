<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../conexion.php';

class DNIT_API {
    private $db;
    private $user_id;
    
    public function __construct($user_id) {
        $this->db = Database::getInstancia()->getConexion();
        $this->user_id = $user_id;
    }
    
    public function consultarRUC($ruc) {
        $apiKey = API_KEY_CONSULTA_PUBLICA;
        $url = API_URL_CONSULTA_RUC . "?apiKey=" . urlencode($apiKey) . "&ruc=" . urlencode($ruc);
        return $this->llamarAPI($url);
    }
    
    public function validarTimbrado($timbrado, $ruc) {
        $apiKey = API_KEY_CONSULTA_PUBLICA;
        $url = API_URL_VALIDAR_TIMBRADO . "?apiKey=" . urlencode($apiKey) . "&timbrado=" . urlencode($timbrado) . "&ruc=" . urlencode($ruc);
        return $this->llamarAPI($url);
    }
    
    private function llamarAPI($url) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $response = curl_exec($ch);
        $error = curl_error($ch);
        curl_close($ch);
        if ($error) return null;
        return json_decode($response, true);
    }
}
?>