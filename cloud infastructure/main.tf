#part one  overreview 
#modifying the code  
#if have a lot  of resources  in your infastrucure then could cause alot of bugs
# remove the code  for instances you need
#refere references 
#teraform files 


provider "aws"{
    region  = "us-west-1"
    access_key = "AKIA324LT5IHWEVBFSGF"
    access_key = "BdrTsi8WBjm7jtCkK4yb4pHGba7jaZZk/nRoCoPo "
}

#enter ami clients ec2 instance for connectivity 
#aws will not be aware  first server 
#ami deploy ubuntu server copy ami 
#going to look for all providers
#talk to the api aws to get confirmation from the server


#resource to the vpc name aws tags 
#tag for namming  your resource production vpc 
#subnet within vpc 
#specify aws name  

resource "aws_vpc" "first-vpc"{
    cidr block = "10.0.0.0/16"
    tag ={
        Name = "Main"
    }
}

resource "aws_vpc" "second-vpc"{
    cidr_block = "10.1.0.0/16"
    tags = {
        Name = "Dev"
    }
}

resource "aws_subnet" "subnet-2"{
    vpc_id = aws_vpc.first-vpc.id
    cidr_block = "10.1.1.0./24"
    tags = {
        Name = "dev-subnet"
    }
}

resource "aws_subnet" "subnet-1"{
    vpc_id = aws_vpc.second-vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "prod"
    }
}


resource "aws_instance" "my-first-server"{
    ami = ""
    instance_type = "t2.micro"  
    tags = {
        Name = "ubuntu"
    }

}

#back up code
##tags = {
    Name = "HelloWorld"
#}
#}
#
#resource "<providor>_<resource_type>" "name" {
#    key ="value"
#}
#terraform commands to modify your cloud  