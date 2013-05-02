class user_youngjin {
    group {
        "youngjin" :
            ensure  => present;
    }

    user {
        "youngjin" :
            gid     => "youngjin",
            groups  => "civicrm",
            shell   => "/bin/bash",
            home    => "/home/youngjin",
            ensure  => present,
            require => [
                        Group["youngjin"],
                        Group["civicrm"],
                        ];
    }

    file {
        "/home/youngjin" :
            ensure      => directory,
            require     => User["youngjin"],
            owner       => "youngjin",
            group       => "youngjin";
        "/home/youngjin/.ssh" :
            ensure      => directory,
            require     => File["/home/youngjin"],
            owner       => "youngjin",
            group       => "youngjin";
    }

    ssh_authorized_key {
        "youngjin" :
            user        => "youngjin",
            ensure      => present,
            require     => File["/home/youngjin/.ssh"],
            key         => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC7XLsuFFGlsNTfPS4A1QNvWLpbWikuWAKtxrfQRV9IlVPJoWDRaid+FGByGvxtgBjdUZ+d7ciLaqBbOEp1AuDOCJKYZQHA7f2Mc6qOJTXM2mrOTDLg102m/hvRwrMyiS6BWUHca2Ur+ohrsfnC27JBuM2HioES6cLvkV00cnv46Uk07zbFMoXL8KBhx8rZfgwFQYurN9KnBollDcUy/GfhsCSJKWSyf6Q1r5EoS568TChNWOylPfnPphlnkICygZLvjc6GKRfnNAvMC7uZrYdQof45+k/AvIZuwHPJtulsjnDTt3sWeWiyQ19Xb4K3bo1qskUamkZ0VOMPxe4HgIcl",
            type        => "ssh-rsa",
            name        => "youngjin@holocene";
    }
}

