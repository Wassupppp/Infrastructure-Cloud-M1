provider "aws" {
  region = "us-east-1"
}

# ========== VPC 1 ==========
resource "aws_vpc" "OKI_VPC1" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "OKI_VPC1"
  }
}

resource "aws_internet_gateway" "OKI_IGW1" {
  vpc_id = aws_vpc.OKI_VPC1.id
  tags = {
    Name = "OKI_IGW1"
  }
}

resource "aws_subnet" "OKI_Public_Subnet1" {
  vpc_id                  = aws_vpc.OKI_VPC1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "OKI_Public_Subnet1"
  }
}

resource "aws_subnet" "OKI_Private_Subnet1" {
  vpc_id            = aws_vpc.OKI_VPC1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "OKI_Private_Subnet1"
  }
}

resource "aws_route_table" "OKI_Public_RT1" {
  vpc_id = aws_vpc.OKI_VPC1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.OKI_IGW1.id
  }

  tags = {
    Name = "OKI_Public_RT1"
  }
}

resource "aws_route_table_association" "OKI_Public_Assoc1" {
  subnet_id      = aws_subnet.OKI_Public_Subnet1.id
  route_table_id = aws_route_table.OKI_Public_RT1.id
}

# Security Group pour la bastion (SSH autorisé)
resource "aws_security_group" "OKI_SG_Bastion1" {
  name        = "OKI_SG_Bastion1"
  description = "Allow SSH from anywhere"
  vpc_id      = aws_vpc.OKI_VPC1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Instance bastion dans le subnet public
resource "aws_instance" "OKI_Bastion1" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 for us-east-1
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.OKI_Public_Subnet1.id
  vpc_security_group_ids = [aws_security_group.OKI_SG_Bastion1.id]
  associate_public_ip_address = true

  tags = {
    Name = "OKI_Bastion1"
  }
}

# Security Group pour l'instance privée : n'autorise que le port 80 depuis l'autre VPC
resource "aws_security_group" "OKI_SG_Private1" {
  name   = "OKI_SG_Private1"
  vpc_id = aws_vpc.OKI_VPC1.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"] # VPC2 CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OKI_SG_Private1"
  }
}

resource "aws_instance" "OKI_Private1" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.OKI_Private_Subnet1.id
  vpc_security_group_ids = [aws_security_group.OKI_SG_Private1.id]

  user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl start httpd
echo "<h1>Private Instance 1 - OKI</h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "OKI_Private1"
  }
}

# ========== VPC 2 ==========
resource "aws_vpc" "OKI_VPC2" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "OKI_VPC2"
  }
}

resource "aws_internet_gateway" "OKI_IGW2" {
  vpc_id = aws_vpc.OKI_VPC2.id
  tags = {
    Name = "OKI_IGW2"
  }
}

resource "aws_subnet" "OKI_Public_Subnet2" {
  vpc_id                  = aws_vpc.OKI_VPC2.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "OKI_Public_Subnet2"
  }
}

resource "aws_subnet" "OKI_Private_Subnet2" {
  vpc_id            = aws_vpc.OKI_VPC2.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "OKI_Private_Subnet2"
  }
}

resource "aws_route_table" "OKI_Public_RT2" {
  vpc_id = aws_vpc.OKI_VPC2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.OKI_IGW2.id
  }

  tags = {
    Name = "OKI_Public_RT2"
  }
}

resource "aws_route_table_association" "OKI_Public_Assoc2" {
  subnet_id      = aws_subnet.OKI_Public_Subnet2.id
  route_table_id = aws_route_table.OKI_Public_RT2.id
}

# Security Group pour la bastion VPC2
resource "aws_security_group" "OKI_SG_Bastion2" {
  name   = "OKI_SG_Bastion2"
  vpc_id = aws_vpc.OKI_VPC2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OKI_SG_Bastion2"
  }
}

resource "aws_instance" "OKI_Bastion2" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.OKI_Public_Subnet2.id
  vpc_security_group_ids      = [aws_security_group.OKI_SG_Bastion2.id]
  associate_public_ip_address = true

  tags = {
    Name = "OKI_Bastion2"
  }
}

resource "aws_security_group" "OKI_SG_Private2" {
  name   = "OKI_SG_Private2"
  vpc_id = aws_vpc.OKI_VPC2.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # VPC1 CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OKI_SG_Private2"
  }
}

resource "aws_instance" "OKI_Private2" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.OKI_Private_Subnet2.id
  vpc_security_group_ids = [aws_security_group.OKI_SG_Private2.id]

  user_data = <<EOF
#!/bin/bash
yum install -y httpd
systemctl start httpd
echo "<h1>Private Instance 2 - OKI</h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "OKI_Private2"
  }
}

# ========== VPC Peering ==========
resource "aws_vpc_peering_connection" "OKI_Peering" {
  vpc_id        = aws_vpc.OKI_VPC1.id
  peer_vpc_id   = aws_vpc.OKI_VPC2.id
  auto_accept   = true

  tags = {
    Name = "OKI_VPC_Peering"
  }
}

# Ajout routes VPC1 → VPC2
resource "aws_route" "OKI_RouteToVPC2" {
  route_table_id         = aws_vpc.OKI_VPC1.default_route_table_id
  destination_cidr_block = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.OKI_Peering.id
}

# Ajout routes VPC2 → VPC1
resource "aws_route" "OKI_RouteToVPC1" {
  route_table_id         = aws_vpc.OKI_VPC2.default_route_table_id
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.OKI_Peering.id
}
