document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.btn-danger, .btn-success').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            if (!confirm('¿Está seguro de realizar esta acción?')) {
                e.preventDefault();
            }
        });
    });
});
function formatearMoneda(valor) {
    return new Intl.NumberFormat('es-PY', { style: 'currency', currency: 'PYG', minimumFractionDigits: 0 }).format(valor);
}