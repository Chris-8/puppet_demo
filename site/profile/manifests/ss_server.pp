class profile::ssh_server {
  package { 'openssh-server':
    ensure => present,
  }
  service { 'sshd':
    ensure => 'running',
    enable => 'true',
  }
  ssh_authorized_key { 'root@master.puppet.vm':
    ensure  => present,
    user    => 'root',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCzdwLX4zrK/8OHav/sEYkRCcV+ryHk0dslsh+DS1lBSH2G50VUf1giRowbvVVbXPEeuM38wHxmpPFrb4bIKHg9m+3fUrowJl9HxkC3To6qO3ln1Sbavo4+S7lf1qYTFDp4bIP3tXn65+NByNlHfuR1YCFYWv8XgPj71NxM03KRufiPN29zLa4JT7SGtCk6PDeWlfxfLVAkHj2hnC+le/02ImlfJkT0clgvEanFI4J76C7m3xRGOu6LLeDeTT/GNwKEzz8oi5Fetr9IGWh4GP6Y/4CIbZgeOg92ULQF10Y6ItwWXE7TRb8zVWHqD3YtqKv7rk6fKS0sCQ4cyryZU9mh',
  }
}
