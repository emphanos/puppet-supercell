class supercell {
  group { "pe-puppet":
    ensure => "present",
  }

  file { "/etc/hosts.allow":
   #content => template("supercell/template/hosts.allow"),
   #content => template("../template/hosts.allow"),
   #content => template("supercell/hosts.allow"),
   #source => "civihead.osuosl.test:///modules/supercell/hosts.allow",
   source => "puppet:///modules/supercell/hosts.allow",
   ensure  => present,
   owner   => "root",
   group   => "root",
   mode    => "0644";
  }

  file { "/root/.bashrc":
   source => "puppet:///modules/supercell/bashrc",
   ensure  => present,
   owner   => "root",
   group   => "root",
   mode    => "0644";
  }

  file { "/root/.inputrc":
   source => "puppet:///modules/supercell/inputrc",
   ensure  => present,
   owner   => "root",
   group   => "root",
   mode    => "0644";
  }

  # Run apt-get update when anything beneath /etc/apt/ changes
  exec { "apt-get update":
    command => "/usr/bin/apt-get update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'";
  }

  file { "/opt/seleniumkit":
    ensure => directory,
    owner => root;
  }

  package { "python-software-properties":
    ensure => present
  }

  package { "htop":
    ensure => present
  }

  package { "subversion":
    ensure => present
  }

  package { "git-core":
    ensure => present
  }

  package { "phpunit":
    ensure => present
  }

  package { "php5":
    ensure => present
  }

  package { "hgsvn":
    ensure => present
  }

  package { "git-svn":
    ensure => present
  }

  package { "openjdk-6-jdk":
    ensure => present
  }

  package { "curl":
    ensure => present
  }

  package { "atop":
    ensure => present
  }

  package { "acl":
    ensure => present
  }

  package { "bash-completion":
    ensure => present
  }
}
