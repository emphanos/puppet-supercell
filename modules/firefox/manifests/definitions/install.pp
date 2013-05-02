define firefox::install($version) {
  $url     = "http://releases.mozilla.org/pub/mozilla.org/firefox/releases/$version/linux-i686/en-US/firefox-$version.tar.bz2"
  $tarball = "/opt/seleniumkit/firefox.tar.bz2"

  exec { "download-tarball":
    command   => "curl -L -o $tarball $url",
    creates   => $tarball,
    user      => vagrant,
    path      => "/usr/bin",
    require   => [File['/opt/seleniumkit'], Package['curl']],
    logoutput => on_failure
  }

  file { "/etc/profile.d/firefox-path.sh":
    content => 'export PATH=/opt/seleniumkit/firefox:$PATH',
    mode => 755
  }

  exec { "install-firefox":
    cwd       => "/opt/seleniumkit",
    command   => "tar jxvf firefox.tar.bz2",
    require   => Exec['download-tarball'],
    path      => ["/usr/bin", "/bin"],
    creates   => "/opt/seleniumkit/firefox/firefox",
    logoutput => on_failure
  }

  #
  # for native events:
  #

  file { "/usr/lib/libX11.so.6":
    ensure => link,
    target => "/usr/lib/i386-linux-gnu/libX11.so.6"
  }

  package { "pkg-config":
    ensure => installed,
  }

  package { "libgtk2.0-dev":
    ensure => installed,
  }

  package { "libibus-dev":
    ensure => installed,
  }

  package { "libc6-dev-amd64":
    ensure => installed,
  }
}
