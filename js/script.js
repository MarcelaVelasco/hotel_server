document.addEventListener("DOMContentLoaded", function(){
});


//Validaciones adicionales de formularios

const formulariosHotel = document.querySelectorAll("#formHotel");

formulariosHotel.forEach(function(formulario){
    formulario.addEventListener("submit", function(evento){
        const nombre = formulario.querySelector("#nombre");
        const ciudad = formulario.querySelector("#ciudad");
        const direccion = formulario.querySelector("#direccion");
        const habitaciones = formulario.querySelector("#habitaciones");
        const precio = formulario.querySelector("#precio");

        if(!nombre.value.trim() || !ciudad.value.trim() || !direccion.value.trim())
        {
            evento.preventDefault();
            alert("Completa todos los campos de texto");
            return;
        }

        //if(
            //Number(habitaciones.value) <1 ||
            //!Number.IsInteger(Number(habitaciones.value))

        //)
        //{
        //}

    if(Number(habitaciones.value) <1 || !Number.isInteger(Number(habitaciones.value))
    ){
        evento.preventDefault();
        alert("Ingrese un número valido");
        habitaciones.focus();
        return;
}

    if(!Number.isFinite(Number(precio.value)) || Number(precio.value) <= 0)
    {
        evento.preventDefault();
        alert("El precio debe ser mayor que 0 o un número valido");
        precio.focus();
        return;
    }        
    })
})