provider "aws"{
    region  = "us-west-1"
    access_key = "AKIA324LT5IHWEVBFSGF"
    access_key = "BdrTsi8WBjm7jtCkK4yb4pHGba7jaZZk/nRoCoPo "

#create vpc 

resource "aws_vpc" "prod-vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "production"
    }

    route {
        ipv6_cidr_block  = "::/0"

    }

#creae the route table


resource "aws_route_table" "prod-route-table" {
    vpc_id = "$(aws_vpc.default.id)"
}

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "{$aws_internet_gateway.main.id}"
}

route {
    ipv6_cidr_block = "::/0"
    egress_only_gateway_id = "$(aws_egress_only_internet_gateway.foo.id)"}

tags = {
    Name = "main"
}

resource "aws_internet_gateway" "gw"{
    vpc_id = "$(aws_vpc.main.id)"
}
}
#internet gateway 
#vpc id passthrough ref the resource vpc aws  
#subnet 24 to gatewy defualt route all traffic to route 
#

#create a subnet weare internet 
#created a subnet assigned  to the route table 
#route table asosciation  

resource "aws_subnet" "subnet-1"{
    vpc_id = "aws_vpc.prod-vpc.id"
    cidr_block = "10.0.1.0/24"
    avialibilty_zone = "us-west-1"
    tags = {
        Name = "prod-subnet"
    }

}
resource "aws_route_table_association"{

subnet_id = "aws_subnet_subnet-1.id"
aws_route_table = "aws_route_table" "prod route tabe"
}


#avialibilty zone is a regoion for datacenters redudances 
#resource avlaivlibty


#create sec group 

resource "aws_security_group" "allow_web"{
    name = "allow_web_traffic"
    description = "Allow tls inbound traffic"
    vpc_id = "$(aws_vpc.main.id)"
}

#name of ports 
    ingress {
        description = "Https"
        from_port = 443
        to_port = 443
        protcol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }
    ingress{
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }
    ingress {
        description = "ssh"
        from_port = 22
        to_port = 22 
        protocol = "tcp"
        cidr_block = ["0.0.0.0/0"]
    }
    engress {
        from_port = 0 
        to_port = 0
        protcol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow_tls"
    }


#search for what protocols to use for instaces 

#network interface 
#assign users to ip to the  server


resource "aws_network_interface" "test"{
    subnet_id = "$(aws_subnet.public_a_id)"
    private_ips = ["10.0.0.50"]
    security_groups = ["$(aws_security_group.web.id)"]

    attacthment {
        instance = "$(aws_instance.test.id)"
        device index = 1
    }

    #assign an elastic ip to the network interrface created in step 

    resource "aws_eip" "one"{
        vpc = true 
        network_interace = "(aws_network_interface.multi-ip.id)"
        assoiate_with_private_ip = "10.0.0.10"
        depends_on = aws_internet_gateway.gw
    }

    
    #create ubuntu server

    resource "aws_instance" "web-server-instace"{
        ami  = ""
        instace_type = "t2.micro"
        avialibilty_zone = "us-west-1"
        key_name = "main-key"

        network_interace {
            device_index = 0 
            network_interace_id = "aws_network_interfac.web-server-nic.id"
        
    }

    user_data = <<-EOF
    #!/binbash
    sudo apt update -y
    sudo apt-install apache2 -y
    sudo systemct1 start apeche2
    sudo bash c 'echo your very first web server > /var/www/html/index.html'
    EOF
    tags = {
        Name = "web-server"
    }
}
