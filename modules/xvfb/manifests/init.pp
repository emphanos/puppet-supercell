class xvfb {
  package { "xvfb":
    ensure => present
  }

  # for screenshots
  package { "x11-apps":
    ensure => present,
  }

  # for screenshots
  package { "netpbm":
    ensure => present,
  }

  file { "take-screenshot.sh":
    ensure => file,
    path => "/usr/local/bin/take-screenshot.sh",
    source => "puppet:///modules/xvfb/take-screenshot.sh",
    owner => root,
    mode => 755,
  }

  file { "/etc/init.d/xvfb":
    ensure => file,
    source => "puppet:///modules/xvfb/init.sh",
    owner => root,
    mode => 755,
  }

  service { "xvfb":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => [Package['xvfb'], File['/etc/init.d/xvfb']],
    pattern => "Xvfb",
  }

  Package["xvfb"] -> File["/etc/init.d/xvfb"] -> Service["xvfb"]
}

