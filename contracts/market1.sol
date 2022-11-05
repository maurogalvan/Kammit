// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract marketplace {

enum Status {
    open, cancelled, executed
}

struct personaContratada{
    address suDirecionDeBilletera;
    string nombre;
    string apellido;
    string imagen;
    string[] trabajosQuePuedeHacer;
}

struct datosAcordados{
    string direccionDeVisita;
    uint montoAcordado;
    string horaAcordada;
}

struct transaccion{
    address contratante;
    address contratado;
    Status status;
    uint montoAcordado;
}

function abrirPosicion (address direccionBilletera) public {

}




}