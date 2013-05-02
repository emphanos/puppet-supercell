class user_citest {
    group {
        "citest" :
            ensure  => present;
    }

    user {
        "citest" :
            gid     => "citest",
            groups  => "civicrm",
            shell   => "/bin/bash",
            home    => "/home/citest",
            ensure  => present,
            require => [
                        Group["citest"],
                        Group["civicrm"],
                        ];
    }

    file {
        "/home/citest" :
            ensure      => directory,
            require     => User["citest"],
            owner       => "citest",
            group       => "citest";
        "/home/citest/.ssh" :
            ensure      => directory,
            require     => File["/home/citest"],
            owner       => "citest",
            group       => "citest";
    }

    ssh_authorized_key {
        "citest" :
            user        => "root",
            ensure      => present,
            require     => File["/home/citest/.ssh"],
            key         => "AAAAB3NzaC1yc2EAAAABIwAAAQEAqP2UqG/TIg1KfXom4LRbEPzVRbtB5QQN/fMWQW0jA+r4U/xYGa6hTBHt8V5yLifHL/uokSKvgUGONcOV5NgLA1R4aDe1himzev+udP+LiHbuLw/+9pR1pBlimfcCpHFKPGw5VIkMtM6BEfSa1qKgy8Dd3neVTeYyVZdM2zkJWedQj4uviRY4LySymxaFWm3rU6BUgvtut0/El027Oti93TWM+myzRzsH70dPmmPZyob4bFkdxanlML91qkskMMl74DkxWjpNuqEFYZt2KyDzUA9YSvmDIWXkeAopo1BxHwBHvoeSGSm/vma3smBFF0cq0Hoc+BbtunKNDNFIYorsnQ==",
            type        => "ssh-rsa",
            name        => "root@civihead";
    }
}

