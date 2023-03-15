class minecraft {
  $mincraft_jar_url = 'https://piston-data.mojang.com/v1/objects/8f3112a1049751cc472ec13e397eade5336ca7ae/server.jar'
  $install_dir = '/opt/minecraft'
  yumrepo { 'packages-microsoft-com-prod':
    baseurl   => 'https://packages.microsoft.com/centos/7/prod',
    name     => 'packages-microsoft-com-prod',
    enabled   => 1,
    gpgcheck  => 1,
    gpgkey    => 'https://packages.microsoft.com/keys/microsoft.asc',
    sslverify => 1,
  }
  package { 'msopenjdk-17':
    require => Yumrepo['packages-microsoft-com-prod'],
    ensure => present,
  }
  file { $install_dir:
    ensure => directory,
  }
  file {"${$install_dir}/server.jar":
    ensure => file,
    source => $mincraft_jar_url,
    before => Service['minecraft'],
  }
  file { "${$install_dir}/eula.txt":
    ensure  => file,
    content => 'eula=true',
  }
  file { '/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraft/minecraft.service',
  }
  service { 'minecraft':
    ensure  => running,
    enable  => true,
    require => [Package['msopenjdk-17'],File["${$install_dir}/eula.txt"],File['/etc/systemd/system/minecraft.service']],
  }
}
