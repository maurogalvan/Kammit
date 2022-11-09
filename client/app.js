App = {
    contracts: {},
    init: async() => {
        await App.loadEthereum()
        await App.loadAccount()
        await App.loadContracts()
        App.rendercheckContratante()
        App.renderAcuerdo()
        App.render()
        App.renderTask()
        
    },

    loadEthereum: async () => {
        if (window.ethereum){
            App.web3Provider = window.ethereum;
            await window.ethereum.request({method: 'eth_requestAccounts'});
        } else if (window.web3) {
            web3 = new web3(windows.web3.currentProvider)
        }
        else {
            console.log('Ethereum NO existe')
        }
    },

    loadAccount: async() => {
        const account = await window.ethereum.request({method: 'eth_requestAccounts'});
        App.account = account[0]
    },

    loadContracts: async() => {
        const res = await fetch("Personas.json");
        const personaContractJSON = await res.json()

        const res1 = await fetch("Acuerdo.json");
        const acuerdoContractJSON = await res1.json()
        
        App.contracts.Personas = TruffleContract(personaContractJSON)
        App.contracts.Acuerdo = TruffleContract(acuerdoContractJSON)

        App.contracts.Personas.setProvider(App.web3Provider)
        App.contracts.Acuerdo.setProvider(App.web3Provider)

        App.Personas = await App.contracts.Personas.deployed()
        App.Acuerdo = await App.contracts.Acuerdo.deployed()
    },

    render: () => {
        console.log(App.account)
        document.getElementById('account').innerText = App.account
    },


    renderTask:  async() => {
        const taskCounter = await App.Personas.id()
        const taskCounterNumber = taskCounter.toNumber()

        let html = ''

        for (let i = 1; i <= taskCounterNumber; i++){
            const listPersonas = await App.Personas.listPersonas(i)
            const personaId = listPersonas[0]
            const personaDirecion = listPersonas[1]
            const personaEsProfesional = listPersonas[2]
            const personaNombre = listPersonas[3]
            const personaApellido = listPersonas[4]
            const personaHorDisponible = listPersonas[5]
            const personaUrlImage = listPersonas[5]
            const personaServicios = listPersonas[6]

            let taskElement = `
            <div class="card bg-dark rounded-0 mb-2">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>${personaNombre}</span>
                    <span>${personaApellido}</span>
                    <div class="form-check form-switch">
                        <input class="form-check-input"  >
                    </div>
                </div>
                <div class="card-body">
                    <span> ID: ${personaId}</span> <br>
                    <span>Direccion: ${personaDirecion}</span> <br>
                    <span>¿Es profesional?: ${personaEsProfesional}</span> <br>
                    <span>Horario disponible: ${personaHorDisponible}</span> <br>
                    <span><img src="${personaServicios}"></span> <br>
                    <span>Servicios: ${personaServicios}</span> <br>               
                </div>
            </div>`;
            html += taskElement;
        }
        
        document.querySelector('#personaList').innerHTML = html;
    },
    /*
    createPerson: async(_nombre, _apellido, _urlImagen) => {
        const result = await App.Personas.agregarPersona(_nombre, _apellido, _urlImagen, {from: App.account})
    },*/

    createPostulante: async(_nombre, _apellido, _horarioDisponible, _urlImagen) => {
        _serviciosPostulante = []
        const result = await App.Personas.agregarPostulante(_nombre, _apellido, _horarioDisponible, _urlImagen, _serviciosPostulante, {from: App.account})
    },

    generarAcuerdo: async(_contratado, _direccionAvisitar, _horarioDeVisita, _servicioArealizar, _descripcion, _monto) => {
        const result = await App.Acuerdo.generarAcuerdo(_contratado, _direccionAvisitar, _horarioDeVisita, _servicioArealizar, _descripcion, _monto, {from: App.account})
    },

    checkContratante: async(_id) => {
        const result = await App.Acuerdo.checkContratante(_id, {from: App.account});
    },
    toggleDoneContratante: async (element) => {
        const taskId = element.dataset.id;
        await App.Acuerdo.checkContratante(taskId, {
          from: App.account,
        });
        window.location.reload();
    },
    toggleDoneContratado: async (element) => {
        const taskId = element.dataset.id;
        await App.Acuerdo.checkContratado(taskId, {
          from: App.account,
        });
        window.location.reload();
    },

    rendercheckContratante: async() => {
        const Counter = await App.Acuerdo.id()
        const CounterNumber1 = Counter.toNumber()
        
        let html1 = ''

        for (let i = 1; i <= CounterNumber1; i++){
            
            const listAcuerdos = await App.Acuerdo.listAcuerdos(i)
            const acuerdoId = listAcuerdos[0]
            const direccionContratante = listAcuerdos[1]
            const direccionContratado = listAcuerdos[2]
            const direccionAvisitar = listAcuerdos[3]
            const horarioDeVisita = listAcuerdos[4]
            const servicioArealizar = listAcuerdos[5]
            const descripcion = listAcuerdos[6]
            const monto = listAcuerdos[7]
            const checkContratante = listAcuerdos[8]
            const checkContratado = listAcuerdos[9]

            let taskElement = `
            <div class="card bg-dark rounded-0 mb-2">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>${acuerdoId}</span>
                    
                    <div class="form-check form-switch">
                        <input class="form-check-input"  >
                    </div>
                </div>
                <div class="card-body">
                    <span>${direccionContratante}</span> <br>
                    <span>${direccionContratado}</span> <br>
                    <span> direccionAvisitar: ${direccionAvisitar}</span> <br>
                    <span>horarioDeVisita: ${horarioDeVisita}</span> <br>
                    <span>servicioArealizar: ${servicioArealizar}</span> <br>
                    <span>descripcion: ${descripcion}</span> <br>
                    <span>monto: ${monto} </span> <br> <br>
                    <input class="form-check-input" data-id="${acuerdoId}" type="checkbox" onchange="App.toggleDoneContratante(this)" ${
                        checkContratante === true && "checked"
                    }>
                    <span>checkContratante: ${checkContratante}</span> <br>    
                    <input class="form-check-input" data-id="${acuerdoId}" type="checkbox" onchange="App.toggleDoneContratado(this)" ${
                        checkContratado === true && "checked"
                    }>           
                    <span>checkContratado: ${checkContratado}</span> <br>
                </div>
                
            `;
            html1 += taskElement;
            if(checkContratado == true && checkContratante == true ){
                let aux = `
                <a class="btn btn-primary btn-lg"  onclick="App.pagar(formPagar[${acuerdoId}].value);" role="button"> Pagar </a>`
                html1 += aux;
            }
            let aux = `</div>`
            html1 += aux;
        }
        
        document.querySelector('#check').innerHTML = html1;

    },

    pagar: async(_id) => {
        console.log("entro")
    },
    checkContratado: async(_id) => {
        const result = await App.Acuerdo.checkContratado(_id, {from: App.account});
    },

    renderAcuerdo:  async() => {
        const Counter = await App.Acuerdo.id()
        const CounterNumber1 = Counter.toNumber()
        
        let html1 = ''

        for (let i = 1; i <= CounterNumber1; i++){
            const listAcuerdos = await App.Acuerdo.listAcuerdos(i)

            const acuerdoId = listAcuerdos[0]
            const direccionContratante = listAcuerdos[1]
            const direccionContratado = listAcuerdos[2]
            const direccionAvisitar = listAcuerdos[3]
            const horarioDeVisita = listAcuerdos[4]
            const servicioArealizar = listAcuerdos[5]
            const descripcion = listAcuerdos[6]
            const monto = listAcuerdos[7]
            const checkContratante = listAcuerdos[8]
            const checkContratado = listAcuerdos[9]

            let taskElement = `
            <div class="card bg-dark rounded-0 mb-2">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>${acuerdoId}</span>
                    
                    <div class="form-check form-switch">
                        <input class="form-check-input"  >
                    </div>
                </div>
                <div class="card-body">
                    <span>DIRECCION CONTRATANTE: ${direccionContratante}</span> <br>
                    <span>DIRECCION CONTRATADO: ${direccionContratado}</span>
                    <span> direccionAvisitar: ${direccionAvisitar}</span> <br>
                    <span>horarioDeVisita: ${horarioDeVisita}</span> <br>
                    <span>servicioArealizar: ${servicioArealizar}</span> <br>
                    <span>descripcion: ${descripcion}</span> <br>
                    <span>monto: ${monto} </span> <br>
                    <span>checkContratante: ${checkContratante}</span> <br>               
                    <span>checkContratante: ${checkContratado}</span> <br>  
                </div>
                
            </div>`;
            html1 += taskElement;
        }
        
        document.querySelector('#acuerdosList').innerHTML = html1;
    },

    getAcuerdo: async(_id) => {
        const result = await App.Acuerdo.getAcuerdo(uint, {from: App.account});
    },

    pagarCobrar: async(_id) => {
        const result = await App.Acuerdo.pagar(uint, {from: App.account});
    }



    

    
}
