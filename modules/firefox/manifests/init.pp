define firefox::install($version) {
  $url     = "http://releases.mozilla.org/pub/mozilla.org/firefox/releases/${version}/linux-i686/en-US/firefox-${version}.tar.bz2"
  $tarball = "/opt/seleniumkit/firefox-${version}.tar.bz2"

#  exec { "download-tarball":
#    #command   => "curl -L -o $tarball $url",
#    command   => "wget $url -O $tarball",
#    creates   => $tarball,
#    user      => root,
#    path      => "/usr/bin",
#    require   => [File['/opt/seleniumkit'], Package['wget']],
#    logoutput => on_failure
#  }

  file { "/etc/profile.d/firefox-${version}-path.sh":
    content => "export PATH=/opt/seleniumkit/firefox-${version}:\$PATH",
    mode => 755
  }

#  file { "/opt/seleniumkit/firefox-3.6.24.tar.bz2":
#   source => "puppet:///modules/firefox/firefox-3.6.24.tar.bz2",
#   ensure  => present,
#   owner   => "root",
#   group   => "root",
#   mode    => "0644";
#  }
#
#  file { "/opt/seleniumkit/firefox-8.0.1.tar.bz2":
#   source => "puppet:///modules/firefox/firefox-8.0.1.tar.bz2",
#   ensure  => present,
#   owner   => "root",
#   group   => "root",
#   mode    => "0644";
#  }

  file { "/opt/seleniumkit/firefox-${version}.tar.bz2":
   source => "puppet:///modules/firefox/firefox-${version}.tar.bz2",
   ensure  => present,
   owner   => "root",
   group   => "root",
   mode    => "0644";
  }


  exec { "install-firefox":
    cwd       => "/opt/seleniumkit",
    #command   => "tar jxf firefox-$source.tar.bz2",
    command   => "tar jxf $tarball; mv firefox firefox-${version}",
    #require   => Exec['download-tarball'],
    path      => ["/usr/bin", "/bin"],
    creates   => "/opt/seleniumkit/firefox/firefox",
    logoutput => on_failure
  }

  file { "/usr/local/bin/firefox":
    ensure => link,
    target => "/opt/seleniumkit/firefox/firefox"
  }

  #
  # for native events:
  #

#  file { "/usr/lib/libX11.so.6":
#    ensure => link,
#    target => "/usr/lib/i386-linux-gnu/libX11.so.6"
#  }

  file { "/usr/lib/libX11.so.6":
    ensure => link,
    target => "/usr/lib/libX11.so.6.3.0"
  }

  package { "pkg-config":
    ensure => installed,
  }

  package { "libgtk2.0-dev":
    ensure => installed,
  }

  package { "wget":
    ensure => installed,
  }

  package { "libibus-dev":
    ensure => installed,
  }

  package { "libc6-dev":
    ensure => installed,
  }
}

class firefox::v11 {
  firefox::install { "firefox-11":
    version => "11.0"
  }
}

class firefox::v9 {
  firefox::install { "firefox-9":
    version => "9.0.1"
  }
}

class firefox::v8 {
  firefox::install { "firefox-8":
    version => "8.0.1"
  }
}

class firefox::v3 {
  firefox::install { "firefox-3":
    version => "3.6.24"
  }
}
