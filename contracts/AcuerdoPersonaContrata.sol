// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract AcuerdoPersonaContrata{
    address personaQueContrata;
    uint montoAcordadoContratante;
    bool checkPersonaQueContrata = false;
    
    event acuerdoFinalizado (address _owner, uint _monto, bool check);

    constructor(uint _monto, bool check){
        personaQueContrata = payable(msg.sender);
        montoAcordadoContratante = _monto;
        checkPersonaQueContrata = check;
        emit acuerdoFinalizado (payable(msg.sender), _monto, check);
    }

    function getInfo () public view returns(address, address, uint, bool){
        return (msg.sender, personaQueContrata,montoAcordadoContratante, checkPersonaQueContrata);
    }

}