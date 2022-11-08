// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Acuerdo {
    uint public id = 0;

    mapping (uint => AcuerdoDePalabra) public listAcuerdos;

    constructor() payable {}

    enum Status {open, finalized}

    struct AcuerdoDePalabra {
        uint _id;
        address contratante;
        address payable contratado;
        string direccionAvisitar;
        string horarioDeVisita;
        string servicioArealizar;
        string descripcion;
        uint monto;
        bool checkContratante;
        bool checkContratado;
        Status status;
    }

    event acuerdoGenerado(uint _id, address _contratante, address payable _contratado, string _direccionAvisitar, string _horarioDeVisita, string _servicioArealizar,
        string _descripcion, uint _monto, bool _checkContratante, bool _checkContratado);
    event checkContratanteModificado (uint _id, address _contratante);
    event checkContratadoModificado(uint _id, address _contratado);
    event pagado (uint _id);

    function generarAcuerdo (address payable _contratado, string memory _direccionAvisitar, string memory _horarioDeVisita, string memory _servicioArealizar, string memory _descripcion,
                             uint _monto) public payable {
        require(msg.value == _monto && msg.value>0 && _monto>0);
        require(bytes(_direccionAvisitar).length > 0);
        require(bytes(_servicioArealizar).length > 0);
        require(bytes(_descripcion).length > 0);
        

        id++;
        listAcuerdos[id] = AcuerdoDePalabra(id, msg.sender, _contratado, _direccionAvisitar, _horarioDeVisita, _servicioArealizar, _descripcion, msg.value, false, false, Status.open);
        emit acuerdoGenerado(id, msg.sender,_contratado, _direccionAvisitar, _horarioDeVisita, _servicioArealizar, _descripcion, msg.value, false, false);
    }

    function getAcuerdo (uint _id) public view returns (uint,address,address,string memory,string memory,string memory,string memory,uint,bool,bool) {
        AcuerdoDePalabra memory _listAcuerdos = listAcuerdos[_id];

        return (_listAcuerdos._id, _listAcuerdos.contratante, _listAcuerdos.contratado, _listAcuerdos.direccionAvisitar, 
        _listAcuerdos.horarioDeVisita, _listAcuerdos.servicioArealizar, _listAcuerdos.descripcion, 
        _listAcuerdos.monto, _listAcuerdos.checkContratante, _listAcuerdos.checkContratado);
    }

    function getContratanteAcuerdo (uint _id) internal view returns (address) {
        AcuerdoDePalabra memory _listAcuerdos = listAcuerdos[_id];

        return (_listAcuerdos.contratante);
    }

    function getContratadoAcuerdo (uint _id) internal view returns (address) {
        AcuerdoDePalabra memory _listAcuerdos = listAcuerdos[_id];

        return (_listAcuerdos.contratado);
    }
   
    function checkContratante (uint _id) public{
        address dirContratanteContrato = getContratanteAcuerdo(_id);
        require(dirContratanteContrato == msg.sender);

        AcuerdoDePalabra memory _listAcuerdos = listAcuerdos[_id];
        _listAcuerdos.checkContratante = !_listAcuerdos.checkContratante;
        listAcuerdos[_id] = _listAcuerdos;
        emit checkContratanteModificado (_id, msg.sender);
    }
    
    function checkContratado(uint _id) public{
        address dirContratanteContrato = getContratadoAcuerdo(_id);
        require(dirContratanteContrato == msg.sender);

        AcuerdoDePalabra memory _listAcuerdos = listAcuerdos[_id];
        _listAcuerdos.checkContratado = !_listAcuerdos.checkContratado;
        listAcuerdos[_id] = _listAcuerdos;
        emit checkContratadoModificado (_id, msg.sender);
    }

    function pagar (uint _id) external payable {
        
        AcuerdoDePalabra memory _listAcuerdos = listAcuerdos[_id];
        require( _listAcuerdos.status == Status.open);
        require(_listAcuerdos.checkContratado == true && _listAcuerdos.checkContratante == true);
        uint monto = _listAcuerdos.monto;

        _listAcuerdos.monto = 0;
        listAcuerdos[_id] = _listAcuerdos;
        payable(_listAcuerdos.contratado).transfer(monto);
        _listAcuerdos.status = Status.finalized;
        listAcuerdos[_id] = _listAcuerdos;
        emit pagado (_id);
    }
}