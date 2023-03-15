class minecraft {
  file { '/opt/minecraft':
    ensure => directory,
  }
  file {'/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar',
  }
  yumrepo { 'packages-microsoft-com-prod':
    baseurl   => 'https://packages.microsoft.com/centos/7/prod',
    name     => 'packages-microsoft-com-prod',
    enabled   => 1,
    gpgcheck  => 1,
    gpgkey    => 'https://packages.microsoft.com/keys/microsoft.asc',
    sslverify => 1,
  }
  package { 'msopenjdk-17':
    #require => yumrepo['packages-microsoft-com-prod'],
    ensure => present,
  }
  file { '/opt/minecraft/eula.txt':
    ensure  => file,
    content => 'eula=true',
  }
  file { '/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
  service { 'minecraft':
    ensure  => running,
    enable => true
  }
}
