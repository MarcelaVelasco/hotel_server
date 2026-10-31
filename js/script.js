document.addEventListener("DOMContentLoaded", function () {

    // Mensaje de aviso: usa SweetAlert si está disponible, si no alert()
    function avisar(texto, campo) {
        if (window.Swal) {
            Swal.fire({
                icon: "warning",
                title: "Revisa los datos",
                text: texto,
                confirmButtonColor: "#0f2a43",
                confirmButtonText: "Entendido"
            }).then(function () {
                if (campo) { campo.focus(); }
            });
        } else {
            alert(texto);
            if (campo) { campo.focus(); }
        }
    }

    // ---------- Validaciones del formulario de hotel (registrar y editar) ----------
    document.querySelectorAll("#formHotel").forEach(function (formulario) {
        formulario.addEventListener("submit", function (evento) {
            const nombre = formulario.querySelector("#nombre");
            const ciudad = formulario.querySelector("#ciudad");
            const direccion = formulario.querySelector("#direccion");
            const habitaciones = formulario.querySelector("#habitaciones");
            const precio = formulario.querySelector("#precio");

            if (!nombre.value.trim() || !ciudad.value.trim() || !direccion.value.trim()) {
                evento.preventDefault();
                avisar("Completa todos los campos de texto.", nombre);
                return;
            }

            if (habitaciones.value === "" ||
                !Number.isInteger(Number(habitaciones.value)) ||
                Number(habitaciones.value) < 1) {
                evento.preventDefault();
                avisar("El número de habitaciones debe ser un entero mayor que 0.", habitaciones);
                return;
            }

            if (!Number.isFinite(Number(precio.value)) || Number(precio.value) <= 0) {
                evento.preventDefault();
                avisar("El precio debe ser un número mayor que 0.", precio);
                return;
            }
        });
    });

    // ---------- Confirmación antes de eliminar (SweetAlert) ----------
    document.querySelectorAll(".form-eliminar").forEach(function (formulario) {
        formulario.addEventListener("submit", function (evento) {
            evento.preventDefault();
            const nombre = formulario.dataset.nombre || "este hotel";

            if (!window.Swal) {
                if (confirm("¿Eliminar el hotel \"" + nombre + "\"? Esta acción no se puede deshacer.")) {
                    formulario.submit();
                }
                return;
            }

            Swal.fire({
                icon: "warning",
                title: "¿Eliminar hotel?",
                html: "Se eliminará <strong></strong> de forma permanente.<br>Esta acción no se puede deshacer.",
                showCancelButton: true,
                confirmButtonText: "Sí, eliminar",
                cancelButtonText: "Cancelar",
                confirmButtonColor: "#b42318",
                cancelButtonColor: "#64748b",
                reverseButtons: true,
                focusCancel: true,
                didOpen: function (popup) {
                    // textContent evita inyectar HTML desde el nombre del hotel
                    popup.querySelector("strong").textContent = nombre;
                }
            }).then(function (resultado) {
                if (resultado.isConfirmed) {
                    formulario.submit();
                }
            });
        });
    });

    // ---------- Las alertas de éxito se ocultan solas ----------
    document.querySelectorAll(".alerta.exito").forEach(function (alerta) {
        setTimeout(function () {
            alerta.classList.add("oculta");
        }, 4500);
    });
});
