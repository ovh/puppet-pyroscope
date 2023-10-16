# == Class: pyroscope::config
#
# Configure Pyroscope platform.
# For a deep dive in pyroscope configuration see https://grafana.com/docs/pyroscope/latest/
class pyroscope::config {
  $config_dir        = $::pyroscope::config_dir
  $config_group      = $::pyroscope::config_group
  $config_owner      = $::pyroscope::config_owner
  $custom_args       = $::pyroscope::custom_args
  $log_dir_path      = $::pyroscope::log_dir_path
  $log_file_path     = $::pyroscope::log_file_path
  $log_file_mode     = $::pyroscope::log_file_mode
  $log_group         = $::pyroscope::log_group
  $log_level         = $::pyroscope::log_level
  $log_owner         = $::pyroscope::log_owner
  $log_to_file       = $::pyroscope::log_to_file
  $systemd_overrides = $::pyroscope::systemd_overrides
  $validate_cmd      = $::pyroscope::validate_cmd

  # Here we ensure that the configuration directory created
  # by the package has the expected owner, group and mode.
  file { $config_dir:
    ensure => 'directory',
    owner  => $config_owner,
    group  => $config_group,
    mode   => '0750',
  }

  # Write pyroscope configuration file.
  # as it is expected by package when upgrading.
  file { "${config_dir}/config.yml":
    ensure       => 'file',
    content      => to_yaml($::pyroscope::config_hash),
    owner        => $config_owner,
    group        => $config_group,
    mode         => '0640',
    validate_cmd => $validate_cmd,
  }

  # The default service file of pyroscope use an EnvironmentFile where the
  # configuration file to use is define. As per systemd behavior variables
  # defined in Environment are override per the ones from EnvironmentFile.
  # This means we cannot define the CONFIG_FILE environment with a drop-in

  case $::osfamily {
    'Debian': {
      $environment_file =  '/etc/default/pyroscope'
    }
    'RedHat':{
      $environment_file =  '/etc/sysconfig/pyroscope'
    }
    default: {
      $environment_file =  '/etc/default/pyroscope'
    }
  }

  file { $environment_file:
    ensure  => 'file',
    content => epp('pyroscope/systemd-default.epp', { 'config_dir' => $config_dir, 'custom_args' => $custom_args, 'log_level' => $log_level }),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
  }

  if $log_to_file {
    if (('Service' in $systemd_overrides) and ('StandardOutput' in $systemd_overrides['Service'] or 'StandardError' in $systemd_overrides['Service'])) {
      fail('log_to_file option is not compatible with systemd overrides: StandardOutput or StandardError')
    }
    else {
      $final_systemd_overrides = merge(
        $systemd_overrides,
        {
          'Service' => merge(
            $systemd_overrides['Service'],
            {
              'StandardOutput' => "append:${$log_dir_path}/${log_file_path}",
              'StandardError'  => 'inherit'
            }
          )
        }
      )
    }
  } else {
    $final_systemd_overrides = $systemd_overrides
  }

  # Overriding systemd service parameters
  # using dropin built-in. We will reuse the systemd unit delivered
  # by pyroscope package
  systemd::dropin_file { 'pyroscope-dropin.conf':
    unit    => 'pyroscope.service',
    content => epp('pyroscope/pyroscope-dropin.conf.epp', {
        'systemd_overrides' => $final_systemd_overrides
      }
    ),
  }

  if $log_to_file {
    # Create log file to be sure it get's the asked permissions
    file { "${log_dir_path}/${log_file_path}":
      ensure => 'present',
      owner  => $log_owner,
      group  => $log_group,
      mode   => $log_file_mode,
    }

    # Define logrotate policy for pyroscope log file.
    logrotate::rule { 'pyroscope':
      compress      => true,
      copytruncate  => true,
      create        => true,
      create_mode   => $log_file_mode,
      create_owner  => $log_owner,
      create_group  => $log_group,
      ifempty       => false,
      missingok     => true,
      delaycompress => false,
      path          => "${log_dir_path}/${log_file_path}",
      rotate        => 7,
      rotate_every  => 'daily',
    }
  }
}
