# Define SSH client configuration file path
$ssh_config_path = '/etc/ssh/ssh_config'

# Ensure SSH client configuration file exists
file { $ssh_config_path:
  ensure => present,
}

# Configure SSH client to use private key and refuse password authentication
file_line { 'Turn off passwd auth':
  path    => $ssh_config_path,
  line    => 'PasswordAuthentication no',
  match   => '^#?PasswordAuthentication',
  ensure  => present,
}

file_line { 'Declare identity file':
  path    => $ssh_config_path,
  line    => 'IdentityFile ~/.ssh/school',
  match   => '^#?IdentityFile',
  ensure  => present,
}

