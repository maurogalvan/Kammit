// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//import './AcuerdoPersonaContrata';
//import './AcuerdoPersonaContratada';
/*
function tranfer (address, uint256) external returns (bool);
    function approve (address, uint256) external returns (bool);
    function transferFrom (address, address, uint256) external returns (bool); //el que manda y el que recibe y cantidad que queremos mandar
    function totalSupply () external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance (address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event approval(address indexed owner, address indexed spender, uint256 value);
*/

// https://github.com/search?p=4&q=market+solidity&type=Repositories
// https://github.com/yann1ckv/Marketplace_dapp/blob/master/contracts/Marketplace.sol
// https://github.com/AlbertoLasa/marketplace-NFTs-ERC721/blob/main/marketPlace.sol
// https://github.com/Sudhanmanoharan/MarketPlace-BlockChain/blob/master/contracts/MarketPlace.sol#L33
// https://github.com/timbeiko/solidity-marketplace/blob/master/contracts/Stores.sol
// https://github.com/timbeiko/solidity-marketplace/blob/master/contracts/Marketplace.sol
// https://gist.github.com/dabit3/52e818faa83449bb5303cb868aee78f5
// https://github.com/zalak13/MarketPlace-DApp/blob/master/contracts/Owned.sol

contract MarketPlaces {
    uint public cantPersonasInscriptas = 0;
    uint public cantAcuerdos = 0;
    //AcuerdoPersonaContratada public acuerdoPersonaContratada;
    //AcuerdoPersonaContrata public acuerdoPersonaContrata;

    mapping (uint => PersonaPostulada) public listPersonas;
    mapping (uint => Acuerdo) public listAcuerdo;

    struct PersonaPostulada{
        uint idPersona;
        address payable owner;
        string nombre;
        string apellido;
        string horarioDisponible;
        string urlImagen;
        string[] servicios;
    }

    struct Acuerdo{
        uint idDelAcuerdo;
        address personaQueContrata;
        address payable personaContratada;
        
        string direccion;
        uint montoAcordado;
        string horarioDeVisita;
        string otrasDescripciones;

        bool checkPersonaQueContrata;
        bool checkPersonaAcontratar;
    }

    event personaRegistrada(uint id, address payable owner, string nombre, string apellido, string horarioDispoble, string urlImagen, string[] servicios);
    event seGeneroUnAcuerdo(uint cantAcuerdos, address _personaQueContrata,address payable _personaContratada,string _direccion,uint _montoAcordado,string _horarioDeVisita,
                        string _otrasDescripciones,bool checkPersonaAcontratar, bool checkPersonaQueContrata);
    event checkModificadoPorPersonaAcontratar (uint id, bool checkPersonaAcontratar);
    event checkModificadoPorPersonaQueContrata (uint id, bool checkPersonaQueContrata);

    
    function getPersonas(uint _id) public returns (address, string memory, string memory, string memory,string memory, string memory){
    }

    function postularse (string memory _nombre, string memory _apellido, string memory _horarioDisponible, string memory _urlImagen, string[] memory _servicios) public {
        require(bytes(_nombre).length > 0);
        require(bytes(_apellido).length > 0);
        require(bytes(_horarioDisponible).length > 0);
        require(bytes(_urlImagen).length > 0);
        
        cantPersonasInscriptas++;
        listPersonas[cantPersonasInscriptas] = PersonaPostulada(cantPersonasInscriptas, payable(msg.sender), _nombre,_apellido,_horarioDisponible, _urlImagen, _servicios);
        emit personaRegistrada(cantPersonasInscriptas, payable(msg.sender), _nombre, _apellido, _horarioDisponible, _urlImagen, _servicios);

    }
    //Para generar un acuerdo
    function generarUnAcuerdo (address _personaQueContrata,address payable _personaContratada, string memory _direccion, uint _montoAcordado, 
                                string memory _horarioDeVisita, string memory _otrasDescripciones) public {
        cantAcuerdos++;
        listAcuerdo[cantAcuerdos] = Acuerdo(cantAcuerdos, _personaQueContrata, _personaContratada, _direccion, _montoAcordado, _horarioDeVisita, _otrasDescripciones, false, false);
        emit seGeneroUnAcuerdo(cantAcuerdos, _personaQueContrata, _personaContratada, _direccion, _montoAcordado, _horarioDeVisita, _otrasDescripciones, false, false);
    }

    //Controladores del check
    function checkcheckPersonaQueContrata (uint id) public {
        Acuerdo memory _acuerdo = listAcuerdo[id];
        _acuerdo.checkPersonaQueContrata = !_acuerdo.checkPersonaQueContrata;
        listAcuerdo[id] = _acuerdo;
        emit checkModificadoPorPersonaQueContrata(id, _acuerdo.checkPersonaQueContrata);
    }
    function checkPersonaAcontratar (uint id) public {
        Acuerdo memory _acuerdo = listAcuerdo[id];
        _acuerdo.checkPersonaAcontratar = !_acuerdo.checkPersonaAcontratar;
        listAcuerdo[id] = _acuerdo;
        emit checkModificadoPorPersonaAcontratar(id, _acuerdo.checkPersonaAcontratar);
    }

    function isTrueCheckAmbos (uint id) public view returns (bool){
        Acuerdo memory _acuerdo = listAcuerdo[id];
        if (_acuerdo.checkPersonaAcontratar && _acuerdo.checkPersonaQueContrata) { return true} //Ver esto
        else return false;
        

    function contratarPersona (uint _idPersona, uint _idAcuerdo) public payable{
        PersonaPostulada memory _personaPostulada = listPersonas[_idPersona];
        address payable direccionAPagar = _personaPostulada.owner;
        require(_personaPostulada.idPersona > 0 && _personaPostulada.idPersona <= cantPersonasInscriptas);
        if (isTrueCheck(_idAcuerdo);)

    }

}