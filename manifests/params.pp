# == Class: pyroscope::params
#
# Default parameters for the module Pyroscope observability platform.
class pyroscope::params {
    $config_hash    = {}
    $package_ensure = 'present'
    $validate_cmd   = '/usr/bin/pyroscope --modules=true'
}
