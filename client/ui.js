
document.addEventListener("DOMContentLoaded", () => {
    App.init()
})

const formPersonas = document.querySelector("#renderTask")
formPersonas.addEventListener("submit", q =>{
    q.preventDefault();
    console.log(
        formPersonas["name"].value,
        formPersonas["lastName"].value,
        formPersonas["horarioDisponible"].value,
        formPersonas["urlImagen"].value,
        formPersonas["serviciosPostulante"].value
        
    );

    App.createPostulante(formPersonas["name"].value, formPersonas["lastName"].value, formPersonas["horarioDisponible"].value,formPersonas["urlImagen"].value, formPersonas["serviciosPostulante"].value)
})

const formAcuerdo = document.querySelector("#renderAcuerdo")
formAcuerdo.addEventListener("submit", d =>{
    d.preventDefault();
    console.log(
        formAcuerdo["dirContratado"].value,
        formAcuerdo["dirAvisitar"].value,
        formAcuerdo["horarioDeVisita"].value,
        formAcuerdo["servicioArealizar"].value,
        formAcuerdo["descripcion"].value,
        formAcuerdo["monto"].value
    );

    App.generarAcuerdo(formAcuerdo["dirContratado"].value,formAcuerdo["dirAvisitar"].value,formAcuerdo["horarioDeVisita"].value,formAcuerdo["servicioArealizar"].value,formAcuerdo["descripcion"].value,formAcuerdo["monto"].value);

})

