class user_lobo {
    group {
        "lobo" :
            ensure  => present;
    }

    user {
        "lobo" :
            gid     => "lobo",
            groups  => "civicrm",
            shell   => "/bin/bash",
            home    => "/home/lobo",
            ensure  => present,
            require => [
                        Group["lobo"],
                        Group["civicrm"],
                        ];
    }

    file {
        "/home/lobo" :
            ensure      => directory,
            require     => User["lobo"],
            owner       => "lobo",
            group       => "lobo";
        "/home/lobo/.ssh" :
            ensure      => directory,
            require     => File["/home/lobo"],
            owner       => "lobo",
            group       => "lobo";
    }

    ssh_authorized_key {
        "lobo" :
            user        => "lobo",
            ensure      => present,
            require     => File["/home/lobo/.ssh"],
            key         => "AAAAB3NzaC1kc3MAAAEBAL1XSBzCFvldrOCHKni7daQJHQhC0Kg5Isce6N9ioBprVPLrZMmmN2MF62QdpyszvMSFh3eOaqxouyzdPCWvRz0HenPbrMohk//w8amk04QkRWgHQRimzPml4/tAxhmdKC5h/TrGqjHjKWcscTvyLjjTjR/xpn4i6qrCfhb4UOu9YvpVDU4lFuPw5cAAgBcsveRVu+Sha7s6lq43C9j16d818Fe05i5pXUTMF8p/L1fBSc4gYMVQRAr7uMLVp8upRrxUYwEOlAPUkW7H97uh59rVVPpYTXbFieYJWLgbSd2aicuq6r+FqLmyppEDhk/485/gEyXG+xv3W4kRCGe/DacAAAAVAI2WS3V//c63irAsZrlp+I/1iJW1AAABAHowW2wuh7mbw7yhsNL1cvIkroIgKQYzp7GM/SGk2DnT6SfHRoRY2nOG1oMdnsbC+Q5taYDiA4pz8oRzkoutd/1DnuFMzvo0TD4t1feLxZu1Te1IfWIxEF8qEVRRHKNK49HzZiU2bWJ7oYs33WlJ9SusAs8awrfeWlS3jwjmz/piCYjujONxnFFMlPEKqgyPcCfUddQ30N72JaCRk0yPzdiaCFbwAr6vtK0ywVpIs2o0H37iSDmWXx2JNWoexBW+iDX+KMlY23DER4Fc7LfrBX4+iZOyTlXI7S99bCTJB3ZILsq+KwtfbIzhV6zV+bTpTSqPmXS27yNl+DaH2C6GjikAAAEBALpV48KtR0eXYzh/0fAyJxbDmfP656fkAQJ4fptARNjFE9W7p3IGkysTndQlR53IhItulMNVACFf1p2JDVPcZAXGV9svz7ZuCZOHYxuiD8LrwfVF9fF55Vozj3rfOBd3922DO5gN2u5HYMHP2sy8GvJZxxmrwbHpvLuGSsUgTlmQ56L8FNpbwSB/wA/WieNmbIJTa5PL1JdvhYqndGcjEkODKe1Ac2d37DtYKEyjcu/HXAul1HjQu6q7wmnbuXbS2l6K4Qy5bRe55bOEWVEEaeQ44no6CB2FyyRsd8zAn7Q2iu/pGlV5ElwXPvSp7ayDI0pQ2XwJi5JRrHSw2QMBuGU=",
            type        => "ssh-dss",
            name        => "lobo@tasmania.local";
    }
}

