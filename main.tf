module "vm" {
    source = "./modules/virtual-machine"
    vm-config = {
        name = "${var.instance-name}"
        size = "${var.instance-size}"
        username = "${var.username}"
    }

    resource-group = module.vnet.resource-group

    location = module.vnet.location

    subnet-id = module.vnet.subnets.id
}

module "vnet" {
    source = "./modules/vnet"
    location = "${var.location}"
    resource-group-name = "${var.resource-group-name}-2"
    vnet-name = "${var.vnet-name}"
}
