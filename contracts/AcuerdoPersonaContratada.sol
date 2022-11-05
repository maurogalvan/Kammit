// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract AcuerdoPersonaContratada{
    address personaQueContratada;
    uint montoAcordadoContratada;
    bool checkPersonacontrada = false;
    
    event acuerdoFinalizado (address _owner, uint _monto, bool check);

    constructor(uint _monto, bool check){
        personaQueContratada = payable(msg.sender);
        montoAcordadoContratada = _monto;
        checkPersonacontrada = check;
        emit acuerdoFinalizado (payable(msg.sender), _monto, check);
    }

}