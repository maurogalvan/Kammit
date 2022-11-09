const Acuerdo = artifacts.require("Acuerdo");

module.exports = function(deployer) {
    deployer.deploy(Acuerdo);
}