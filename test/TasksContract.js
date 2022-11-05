const TaskContract = artifacts.require("TasksContract")

contract("TaskContract", () => {

    before(async ()=> {
        this.taskContract = await TaskContract.deployed()
    })
    it('migrate deployed successfully', async()=> {
        const address = this.taskContract.address
        assert.notEqual(address, null) ;
        assert.notEqual(address, undefined) ;
        assert.notEqual(address, 0x0) ;
        assert.notEqual(address, "") ;
    })

    it('get Tasks List', async () => {
        const tasksCounter = await this.taskContract.taskCounter()
        const task = await this.taskContract.tasks(tasksCounter)
        
        assert.equal(task.id.toNumber(), tasksCounter);
        assert.equal(task.title, "Mi primer tarea de ejemplo");
        assert.equal(task.description, "Tengo que hacer algo");
        assert.equal(task.done, false);
        assert.equal(tasksCounter, 1);

    })
})