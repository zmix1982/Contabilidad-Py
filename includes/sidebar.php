<div class="sidebar">
    <div class="sidebar-brand">
        <i class="bi bi-calculator-fill"></i> ContabilidadPY
    </div>
    <hr class="sidebar-divider">
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'dashboard.php' ? 'active' : ''; ?>" href="dashboard.php">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'facturas.php' ? 'active' : ''; ?>" href="facturas.php">
                <i class="bi bi-receipt"></i> Facturas
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'modulos.php' ? 'active' : ''; ?>" href="modulos.php">
                <i class="bi bi-puzzle"></i> Módulos
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link <?php echo basename($_SERVER['PHP_SELF']) == 'exportar.php' ? 'active' : ''; ?>" href="exportar.php">
                <i class="bi bi-file-earmark-arrow-up"></i> Exportar
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="cerrar_sesion.php">
                <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
            </a>
        </li>
    </ul>
</div>
<style>
.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    width: 250px;
    background: #2c3e50;
    color: white;
    padding: 20px 0;
    overflow-y: auto;
    z-index: 1000;
}
.sidebar-brand {
    font-size: 1.5rem;
    padding: 0 20px 15px;
    font-weight: 700;
}
.sidebar-divider {
    border-color: rgba(255,255,255,0.1);
}
.sidebar .nav-link {
    color: #ccc;
    padding: 12px 20px;
    transition: 0.3s;
}
.sidebar .nav-link i {
    margin-right: 10px;
    width: 20px;
    text-align: center;
}
.sidebar .nav-link:hover,
.sidebar .nav-link.active {
    background: #34495e;
    color: white;
}
.main-content {
    margin-left: 250px;
    padding: 20px;
}
@media (max-width: 768px) {
    .sidebar {
        width: 100%;
        position: relative;
        height: auto;
    }
    .main-content {
        margin-left: 0;
    }
}
</style>