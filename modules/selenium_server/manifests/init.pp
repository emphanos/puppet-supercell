class selenium_server::common {
  $seleniumversion = "2.21.0"

  file { "/usr/local/selenium":
    ensure => directory;

    "/usr/local/selenium/selenium-server-standalone-${seleniumversion}.jar":
    ensure => present,
    source => "puppet:///modules/selenium_server/selenium-server-standalone-${seleniumversion}.jar",
  }
  file { "/usr/local/selenium/selenium-server-standalone.jar":
    ensure => link,
    target => "/usr/local/selenium/selenium-server-standalone-${seleniumversion}.jar",
  }
}


class selenium_server::hub inherits selenium_server::common {
  file {"/etc/init.d/selenium-server-hub":
    ensure => present,
    source => "puppet:///modules/selenium_server/hub_init.sh",
    mode => 0755;
  }

  service { "selenium-server-hub":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    subscribe => File["/etc/init.d/selenium-server-hub"],
    pattern => "selenium-server-standalone-${seleniumversion}.jar",
  }
  File["/etc/init.d/selenium-server-hub"] -> Service["selenium-server-hub"]
}

class selenium_server::node inherits selenium_server::common {
  file {"/etc/init.d/selenium-server-node":
    ensure => present,
    source => "puppet:///modules/selenium_server/node_init.sh",
    mode => 0755;
  }

  service { "selenium-server-node":
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    subscribe => File["/etc/init.d/selenium-server-node"],
    pattern => "selenium-server-standalone-${seleniumversion}.jar";
  }

}
