// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Personas{
    uint id = 0;
    mapping (uint => Persona) listPersonas;

    struct Persona{
        uint idPersona;
        address payable owner;
        bool esProfesional;
        string nombre;
        string apellido;
        string horarioDisponible; //Se deberia dejar en null para los no postulados.
        string urlImagen;
        string[] servicios; //Se deberia dejar en null para los no postulados.
    }

    event personaRegistrada(uint _id,address payable owner, bool _esProfesional,string _nombre, string _apellido,string _horarioDisponible,string _urlImagen,string[] _servicios);

    function agregarPersona (string memory _nombre, string memory _apellido, string memory _urlImagen) public {
        require(bytes(_nombre).length > 0);
        require(bytes(_apellido).length > 0);
        require(bytes(_urlImagen).length > 0);
        string[] memory _servicios;
        id++;
        listPersonas[id] = Persona(id, payable(msg.sender),false, _nombre,_apellido,"", _urlImagen, _servicios);
        emit personaRegistrada(id, payable(msg.sender), false, _nombre, _apellido, "", _urlImagen, _servicios);
    }

    function agregarPostulante (string memory _nombre, string memory _apellido, string memory _horarioDisponible, string memory _urlImagen, string[] memory _serviciosPostulante) public {
        require(bytes(_nombre).length > 0);
        require(bytes(_apellido).length > 0);
        require(bytes(_horarioDisponible).length > 0);
        require(bytes(_urlImagen).length > 0);
        
        id++;
        listPersonas[id] = Persona(id, payable(msg.sender), true ,_nombre,_apellido,_horarioDisponible, _urlImagen, _serviciosPostulante);
        emit personaRegistrada(id, payable(msg.sender), true ,_nombre, _apellido, _horarioDisponible, _urlImagen, _serviciosPostulante);
    }

    function getPersona (uint _id) public view returns (uint,address, bool,string memory, string memory,string memory,string memory, string[] memory) {
        Persona memory _listPersonas = listPersonas[_id];

        return (_listPersonas.idPersona, _listPersonas.owner, _listPersonas.esProfesional, _listPersonas.nombre, _listPersonas.apellido
        , _listPersonas.horarioDisponible, _listPersonas.urlImagen, _listPersonas.servicios);
    }

}