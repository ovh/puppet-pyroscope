# == Class: pyroscope::install
#
# Install Pyroscope platform.
class pyroscope::install {
  $log_dir_path      = $::pyroscope::log_dir_path
  $log_dir_mode      = $::pyroscope::log_dir_mode
  $log_group         = $::pyroscope::log_group
  $log_owner         = $::pyroscope::log_owner
  $log_to_file       = $::pyroscope::log_to_file
  $manage_user       = $::pyroscope::manage_user
  $package_ensure    = $::pyroscope::package_ensure
  $user_extra_groups = $::pyroscope::user_extra_groups
  $user_home         = $::pyroscope::user_home
  $user_shell        = $::pyroscope::user_shell

  package { 'pyroscope':
    ensure => $package_ensure,
  }

  if $manage_user {
    # Temporary workaround as pyroscope package does not create the group
    # on its own: See: https://github.com/grafana/pyroscope/pull/2485
    group { 'pyroscope':
      ensure => 'present',
    }

    user { 'pyroscope':
      ensure     => 'present',
      system     => true,
      gid        => 'pyroscope',
      groups     => $user_extra_groups,
      shell      => $user_shell,
      home       => $user_home,
      managehome => true,
      before     => Package['pyroscope'],
    }
  }

  if $log_to_file {
    # Create dir for pyroscope logs
    file { $log_dir_path:
      ensure => 'directory',
      owner  => $log_owner,
      group  => $log_group,
      mode   => $log_dir_mode,
    }
  }
}
