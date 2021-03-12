project_id = "searce-playground"
network_name = "vpc-us-east-4-01"
region = "us-east4"
subnets = [
  {
    subnet_name           = "subnet-us-east-4-01-01"
    subnet_ip             = "10.13.0.0/20"
    subnet_region         = "us-east4"
    subnet_private_access = "true"
    subnet_flow_logs      = "false"
  }
]

secondary_ranges = {
        subnet-us-east-4-01-01 = [
            {
                range_name    = "pods-subnet"
                ip_cidr_range = "10.141.0.0/20"
            },

            {
                range_name    = "svc-subnet"
                ip_cidr_range = "10.122.0.0/20"
            }

        ]
    }


