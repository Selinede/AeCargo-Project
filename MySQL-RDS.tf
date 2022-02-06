


resource "aws_db_instance" "sql" {
    identifier                = "sql"
    allocated_storage         = 5
    backup_retention_period   = 2
    backup_window             = "01:00-01:30"
    maintenance_window        = "sun:03:00-sun:03:30"
        engine                    = "mysql"
    engine_version            = "5.7"
    instance_class            = "db.t2.micro"
    name                      = "Selina_db1"
    username                  = "Selinaa"
    password                  = "Banker123"
    port                      = "3306"
    db_subnet_group_name      = aws_db_subnet_group.aecargo_db_subgrp.id
    vpc_security_group_ids    = [aws_security_group.ecs_seurity.id, aws_security_group.rds_securitygroup.id]
    skip_final_snapshot       = true
    final_snapshot_identifier = "Selinaa-end"
    publicly_accessible       = false
}




# DB Subnet

resource "aws_db_subnet_group" "aecargo_db_subgrp" {
    name = "aecargo_db_subgrp"

    subnet_ids  = [aws_subnet.Private_Subnet1.id, aws_subnet.Private_Subnet2.id]

    tags = {
        Name = "Db-subnet"
}
}
