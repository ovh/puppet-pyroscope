# == Class: pyroscope::service
#
# Manage service associated to Pyroscope platform.
class pyroscope::service {
  $restart_cmd = $::pyroscope::restart_cmd

  service { 'pyroscope':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    restart    => $restart_cmd,
  }
}
