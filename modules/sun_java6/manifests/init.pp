class sun_java6 {

#  exec
#   { "/bin/echo \"sun-java6-plugin shared/accepted-sun-dlj-v1-1 boolean true\" | /usr/bin/debconf-set-selections":
#        alias     =>  "debconf-set-selections-sun-java6-plugin";
#
#      "/bin/echo \"sun-java6-bin shared/accepted-sun-dlj-v1-1 boolean true\" | /usr/bin/debconf-set-selections":
#        alias     =>  "debconf-set-selections-sun-java6-bin";
#
#      "/bin/echo \"sun-java6-jre shared/accepted-sun-dlj-v1-1 boolean true\" | /usr/bin/debconf-set-selections":
#        alias     =>  "debconf-set-selections-sun-java6-jre";
#
#    } 
#
#
#  package 
#  { 
#    "sun-java6-plugin":
#      require   => [ Exec["debconf-set-selections-sun-java6-plugin"],
#                     Package[sun-java6-bin],
#                     Package[sun-java6-jre] ],
#      ensure => installed;
#
#    "sun-java6-bin":
#      require   => Exec["debconf-set-selections-sun-java6-bin"],
#      ensure => installed;
#
#    "sun-java6-jre":
#      require   => Exec["debconf-set-selections-sun-java6-jre"],
#      ensure => installed;
#  }
#
#}
#
#####################################
#
#include sun_java6

  $release = regsubst(generate("/usr/bin/lsb_release", "-s", "-c"), '(\w+)\s', '\1')

  file { "partner.list":
    path => "/etc/apt/sources.list.d/partner.list",
    ensure => file,
    owner => "root",
    group => "root",
    content => "deb http://archive.canonical.com/ $release partner\ndeb-src http://archive.canonical.com/ $release partner\n",
    notify => Exec["aptitude-update"],
  }

  exec { "aptitude-update":
    command => "/usr/bin/aptitude update",
    refreshonly => true,
  }

  package { "debconf-utils":
    ensure => installed
  }

  exec { "agree-to-jdk-license":
    command => "/bin/echo -e sun-java6-jdk shared/accepted-sun-dlj-v1-1 select true | debconf-set-selections",
    unless => "debconf-get-selections | grep 'sun-java6-jdk.*shared/accepted-sun-dlj-v1-1.*true'",
    path => ["/bin", "/usr/bin"], require => Package["debconf-utils"],
  }

  exec { "agree-to-jre-license":
    command => "/bin/echo -e sun-java6-jre shared/accepted-sun-dlj-v1-1 select true | debconf-set-selections",
    unless => "debconf-get-selections | grep 'sun-java6-jre.*shared/accepted-sun-dlj-v1-1.*true'",
    path => ["/bin", "/usr/bin"], require => Package["debconf-utils"],
  }

  package 
  { 
   "sun-java6-jdk":
     require => [ File["partner.list"], Exec["agree-to-jdk-license"], Exec["aptitude-update"] ],
     ensure => latest;

   "sun-java6-jre":
    require => [ File["partner.list"], Exec["agree-to-jre-license"], Exec["aptitude-update"] ],
    ensure => latest;
  }

}

include sun_java6
