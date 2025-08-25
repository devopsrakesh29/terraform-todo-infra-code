kv_secrets = {

    db_username = {
    secret_name = "dbusername"
    secret_value = "dbadmin"
    }

    db_password = {
    secret_name = "dbpassword"
    secret_value = "DbPassword@123456"
    }
}

resource_groups = {
    rg01 = {
        rg_name = "todoinfra-rg"
        location = "centralindia"
    }
    rg02 = {
        rg_name = "todoinfra-rg02"
        location = "centralindia"
    }    
}