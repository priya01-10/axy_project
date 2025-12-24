resource "aws_db_instance" "db_instance" {
  identifier              = var.name
  engine                  = "postgres"
  engine_version          = "15.4"
  instance_class          = var.instance_class
  allocated_storage       = 20

  db_name  = var.db_name
  username = var.username


  multi_az               = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.db.id]

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = false
  deletion_protection     = true

  storage_encrypted = true

  tags = {
    Name = var.name
  }
}

resource "aws_db_subnet_group" "db" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.name}-subnet-group"
  }
}

resource "aws_security_group" "db" {
  name   = "${var.name}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [] # locked down via app SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
