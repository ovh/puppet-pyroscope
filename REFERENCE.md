# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`pyroscope`](#pyroscope): == Class: pyroscope  Install, configure, manage Pyroscope platform. For a deep dive in pyroscope configuration see https://grafana.com/docs/p
* [`pyroscope::config`](#pyroscope--config): == Class: pyroscope::config  Configure Pyroscope platform. For a deep dive in pyroscope configuration see https://grafana.com/docs/pyroscope/
* [`pyroscope::install`](#pyroscope--install): == Class: pyroscope::install  Install Pyroscope platform.
* [`pyroscope::params`](#pyroscope--params): == Class: pyroscope::params  Default parameters for the module Pyroscope observability platform.
* [`pyroscope::service`](#pyroscope--service): == Class: pyroscope::service  Manage service associated to Pyroscope platform.

## Classes

### <a name="pyroscope"></a>`pyroscope`

== Class: pyroscope

Install, configure, manage Pyroscope platform.
For a deep dive in pyroscope configuration see https://grafana.com/docs/pyroscope/latest/

#### Parameters

The following parameters are available in the `pyroscope` class:

* [`package_ensure`](#-pyroscope--package_ensure)
* [`manage_user`](#-pyroscope--manage_user)
* [`user_home`](#-pyroscope--user_home)
* [`user_shell`](#-pyroscope--user_shell)
* [`user_extra_groups`](#-pyroscope--user_extra_groups)
* [`config_dir`](#-pyroscope--config_dir)
* [`config_group`](#-pyroscope--config_group)
* [`config_hash`](#-pyroscope--config_hash)
* [`config_owner`](#-pyroscope--config_owner)
* [`custom_args`](#-pyroscope--custom_args)
* [`log_dir_path`](#-pyroscope--log_dir_path)
* [`log_dir_mode`](#-pyroscope--log_dir_mode)
* [`log_file_path`](#-pyroscope--log_file_path)
* [`log_file_mode`](#-pyroscope--log_file_mode)
* [`log_group`](#-pyroscope--log_group)
* [`log_level`](#-pyroscope--log_level)
* [`log_owner`](#-pyroscope--log_owner)
* [`log_to_file`](#-pyroscope--log_to_file)
* [`validate_cmd`](#-pyroscope--validate_cmd)
* [`restart_cmd`](#-pyroscope--restart_cmd)
* [`restart_on_change`](#-pyroscope--restart_on_change)
* [`systemd_overrides`](#-pyroscope--systemd_overrides)

##### <a name="-pyroscope--package_ensure"></a>`package_ensure`

Data type: `String`

Pyroscope version under the form X.X.X

Default value: `'present'`

##### <a name="-pyroscope--manage_user"></a>`manage_user`

Data type: `Boolean`

Boolean to specify if module should manage pyroscope user

Default value: `false`

##### <a name="-pyroscope--user_home"></a>`user_home`

Data type: `String`

Home directory for the managed user

Default value: `'/var/lib/pyroscope'`

##### <a name="-pyroscope--user_shell"></a>`user_shell`

Data type: `String`

Binary to use as shell for managed user

Default value: `'/sbin/nologin'`

##### <a name="-pyroscope--user_extra_groups"></a>`user_extra_groups`

Data type: `Array`

Additionnal groups the managed user should be connected to

Default value: `[]`

##### <a name="-pyroscope--config_dir"></a>`config_dir`

Data type: `String`

Directory to store the pyroscope configuration

Default value: `'/etc/pyroscope'`

##### <a name="-pyroscope--config_group"></a>`config_group`

Data type: `String`

Group to use for configuration resources

Default value: `'pyroscope'`

##### <a name="-pyroscope--config_hash"></a>`config_hash`

Data type: `Hash`

Hash containing the configuration keys to override

Default value: `{}`

##### <a name="-pyroscope--config_owner"></a>`config_owner`

Data type: `String`

Owner to use for configuration resources

Default value: `'pyroscope'`

##### <a name="-pyroscope--custom_args"></a>`custom_args`

Data type: `Array`

Additional arguments to set to the pyroscope process

Default value: `[]`

##### <a name="-pyroscope--log_dir_path"></a>`log_dir_path`

Data type: `String`

Directory to store pyroscope logs if log to file is enabled

Default value: `'/var/log/pyroscope'`

##### <a name="-pyroscope--log_dir_mode"></a>`log_dir_mode`

Data type: `String`

Mode of the directory used to store logs

Default value: `'0700'`

##### <a name="-pyroscope--log_file_path"></a>`log_file_path`

Data type: `String`

Filename to store pyroscope logs if log to file is enabled

Default value: `'pyroscope.log'`

##### <a name="-pyroscope--log_file_mode"></a>`log_file_mode`

Data type: `String`

Mode of the file used to store logs

Default value: `'0600'`

##### <a name="-pyroscope--log_group"></a>`log_group`

Data type: `String`

Group to use for log resources

Default value: `'root'`

##### <a name="-pyroscope--log_level"></a>`log_level`

Data type: `String`

Log level to use for process pyroscope

Default value: `'info'`

##### <a name="-pyroscope--log_owner"></a>`log_owner`

Data type: `String`

Owner to use for log resources

Default value: `'root'`

##### <a name="-pyroscope--log_to_file"></a>`log_to_file`

Data type: `Boolean`

Should log be kept in journald or sent to a dedicated file

Default value: `false`

##### <a name="-pyroscope--validate_cmd"></a>`validate_cmd`

Data type: `String`

Command use to validate configuration

Default value: `'/usr/bin/pyroscope --modules=true -config.file %'`

##### <a name="-pyroscope--restart_cmd"></a>`restart_cmd`

Data type: `String`

Command use to restart/reload process

Default value: `'/bin/systemctl restart pyroscope'`

##### <a name="-pyroscope--restart_on_change"></a>`restart_on_change`

Data type: `Boolean`

Should the process be restarted on configuration changes

Default value: `true`

##### <a name="-pyroscope--systemd_overrides"></a>`systemd_overrides`

Data type: `Hash`

List of systemd parameters to override

Default value:

```puppet
{
        'Service' => {
            # Pyroscope needs to open quite a lot of socket, this value seems widely used for high traffic softwares.
            'LimitNOFILE' => '1048576',
        },
    }
```

### <a name="pyroscope--config"></a>`pyroscope::config`

== Class: pyroscope::config

Configure Pyroscope platform.
For a deep dive in pyroscope configuration see https://grafana.com/docs/pyroscope/latest/

### <a name="pyroscope--install"></a>`pyroscope::install`

== Class: pyroscope::install

Install Pyroscope platform.

### <a name="pyroscope--params"></a>`pyroscope::params`

== Class: pyroscope::params

Default parameters for the module Pyroscope observability platform.

### <a name="pyroscope--service"></a>`pyroscope::service`

== Class: pyroscope::service

Manage service associated to Pyroscope platform.
